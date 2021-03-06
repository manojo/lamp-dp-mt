#!/bin/sh

if [ "$OSTYPE" = "darwin" ]; then
	CCARGS="-arch=sm_30 -O2 --linker-options -rpath,/usr/local/cuda/lib"
	EXEC="./test"
else
	CCARG="-arch=sm_21 -O2"
	EXEC="optirun ./test"
fi

nvcc $CCARGS ns_test.cu -DSH_RECT -o test && $EXEC
nvcc $CCARGS ns_test.cu -DSH_TRI -o test && $EXEC
nvcc $CCARGS ns_test.cu -DSH_PARA -o test && $EXEC
