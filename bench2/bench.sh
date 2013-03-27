#!/bin/sh

CUDA="/usr/local/cuda"
if [ "$OSTYPE" = "darwin" ]; then
	LIBRNA="../src/librna/"
	CCFLAGS="-O3 -I$LIBRNA"
	NVFLAGS="-m64 -arch=sm_30"
	LDFLAGS="-L$CUDA/lib -lcudart -Wl,-rpath,$CUDA/lib"
else
	LIBRNA="./"
	CCFLAGS="-O3 -I$LIBRNA"
	NVFLAGS="-m64 -arch=sm_20"
	LDFLAGS="-L$CUDA/lib64 -lcudart -Wl,-rpath,$CUDA/lib64"
fi

cd `dirname $0`; mkdir -p bin;

if [ "$1" = "push" ]; then
	tar --exclude '._*' -czf bench2.tgz bench.sh *.c *.h *.cu -C $LIBRNA librna_impl.h vienna
	# ssh manohar@ppl.stanford.edu -L 22000:tflop1.stanford.edu:22 -L 22001:tflop2.stanford.edu:22
	for port in 22000 22001; do
		scp -o Port=$port bench2.tgz manohar@localhost:/home/manohar
		ssh -p $port manohar@localhost 'rm -r bench2; mkdir bench2; tar -C bench2 -xzf bench2.tgz; rm bench2.tgz'
	done
	rm bench2.tgz
	exit
fi

# Cleanup
if [ "$1" = "clean" ]; then rm bin/*; exit; fi

# Build LibRNA
if [ ! -f bin/librna.o ]; then
  g++ $CCFLAGS librna.c -c -o bin/librna.o
fi

if [ "$1" = "check" ]; then
	# program
	prog=zu
	FLAGS="`echo -DLOOPS=1 -D$prog -DCPU -DBACKTRACK -DSIZE=100 -DCHECK | tr '[:lower:]' '[:upper:]'`";
	g++ -DLIBRNA='"'$LIBRNA'"' $CCFLAGS $FLAGS $prog.c -c -o bin/$prog.o;
	g++ wrapper.c $CCFLAGS $FLAGS -c -o bin/wrapper.o
	g++ $LDFLAGS bin/wrapper.o bin/librna.o bin/$prog.o -o bin/$prog
	./bin/$prog
	# generator
	g++ $CCFLAGS gen.c -o bin/gen
	bin/gen 100 0 | ${LIBRNA}rfold
	exit;
fi

# Benchmarking setup

LOOPS=25; # Number of tests
SIZES="100 200 300 400 500 600 700 800 900 1000"
#SIZES="100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000"

# Benchmarking loop
run_bench() {
	FLAGS="`echo -DLOOPS=$LOOPS -D$prog -D$type -D$bt -DSIZE=$size | tr '[:lower:]' '[:upper:]'`";
	if [ "$type" = "cuda" ]; then $CUDA/bin/nvcc -DLIBRNA='"'$LIBRNA'"' $NVFLAGS $CCFLAGS $FLAGS $prog.cu -c -o bin/$prog.o;
	else g++ -DLIBRNA='"'$LIBRNA'"' $CCFLAGS $FLAGS $prog.c -c -o bin/$prog.o; fi
	g++ wrapper.c $CCFLAGS $FLAGS -c -o bin/wrapper.o
	g++ bin/wrapper.o bin/librna.o bin/$prog.o $LDFLAGS -o bin/$prog
	./bin/$prog
}

if [ "$1" = "l" ]; then
	type="cpu"; prog="lms"; bt="nobt"
	for size in $SIZES; do run_bench; done
elif [ "$1" = "h" -o "$1" = "r" ]; then # Haskell ADP fusion
	g++ $CCFLAGS gen.c -o bin/gen
	for size in $SIZES; do
		i=0; echo "% size = $size"
		while [ "$i" -ne "$LOOPS" ]; do
			if [ "$1" = "h" ]; then bin/gen $size $i | time --format=%E /home/manohar/cabal-dev/bin/RNAFold >/dev/null
			else bin/gen $size $i | time --format=%E /home/manohar/vienna/RNAfold -d2 --noLP --noPS >/dev/null; fi
			i=`expr $i + 1`;
		done
	done
else
	for type in cpu cuda; do
		for prog in nu zu; do
			for bt in nobt backtrack; do
				for size in $SIZES; do
					run_bench
				done
			done
		done
	done
fi
