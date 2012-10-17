#!/bin/sh
nvcc -arch=sm_30 -m64 -O2 --linker-options -rpath,/usr/local/cuda/lib ns_test.cu -DSH_RECT -o test && ./test
nvcc -arch=sm_30 -m64 -O2 --linker-options -rpath,/usr/local/cuda/lib ns_test.cu -DSH_TRI -o test && ./test
nvcc -arch=sm_30 -m64 -O2 --linker-options -rpath,/usr/local/cuda/lib ns_test.cu -DSH_PARA -o test && ./test
