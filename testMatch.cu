#include <stdio.h>
#include <assert.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>

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


#define BLOCK_SIZE  32

// vertically t, horizontally s

// size_t>= size_s
// chunk=block_size

#define C0 1

 #define max(a,b) ({ __typeof__(a)_a = (a); __typeof__ (b) _b= (b); _a > _b ? _a : _b; })

__device__ unsigned int cost_f(unsigned left, unsigned top, unsigned diag, char s, char t, back* back) {
	unsigned cl=left+C0;
	unsigned ct=top+C0;
	unsigned cd=diag+(s==t?0:C0);
	if (cl>=max(ct,cd)) { *back='l'; }
	if (ct>=max(cl,cd)) { *back='t'; }
	if (cd>=max(cl,cr)) { *back='D'; }
	return max(max(cl,cr),ct);
}

__global__ void dp1(unsigned s_size, char* s, unsigned t_size, char* t, char* back) {
	__shared__ unsigned cost[BLOCK_SIZE*3];
	unsigned idx = threadIdx.x;

	// init, go vertically down along a part of t
	unsigned d0=0;
	unsigned d1=BLOCK_SIZE;   // diag with delay 1
	unsigned d2=BLOCK_SIZE*2; // diag with delay 2

	for (unsigned i=0;i<blockDim.x;++i) {
		if (idx<=i) {
			if (idx==0 || i-idx==0) {
				back[idx][i-idx]='.'; // at start
				cost[d0+idx]=0;
			} else {
				cost[d0+idx]=cost_f(cost[d1+idx-1],cost[d1+idx],cost[d2+idx-1],s[i-idx],t[idx],back[i-idx][idx]);
			}
		}
		unsigned dt=d2; d2=d1; d1=d0; d0=dt; // shifting diagonal
		__syncthreads();
	}

	// continu

	// termine

	//unsigned index = threadIdx.x + blockIdx.x * blockDim.x + blockIdx.y * blockDim.x * gridDim.x;

}

int main() {
	cuInfo();

	cuErr(cudaDeviceReset());
	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));

	dp1<<<1,1,0,stream>>>(NULL,0,NULL,0,0);


	cudaStreamDestroy(stream);

	cudaDeviceReset();
	return 0;
}