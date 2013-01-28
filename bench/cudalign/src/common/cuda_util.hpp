#pragma once

#include "../common/cudalign.hpp"

int tempIntCuda(int* var);
void deallocCuda(void* var, int size, void* out);
void* allocCuda0(int size);
void* allocCuda(void* in, int size);
unsigned char* allocCudaSeq(Sequence* seq);
void printDevProp(int deviceId, FILE* file=stdout);
void printDevMem(FILE* file=stdout);
void printGPUDevices(FILE* file=stdout);
cudaDeviceProp selectGPU(int id, FILE* file=stdout);
int getGPUProportion(int* proportion, int n);

/*unsigned char* allocCudaSeq(Sequence* seq, int offset);
unsigned char* allocCudaSeqRev(Sequence* seq);
unsigned char* allocCudaSeqRev(Sequence* seq, int offset);*/
