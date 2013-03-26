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
SIZES="100 200 300 400 500 600 700 800 900 1000"

# Benchmarking loop
for prog in nu zu; do
for type in cpu cuda; do
for bt in nobt backtrack; do
for size in $SIZES; do
	FLAGS="`echo -DLOOPS=$LOOPS -D$prog -D$type -D$bt -DSIZE=$size | tr '[:lower:]' '[:upper:]'`";
	if [ "$bt" = "yes" ]; then FLAGS="$FLAGS -DBACKTRACK"; fi
	if [ "$type" = "cuda" ]; then $CUDA/bin/nvcc $NVFLAGS $CCFLAGS $FLAGS $prog.cu -c -o bin/$prog.o;
	else g++ $CCFLAGS $FLAGS $prog.c -c -o bin/$prog.o; fi
	g++ wrapper.c $CCFLAGS $FLAGS -c -o bin/wrapper.o
	g++ $LDFLAGS bin/wrapper.o bin/librna.o bin/$prog.o -o bin/$prog
	./bin/$prog
done
done
done
done

#      case("c",_) =>   run("g++ "+ccFlags+" "+f+".c -c -o "+f+"_c.o") // gcc fails to link properly with nvcc object files
#      case("cpp",_) => run("g++ "+ccFlags+" "+f+".cpp -c -o "+f+"_cpp.o")
#      case("cu",_) =>  run(cudaPath+"/bin/nvcc "+cudaFlags+" "+ccFlags+" "+f+".cu -c -o "+f+"_cu.o")
#    override val outPath = "bin"
#    override val cudaPath = "/usr/local/cuda"
#    override val cudaFlags = "-m64 -arch=sm_30" // --ptxas-options=-v
#    override val ccFlags = "-O3 -I/System/Library/Frameworks/JavaVM.framework/Headers"
#    override val ldFlags = "-L"+cudaPath+"/lib -lcudart -shared -Wl,-rpath,"+cudaPath+"/lib"
