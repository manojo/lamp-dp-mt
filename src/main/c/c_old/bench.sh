#!/bin/sh

CCARGS="-arch=sm_30 -m64 -O2 --linker-options -rpath,/usr/local/cuda/lib"

#
for s in 128 256 512 1024 2048 4096 8192; do
#	nvcc $CCARGS test.cu -DSH_RECT -DM_W="$s"LU -DM_H="$s"LU -o test && ./test
	nvcc $CCARGS test.cu -DSH_TRI -DM_W="$s"LU -DM_H="$s"LU -o test && ./test
done
