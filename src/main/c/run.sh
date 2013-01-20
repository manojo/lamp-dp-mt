#!/bin/sh

CCARGS="-arch=sm_30 -O2 --linker-options -rpath,/usr/local/cuda/lib -m64"
#if [ "$OSTYPE" != "darwin" ]; then CCARGS="-arch=sm_20 -O2"; EXEC="optirun ./test"; fi

for sz in 128 256 512 1024 2048 4096 8192; do
	nvcc $CCARGS test.cu -DM_W="$sz"LU -DM_H="$sz"LU -DSH_RECT -o test && ./test
	nvcc $CCARGS test.cu -DM_W="$sz"LU -DM_H="$sz"LU -DSH_TRI -o test && ./test
#	nvcc $CCARGS test.cu -DM_W="$sz"LU -DM_H="$sz"LU -DSH_PARA -o test && ./test
done
