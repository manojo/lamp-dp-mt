#!/bin/sh
if [ "$OSTYPE" = "darwin" ]; then
	CCARGS="-arch=sm_30 -O2 --linker-options -rpath,/usr/local/cuda/lib"
	EXEC="./test"
else
	CCARG="-arch=sm_21 -O2"
	EXEC="optirun ./test"
fi

if [ "$1" = "cc" ]; then
	# Scala CUDA/C compiler
	mkdir -p bin
	fsc -deprecation -d bin CCompiler.scala && scala -cp bin TestCCompiler
	rm -r bin/*.class bin/*.o

elif [ "$1" = "cpp" ]; then
	# plain C++
	echo "#include \"test.cu\"" > test.cpp
	g++ -Wall -O2 test.cpp -o test -DSH_RECT && ./test
	g++ -Wall -O2 test.cpp -o test -DSH_TRI && ./test
	g++ -Wall -O2 test.cpp -o test -DSH_PARA && ./test
	rm test.cpp
	rm test
else
	# cuda C++
	nvcc $CCARGS test.cu -DSH_RECT -o test && $EXEC
	nvcc $CCARGS test.cu -DSH_TRI -o test && $EXEC
	nvcc $CCARGS test.cu -DSH_PARA -o test && $EXEC
	rm test
fi

