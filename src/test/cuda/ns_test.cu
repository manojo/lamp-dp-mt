#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
#define M_W 4096LU  // matrix dimension (at most 14336LU for in-memory, 12288LU OK)
#define M_H 4096LU  // matrix dimension
#define SPLITS 8    // number of kernels to be successively launched


// -----------------------------------------------------------------------------
#include "include/ns_prob.h" // problem definitions
#include "include/ns.h"      // common functions
#include "include/ns_cpu.h"  // cpu implementation
#include "include/ns_gpu.h"  // gpu implementation
// -----------------------------------------------------------------------------

	/*
	 * Optimizations to implement when we are confident about the problem structure:
	 * SH_RECT: Since we sweep the rectangle with a diagonal, at iteration M_W+(tN+1)/2
	 *          half of them will we unused. At this point, break the loop and construct
	 *          a new loop where 2 threads are assigned the same cell, that is thread tI
	 *          is assigned to cell (i/2, j). We would require tI/2 shared cost cells to
	 *          exchange maximal cost, the cell with cost=maximum writes (cost,backtrack)
	 *          to the original matrices.
	 * SH_TRI : Similarly, when half of the threads go out of the triangle, we can reassign
	 *          two threads per cell, then repeat the operation at 4 and 8 (possibly 16 and 32).
	 * SH_PARA: No optimization possible since every pair of thread has very different dependences
     */
	// 1 block = 88ms, 128x128, correct, down to 30ms with multi-blocks
	// 1043ms for 1024x1024 => we are above "Optimizing DP on GPU via adaptive thread parallelism"
	// => we need to use the same technique as they do (but first compare on the same problem)

__global__ void gpu_solve(const TI* in0, const TI* in1, TC* cost, TB* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
	const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x; // * (  + blockIdx.y*gridDim.x );
	const unsigned tN = blockDim.x * gridDim.x;
	const unsigned tB = blockIdx.x;
	unsigned tP=s_start; // block progress

#ifdef SH_RECT
	#ifdef SPLITS
	if (s_start) { tP+=tN*s_start/B_W; s_start+=tN*s_start/B_W; }
	s_stop+=tN*s_stop/B_W;
	#else
	s_stop+=tN;
	#endif


	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned i=tI; i<M_H; i+=tN) {
			unsigned j = jj-tI;
			if (j<M_W) {
#endif
#ifdef SH_TRI
	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned ii=tI; ii<M_H; ii+=tN) {
			unsigned i=M_H-1-ii;
			unsigned j=i+jj;
			if (j<M_W) {
#endif
#ifdef SH_PARA
	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned i=tI; i<M_H; i+=tN) {
			unsigned j=jj+i;
			{
#endif
				TB b=BT_STOP; TC c=0,c2; // stop
				if (!INIT(i,j)) { p_kernel }
				cost[idx(i,j)] = c;
				back[idx(i,j)] = b;
			}
		}

		// Sync between blocks, removing __threadfence() is incorrect but works
		// __threadfence();
		#ifdef SH_PARA // wait for all blocks
		__syncthreads();
		++tP; if (threadIdx.x==0) lock[tB]=tP;
		for (unsigned b=threadIdx.x;b<gridDim.x;b+=blockDim.x) { // sync with all blocks
			while(lock[(tB+b)%gridDim.x]<tP) {}
		}
		#else // wait for previous block only
		if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
		#endif
		__syncthreads();
	}
}

void g_solve() {
	unsigned blk_size = 32; // = warp size
	unsigned blk_num = (M_H+blk_size-1)/blk_size;
#ifdef SH_PARA // 384 cores (GF650M) XXX: find out why deadlock at >32 blocks
	if (blk_num>32) blk_num=32;
#endif
	unsigned* lock;
	cuMalloc(lock,sizeof(unsigned)*blk_num);
	cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
#ifdef SPLITS
	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));
	for (int i=0;i<SPLITS;++i) {
		unsigned s0=(M_W*i)/SPLITS;
		unsigned s1=(M_W*(i+1))/SPLITS;
		gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in[0], g_in[1], g_cost, g_back, lock, s0, s1);
	}
	cuSync(stream);
	cuErr(cudaStreamDestroy(stream));
#else
	gpu_solve<<<blk_num, blk_size, 0, NULL>>>(g_in[0], g_in[1], g_cost, g_back, lock, 0, M_W);
#endif
	cuFree(lock);
}




TC g_backtrack(unsigned** bt, unsigned* size) {
	TC cost;
	unsigned i,j;

	// Find the position with maximal cost along bottom+right borders
	unsigned mi=0; TC ci=0;
	unsigned mj=0; TC cj=0;
	for (unsigned i=0; i<M_H; ++i) { TC c=c_cost[idx(i,M_W-1)]; if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TC c=c_cost[idx(M_H-1,j)]; if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	cost = c_cost[idx(i,j)];
	// Backtrack, returns a pair of coordinates in reverse order
	if (bt && size) {
		TB b;
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;
		do {
			track[0]=i; track[1]=j; track+=2; ++sz;
			b = c_back[idx(i,j)];
			switch(BT_D(b)) {
				case DIR_LEFT: j-=BT_V(b); break;
				case DIR_UP: i-=BT_V(b); break;
				case DIR_DIAG: i-=BT_V(b); j-=BT_V(b); break;
			}
		} while (b!=BT_STOP);
		*size=sz;
	}


	return cost;
}




// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	// CPU solving
	//for (int i=0;i<1;++i) { t.start(); c_solve(); t.stop(); }
	//fprintf(stderr,"- CPU: "); t.print(); fprintf(stderr,"\n");
	//fflush(stderr);
	// GPU solving
	for (int i=0;i<1;++i) { t.start(); g_solve(); t.stop(); }
	fprintf(stderr,"- GPU: "); t.print(); fprintf(stderr,"\n");

	// dbg_compare();
	// XXX: also compare backtrack

	//dbg_print(false,stdout);
	//dbg_track(false,stdout);

	dbg_cleanup();
	return 0;
}
