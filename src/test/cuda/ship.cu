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

/*
 * Processing 992 Mb of data
 * CPU: 162.10 ms
 * GPU: 483.20 ms (including transfers)
 * GPU: 122.69 ms (without transfers)
 * => 5.3743 GB/s for transfer
 */

int main(int argc,char** argv) {
	cudaDeviceReset();
	// We transfer 2 pairs of int, hence 8 bytes, my card mem is 2^30 bytes
	const unsigned size=31<<22; // we need some memory for the program itself
	fprintf(stderr,"Processing %ld Mb of data:\n",size*sizeof(int)*2 /1024/1024);

	const unsigned int ms=size*sizeof(int);
	int* ca = (int*)malloc(ms);
	int* cb = (int*)malloc(ms);
	int* ga; cuMalloc(ga,ms);
	int* gb; cuMalloc(gb,ms);

	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));
	cuTimer tc,tg,tp;

	for (int i=0;i<20;++i) {
		// CPU benchmark
		tc.start();
		for (unsigned i=0;i<size;++i) { OP(ca,cb,i) }
		tc.stop();

		// GPU + transfer benchmark
		cuSync(stream);
		tg.start();
		cuPut(ca,ga,ms,stream);
		cuPut(cb,gb,ms,stream);
		fun<<<size/32, 32, 0, stream>>>(ga,gb,size);
		cuGet(ca,ga,ms,stream);
		cuGet(cb,gb,ms,stream);
		cuSync(stream);
		tg.stop();

		// GPU: processing only
		tp.start();
		fun<<<size/32, 32, 0, NULL>>>(ga,gb,size);
		tp.stop();
	}

	fprintf(stderr,"CPU: "); tc.print(); fprintf(stderr,"\n");
	fprintf(stderr,"GPU: "); tg.print(); fprintf(stderr,"\n");
	fprintf(stderr,"Prc: "); tp.print(); fprintf(stderr,"\n");

	cuErr(cudaStreamDestroy(stream));
	cuFree(ga); cuFree(gb);
	free(ca); free(cb);
	cudaDeviceReset();
	return 0;
}
