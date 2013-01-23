#!/bin/sh

CCARGS="-arch=sm_30 -O2 -m64 --linker-options -rpath,/usr/local/cuda/lib"

for sz in 64 96 128 192 256 384 512 768 1024 1536 2048 3072 4096 6144 8192; do
	nvcc $CCARGS test.cu -DM_W="$sz"UL -DM_H="$sz"UL -DSH_RECT -o test && ./test
	nvcc $CCARGS test.cu -DM_W="$sz"UL -DM_H="$sz"UL -DSH_TRI -o test && ./test
done
