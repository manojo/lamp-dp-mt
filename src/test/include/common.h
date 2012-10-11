#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include <sys/time.h>

#include "mrand.h"

#define _inline __attribute__((unused)) static inline
#define ASSERT(cond) extern int __assert__[1-2*(!(cond))];
#define MAX(a,b) ({ typeof(a) _a=(a); typeof(b) _b=(b); _a>_b?_a:_b; })
#define MIN(a,b) ({ typeof(a) _a=(a); typeof(b) _b=(b); _a<_b?_a:_b; })

// -----------------------------------------------------------------------------
// Some CUDA primitives
#ifdef __CUDACC__
#define cuDevSync() cudaDeviceSynchronize()
#define cuErr(err) cuErr_(err,__FILE__,__LINE__)
#define cuSync(stream) cuErr(cudaStreamSynchronize(stream))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
#define cuMalloc(ptr,size) cuErr(cudaMalloc((void**)&ptr,size))
#define cuFree(ptr) cuErr(cudaFree(ptr))
#define cuStream(stream) cudaStream_t stream; cuErr(cudaStreamCreate(&stream));
#define cuStrFree(stream) cuErr(cudaStreamDestroy(stream))

_inline void cuErr_(cudaError_t err, const char *file, int line) { if (err!=cudaSuccess) { fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); exit(EXIT_FAILURE); } }
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
#else
#define cuDevSync()
#endif

// -----------------------------------------------------------------------------
// A simple timer that provides range and average

struct cuTimer {
	struct timeval ts;
	double min,max,sum; int count;
	cuTimer() { reset(); }
	void reset() { min=max=-1; sum=0; count=0; }
	void start() { cuDevSync(); gettimeofday(&ts,NULL); }
	void stop() {
		struct timeval te; cuDevSync(); gettimeofday(&te,NULL);
		double last=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
		if (min<0 || last<min) min=last; if (max<0 || last>max) max=last; sum+=last; count++;
	}
	void print() { printf("%6.2fms [%6.2f,%6.2f], %d runs",count?sum/count:0.0,min,max,count); min=max=-1; sum=0; count=0; }
};
