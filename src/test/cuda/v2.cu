#include "include/common.h"

#define M_W 128LU   // in1.size
#define M_H 128LU   // in0.size
//#define SPLITS 8  // number of kernels to be successively launched
#define WARP_SIZE 32

// XXX: fix addressing from [0,1] .. [n-1,n] and n+1 for the rectangular case (0,0) to (n,n)

// -----------------------------------------------------------------------------
// Memory addressing strategies
#if defined(SH_TRI)
	#undef SH_RECT
	#undef M_W
	#define M_W M_H
	// compact triangle address: full main diagonal, then the second, ...
	// idx(i,j) = |M| - |/\| +i  (with |M|=MEM_MATRIX)
	//     |/\| = d*(d+1)/2      (smallest triangle including position element)
	//        d = M_H+1+_i-_j
	#define MEM_MATRIX ((M_H*(M_H+1))/2) // lower right triangle, including diagonal
	#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - (_d*(_d-1))/2 +_i; })
#elif defined(SH_RECT)
	// block-lines address: smaller parallelograms in lines of height B_H
	#define B_H WARP_SIZE
	#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)
	#define idx(i,j) ({ unsigned _i=(i); (B_H*((j)+(_i%B_H)) + (_i%B_H) + (_i/B_H)*M_W*B_H); })
#else
	#error "Matrix must have a shape"
#endif
#if !defined(M_H) || !defined(M_W)
#error "Matrix dimensions undefined"
#endif

// -----------------------------------------------------------------------------
// Maximal cost
#define COST_MAX ((1ULL<<(sizeof(TC)*8-1))-1) // max signed value

// Backtracking
#define BT_STOP ((TB)(~0ULL)) // = 0xff...ff        // base case, stop backtracking
// - (direction,value), sizeof(TB)*8-2 bits available for the value
#define DIR_UP   0x1 // up direction
#define DIR_LEFT 0x2 // left direction
#define DIR_DIAG 0x3 // up-left diagonal direction
#define BT(dir,value) ((dir) | ((value)<<2)) // new (direction,value) backtrack
#define BT_V(b) ((b)>>2)                      // extract the value
#define BT_D(b) ((b)&3)                       // extract the direction

// -----------------------------------------------------------------------------

#define _unroll _Pragma ("unroll 5") // Optimized by hand for my GPU
#ifdef SH_RECT      // Smith-Waterman with arbitrary gap cost function (rectangular matrix).
#define TI char     // input data type
#define TI_CHR(X) X // conversion to char
#define TC int      // cost type
#define TB short    // backtrack type (2 bits for direction + 14 for value)
// Initialization
#define INIT(i,j)  ((i)==0 || (j)==0) // matrix initialization at [stop]
// Input (returns padded strings)
TI* p_input(bool horz=false) {
	static unsigned sh=time(NULL), sv=time(NULL)+573; // keep consistent
	const char alph[4]={'A','C','G','T'}; unsigned n = horz?M_W:M_H; mseed(horz?sh:sv);
	TI* in = (TI*)malloc(n*sizeof(TI)); in[0]='#'; // padding
	for (unsigned i=1;i<n;++i) in[i]=alph[mrand()%4]; return in;
}
// Helpers functions
_hostdev _inline TC p_gap(int k) { return 20-k; }
_hostdev _inline TC p_cost(char s, char t) { return s==t?1:0; }
// Computation kernel
#define p_kernel \
	_unroll for (unsigned k=1; k<i; ++k) { c2=cost[idx(i-k,j)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_UP,k); } }
	_unroll for (unsigned k=1; k<j; ++k) { c2=cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_LEFT,k); } }
	c2 = cost[idx(i-1,j-1)]+p_cost(in0[i],in1[j]); if (c2>=c) { c=c2; b=BT(DIR_DIAG,1); }
#endif

#ifdef SH_TRI
// Matrix multiplication parenthesizing (triangular matrix)
typedef struct { unsigned rows,cols; } mat_t;
#define TI mat_t         // input data type
#define TI_CHR(X) ('0'+(X).rows) // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)
// Initialization
#define INIT(i,j) (j<=i) // matrix initialization at [stop]
// Input
TI* p_input() {
	static unsigned s=time(NULL); mseed(s); // keep consistent
	TI* in = (TI*)malloc(M_H*sizeof(TI));
	#define RNZ ({ unsigned x; do { x=mrand()%10; } while (!x); x; })
	in[0].rows=RNZ; for (unsigned i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; } in[M_H-1].cols=RNZ;
	return in;
}
// Computation kernel
#define p_kernel c=COST_MAX; \
	_unroll for (unsigned k=i; k<j; ++k) { c2=cost[idx(i,k)] + cost[idx(k+1,j)] + in0[i].rows * in0[k].cols * in0[j].cols; if (c2<c) { c=c2; b=(TB)k; } }
#endif

// -----------------------------------------------------------------------------

__global__ void gpu_solve(const TI* in0, const TI* in1, TC* cost, TB* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
	const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;
	const unsigned tN = blockDim.x * gridDim.x;
	const unsigned tB = blockIdx.x;
	unsigned tP=s_start; // block progress
#ifdef SH_RECT
	#ifdef SPLITS
	s_start += (tN*s_start)/M_W;
	s_stop += (tN*s_stop)/M_W;
	tP=s_start;
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
				TB b=BT_STOP; TC c=0,c2; // stop
				if (!INIT(i,j)) { p_kernel }
				cost[idx(i,j)] = c;
				back[idx(i,j)] = b;
			}
		}
		// Sync between blocks, removing __threadfence() is incorrect but works
		if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
		__syncthreads();
	}
}

// -----------------------------------------------------------------------------
// GPU helpers
#ifdef __CUDACC__
static TI* g_in[2]={NULL,NULL};
static TC* g_cost = NULL;
static TB* g_back = NULL;
#endif

int main(int argc, char** argv) {
	// Init
	cuMalloc(g_in[0],sizeof(TI)*M_H);
	//cuPut(in0,g_in[0],sizeof(TI)*M_H,NULL);
	#ifdef SH_RECT
		cuMalloc(g_in[1],sizeof(TI)*M_W);
		//cuPut(in1,g_in[1],sizeof(TI)*M_W,NULL);
	#else
		g_in[1]=g_in[0];
	#endif
	cuMalloc(g_cost,sizeof(TC)*MEM_MATRIX);
	cuMalloc(g_back,sizeof(TB)*MEM_MATRIX);

	// Compute
	unsigned blk_size = WARP_SIZE;
	unsigned blk_num = (M_H+blk_size-1)/blk_size;
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

	// Collect score
	// XXX

	// Collect backtrack
	// XXX

	// Free
	cuFree(g_in[0]);
	#ifdef SH_RECT
	cuFree(g_in[1]);
	#endif
	cuFree(g_cost); cuFree(g_back);

	return 0;
}
