#!/bin/sh

CCARGS="-arch=sm_30 -O2 -m64 --linker-options -rpath,/usr/local/cuda/lib"

for sz in 128 256 512 1024 2048 4096 8192; do
	nvcc $CCARGS test.cu -DM_W="$sz"UL -DM_H="$sz"UL -DSH_RECT -o test && ./test
	nvcc $CCARGS test.cu -DM_W="$sz"UL -DM_H="$sz"UL -DSH_TRI -o test && ./test
done
