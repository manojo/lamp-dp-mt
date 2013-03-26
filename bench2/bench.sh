#!/bin/sh

CUDA="/usr/local/cuda"
CCFLAGS="-O3 -I../src/librna"
NVFLAGS="-m64 -arch=sm_30"
LDFLAGS="-L$CUDA/lib -lcudart -Wl,-rpath,$CUDA/lib"

cd `dirname $0`; mkdir -p bin;

# Cleanup
if [ "$1" = "clean" ]; then rm bin/*; exit; fi

# Build LibRNA
if [ ! -f bin/librna.o ]; then
  g++ $CCFLAGS librna.c -c -o bin/librna.o
fi

# Benchmarking setup

LOOPS=25; # Number of tests
SIZES="100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2200 2400 2600 2800 3000 3200 3400 3600 3800 4000"

# Benchmarking loop
for prog in nu zu; do
for type in cpu cuda; do
for bt in nobt backtrack; do
for size in $SIZES; do
	FLAGS="`echo -DLOOPS=$LOOPS -D$prog -D$type -D$bt -DSIZE=$size | tr '[:lower:]' '[:upper:]'`";
	if [ "$bt" = "yes" ]; then FLAGS="$FLAGS -DBACKTRACK"; fi
	if [ "$type" = "cuda" ]; then $CUDA/bin/nvcc -DLIBRNA='"../src/librna/"' $NVFLAGS $CCFLAGS $FLAGS $prog.cu -c -o bin/$prog.o;
	else g++ -DLIBRNA='"../src/librna/"' $CCFLAGS $FLAGS $prog.c -c -o bin/$prog.o; fi
	g++ wrapper.c $CCFLAGS $FLAGS -c -o bin/wrapper.o
	g++ $LDFLAGS bin/wrapper.o bin/librna.o bin/$prog.o -o bin/$prog
	./bin/$prog
done
done
done
done
