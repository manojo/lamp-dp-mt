#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
#define M_W 1024LU  // matrix dimension
#define M_H 1024LU  // matrix dimension

// -----------------------------------------------------------------------------
#include "include/ns_prob.h" // problem definitions
#include "include/ns.h"      // common functions
#include "include/ns_cpu.h"  // cpu implementation
#include "include/ns_gpu.h"  // gpu implementation
// -----------------------------------------------------------------------------

__global__ void gpu_solve(TI* in0, TI* in1, TC* cost, TB* back, volatile unsigned* lock) {
	const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x; // * (  + blockIdx.y*gridDim.x );
	const unsigned tN = blockDim.x * gridDim.x;
	const unsigned tB = blockIdx.x;
	unsigned tP=0; // block progress

#ifdef SH_RECT
	// 1 block = 88ms, 128x128, correct, down to 30ms with multi-blocks
	// 1043ms for 1024x1024 => we are above "Optimizing DP on GPU via adaptive thread parallelism"
	// => we need to use the same technique as they do (but first compare on the same problem)
	const unsigned jjN = tN + M_W;
	for (unsigned i=tI; i<M_H; i+=tN) for (unsigned jj=0; jj<jjN; ++jj) {
		unsigned j = jj-tI;
		if (j<M_W) {


	//for (unsigned i=0; i<M_H; ++i) { // 560ms, 128x128
	//	for (unsigned j=0; j<M_W; ++j) {
#endif
#ifdef SH_TRI
	// not sure we want to proceed by //gram-blocks or by diagonal
	for (unsigned ii=0; ii<M_H; ++ii) {
		unsigned i=M_H-1-ii;
		for (unsigned j=i; j<M_W; ++j) {
#endif
#ifdef SH_PARA
	for (unsigned jj=0; jj<M_W; ++jj) {
		for (unsigned i=0; i<M_H; ++i) {
			unsigned j=jj+i;
#endif

			TB b=BT_STOP; TC c=0,c2; // stop
			if (!INIT(i,j)) {
				p_kernel
			}
			cost[idx(i,j)] = c;
			back[idx(i,j)] = b;
		}
		// Sync between blocks
		__threadfence();
		if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
		__syncthreads();
	}
}

void g_solve() {
	unsigned blk_size = 32;
	unsigned blk_num = (M_H+blk_size-1)/blk_size;

	unsigned* lock;
	cuMalloc(lock,sizeof(unsigned)*blk_num);
	cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
	gpu_solve<<<blk_num, blk_size, 0, NULL>>>(g_in[0], g_in[1], g_cost, g_back, lock);
	cuFree(lock);
}

// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	// CPU solving
	for (int i=0;i<2;++i) { t.start(); c_solve(); t.stop(); }
	fprintf(stderr,"- CPU: "); t.print(); fprintf(stderr,"\n");

	// GPU solving
	for (int i=0;i<2;++i) { t.start(); g_solve(); t.stop(); }
	fprintf(stderr,"- GPU: "); t.print(); fprintf(stderr,"\n");

	dbg_compare();
	// XXX: also compare backtrack

	//dbg_print(false,stdout);
	//dbg_track(false,stdout);

	dbg_cleanup();
	return 0;
}
