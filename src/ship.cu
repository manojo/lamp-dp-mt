#include <stdio.h>
#include <assert.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>


// This is a performance tes for shipping data to GPU

#include "mrand.h"

#define _inline __attribute__((unused)) static inline
#define ASSERT(cond) extern int __assert__[1-2*(!(cond))];

// -----------------------------------------------------------------------------

#define cuErr(err) (cudaError(err,__FILE__,__LINE__))
#define cuSync(stream) cuErr(cudaStreamSynchronize(stream))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
_inline void cudaError(cudaError_t err, const char *file,  int line) { if (err!=cudaSuccess) { fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); exit(EXIT_FAILURE); } }
_inline void cuInfo(bool full=true) {
	int deviceCount=0; cudaError_t err=cudaGetDeviceCount(&deviceCount);
	if (err==38 || deviceCount==0) { fprintf(stderr,"No CUDA device\n"); exit(EXIT_FAILURE); }
	else if (err!=cudaSuccess) { fprintf(stderr,"CUDA error %d: %s.\n", err, cudaGetErrorString(err)); exit(EXIT_FAILURE); }
	int driverVersion=0, runtimeVersion=0; cudaDriverGetVersion(&driverVersion); cudaRuntimeGetVersion(&runtimeVersion);
	printf("Found %d CUDA device(s), driver %d.%d, runtime %d.%d.\n", deviceCount, driverVersion/1000, driverVersion%100, runtimeVersion/1000, runtimeVersion%100);
	for (int dev=0; dev<deviceCount; ++dev) {
		cudaDeviceProp prop; cudaGetDeviceProperties(&prop, dev);
		cudaDeviceReset();
		printf("- Device %d: '%s' (capability %d.%d, watchdog %s)\n", dev, prop.name, prop.major, prop.minor, prop.kernelExecTimeoutEnabled?"on":"off");
		if (full) {
			printf("    - Memory    : %dMb @ %dMhz mapHost=%d, unifiedAddr=%d, asyncCopy=%d\n",(int)round(prop.totalGlobalMem/1048576.0),
				prop.memoryClockRate>>10,prop.canMapHostMemory,prop.unifiedAddressing,prop.asyncEngineCount);
			int m=prop.computeMode; const char* mode=(m==0?"default":(m==1?"exclusive":(m==2?"prohibited":"exclusiveProcess")));
			printf("    - Processors: %d @ %dMHz, maxThreads=%d, warp=%d, concurrency=%d, mode=%s\n",prop.multiProcessorCount,
				prop.clockRate>>10,prop.maxThreadsPerMultiProcessor,prop.warpSize,prop.concurrentKernels,mode);
			printf("    - Limits    : %d regs/block, %ldK sharedMem/proc, %d thr/block %d thr/proc, %d blocks\n",prop.regsPerBlock,
				prop.sharedMemPerBlock>>10,prop.maxThreadsPerBlock,prop.maxThreadsPerMultiProcessor,prop.maxGridSize[0]);
		}
	}
}


#define OP(a,b,idx) { int d=a[idx]-b[idx]; a[idx]+=b[idx]; b[idx]=d<0?-d:d; }

__global__ void fun(int* a, int* b, unsigned size) {
	unsigned idx = threadIdx.x + blockIdx.x*blockDim.x + blockIdx.y*blockDim.x*gridDim.x;
	if (idx<size) { OP(a,b,idx) }
}

int main(int argc,char** argv) {
	const unsigned size=3<<24; // max for 512MB GPU
	const unsigned int ms=size*sizeof(int);

	// 3<<24 = 48M pairs of (4+4) chars => 384Mb data to and back from GPU
	// Note that it goes faster with -d64 on my CPU (!)

	int* ca = (int*)malloc(ms);
	int* cb = (int*)malloc(ms);
	int* ga; cuErr(cudaMalloc(&ga,ms));
	int* gb; cuErr(cudaMalloc(&gb,ms));

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

for (int i=0;i<10;++i) {
	struct timeval ts,te;
	gettimeofday(&ts, NULL);
	for (unsigned i=0;i<size;++i) { OP(ca,cb,i) }

	gettimeofday(&te, NULL);
	printf("CPU time: %.3f ms\n", (float)( 1000.0*(te.tv_sec-ts.tv_sec) + 0.001*(te.tv_usec-ts.tv_usec) ) );

	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));

	gettimeofday(&ts, NULL);

	cuPut(ca,ga,ms,stream);
	cuPut(cb,gb,ms,stream);
	fun<<<size/32, 32, 0, stream>>>(ga,gb,size);

	cuGet(ca,ga,ms,stream);
	cuGet(cb,gb,ms,stream);
	cuSync(stream);

	gettimeofday(&te, NULL);
	printf("GPU time: %.3f ms\n", (float)( 1000.0*(te.tv_sec-ts.tv_sec) + 0.001*(te.tv_usec-ts.tv_usec) ) );
}

	free(ca);
	free(cb);
	cudaFree(ga);
	cudaFree(gb);

	cudaDeviceReset();
	return 0;
}