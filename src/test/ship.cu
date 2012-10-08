#include "include/common.h"

#define OP(a,b,idx) { int d=a[idx]-b[idx]; a[idx]+=b[idx]; b[idx]=d<0?-d:d; }

__global__ void fun(int* a, int* b, unsigned size) {
	unsigned idx = threadIdx.x + blockIdx.x*blockDim.x + blockIdx.y*blockDim.x*gridDim.x;
	if (idx<size) { OP(a,b,idx) }
}

__global__ void fun1(int* a, int* b, unsigned size) {
	unsigned idx = threadIdx.x + blockIdx.x*blockDim.x + blockIdx.y*blockDim.x*gridDim.x;
	if (idx==0) for (unsigned i=0;i<size;++i) { OP(a,b,i) }

}

int main(int argc,char** argv) {
	cudaDeviceReset();
	const unsigned size=1<<22; // 3<<24 = max can be reserved for 512MB GPU
	const unsigned int ms=size*sizeof(int);

	// 3<<24 = 48M pairs of (4+4) chars => 384Mb data to and back from GPU
	// Note that it goes faster with -d64 on my CPU (!)

	int* ca = (int*)malloc(ms);
	int* cb = (int*)malloc(ms);
	int* ga; cuErr(cudaMalloc(&ga,ms));
	int* gb; cuErr(cudaMalloc(&gb,ms));

for (int i=0;i<10;++i) {
	struct timeval ts,te;
	gettimeofday(&ts, NULL);
	for (unsigned i=0;i<size;++i) { OP(ca,cb,i) }

	gettimeofday(&te, NULL);
	printf("CPU time: %.3f ms\n", (float)( 1000.0*(te.tv_sec-ts.tv_sec) + 0.001*(te.tv_usec-ts.tv_usec) ) );

	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));

	// Test 1: forth and back memory transfer
	gettimeofday(&ts, NULL);
	cuPut(ca,ga,ms,stream);
	cuPut(cb,gb,ms,stream);
	fun<<<size/32, 32, 0, stream>>>(ga,gb,size);
	cuGet(ca,ga,ms,stream);
	cuGet(cb,gb,ms,stream);
	cuSync(stream);
	gettimeofday(&te, NULL);
	printf("GPU time1: %.3f ms\n", (float)( 1000.0*(te.tv_sec-ts.tv_sec) + 0.001*(te.tv_usec-ts.tv_usec) ) );

	// Test 2: backtrack on GPU
	gettimeofday(&ts, NULL);
	fun1<<<1, 1, 0, stream>>>(ga,gb,size);
	cuSync(stream);
	gettimeofday(&te, NULL);
	printf("GPU time2: %.3f ms\n", (float)( 1000.0*(te.tv_sec-ts.tv_sec) + 0.001*(te.tv_usec-ts.tv_usec) ) );
}

	free(ca);
	free(cb);
	cudaFree(ga);
	cudaFree(gb);

	cudaDeviceReset();
	return 0;
}


/*
With -m64
CPU time: 330.254 ms <- cold caches
GPU time: 511.160 ms
CPU time: 110.565 ms
GPU time: 510.759 ms
CPU time: 106.342 ms
GPU time: 374.137 ms
CPU time: 110.514 ms
GPU time: 285.962 ms
CPU time: 105.509 ms
GPU time: 286.003 ms
CPU time: 105.665 ms
GPU time: 286.128 ms
CPU time: 106.243 ms
GPU time: 285.868 ms
CPU time: 108.147 ms
GPU time: 285.921 ms
CPU time: 105.941 ms
GPU time: 285.827 ms
CPU time: 107.504 ms
GPU time: 285.893 ms <- hot caches 2.6x slowdown vs CPU

Without -m64
CPU time: 417.344 ms
GPU time: 511.177 ms
CPU time: 149.060 ms
GPU time: 510.771 ms
CPU time: 149.459 ms
GPU time: 360.264 ms
CPU time: 147.718 ms
GPU time: 286.457 ms
CPU time: 147.381 ms
GPU time: 285.966 ms
CPU time: 150.956 ms
GPU time: 283.353 ms
CPU time: 146.627 ms
GPU time: 283.340 ms
CPU time: 149.717 ms
GPU time: 283.385 ms
CPU time: 146.716 ms
GPU time: 283.412 ms
CPU time: 146.732 ms
GPU time: 286.180 ms <- 1.95x slowdown vs CPU

fun() only, -m64
CPU time: 332.379 ms
GPU time: 0.062 ms
CPU time: 104.286 ms
GPU time: 0.027 ms
CPU time: 107.368 ms
GPU time: 0.025 ms
CPU time: 104.345 ms
GPU time: 0.028 ms
CPU time: 104.347 ms
GPU time: 0.027 ms
CPU time: 103.969 ms
GPU time: 0.026 ms
CPU time: 115.863 ms
GPU time: 0.025 ms
CPU time: 132.301 ms
GPU time: 0.026 ms
CPU time: 126.471 ms
GPU time: 0.027 ms
CPU time: 107.523 ms
GPU time: 0.024 ms
*/