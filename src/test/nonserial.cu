#include "include/common.h"

// Problem shape (SH_RECT, SH_TRI, SH_PARA)
//#define SH_RECT
#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
#define M_W 32LU  // matrix dimension
#define M_H 32LU  // matrix dimension

// -----------------------------------------------------------------------------
#ifdef SH_RECT
// Smith-Waterman with arbitrary gap cost function (rectangular matrix).
// SWat(S,T); by convention, S is the longest string and put vertically
// M[i,j] = max { 0                                 stop } = B[i,j]
//              { M[i-1,j-1]+cost(S[i],T[j])        NW   }
//              { max{1<=k<=j-1} M[i,j-k] - gap(k)  N(k) }
//              { max{1<=k<=i-1} M[i-k,j] - gap(k)  W(k) }
// Data types
#define TI char     // input data type
#define TI_CHR(X) X // conversion to char
#define TC int      // cost type
#define TB short    // backtrack type (2 bits for direction + 14 for value)
//#define TW int    // wavefront type (if not defined, no wavefront)

// Initialization
#define INIT(i,j)  ((i)==0 || (j)==0) // matrix initialization at [stop]
// Input
TI* p_input(bool horz=false) {
	static unsigned sh=time(NULL), sv=time(NULL)+573; // keep consistent
	const char alph[4]={'A','C','G','T'};
	unsigned n = horz?M_W:M_H; mseed(horz?sh:sv);
	TI* in = (TI*)malloc(n*sizeof(TI));
	for (unsigned i=0;i<n;++i) in[i]=alph[mrand()%4];
	return in;
}
// Helpers
_hostdev _inline TC p_gap(int k) { return 20-k; }
_hostdev _inline TC p_cost(char s, char t) { return s==t?1:0; }
#endif
// -----------------------------------------------------------------------------
#ifdef SH_TRI
// Matrix multiplication parenthesizing (triangular matrix)
// M[i,j]= min {i<=k<j} M[i,k] + M [k+1,j] + r_i * c_k * c_j
// Now we need to flip the i axis to normalize progression
//
//   M[i,j]= min {i<=k<j} M[i,k] + M [j+i-(1+k),j] + r_i * c_k * c_j
//
typedef struct { unsigned rows,cols; char print() { return 'X'; } } mat_t;
// Data types
#define TI mat_t         // input data type
#define TI_CHR(X) ('0'+(X).rows) // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)
//#define TW int         // wavefront type (if not defined, no wavefront)
// Initialization
#define INIT(i,j) (i+j<=M_H-1) // matrix initialization at [stop]
#define COST_MAX  (0x78888888UL)

// Input
TI* p_input() {
	static unsigned s=time(NULL); mseed(s); // keep consistent
	TI* in = (TI*)malloc(M_H*sizeof(TI));
	#define RNZ ({ unsigned x; do { x=mrand()&0x7; } while (!x); x; })
	in[0].rows=RNZ;
	for (int i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; }
	in[M_H-1].cols=RNZ;
	return in;
}

#endif
// -----------------------------------------------------------------------------
#ifdef SH_PARA
// Polygon triangulation (parallelogram matrix)
#endif
// -----------------------------------------------------------------------------

#include "include/nonserial.h" // must be included after problem definition

void c_solve() {
	mat_t* in0=c_in[0];
	for (unsigned i=0; i<M_H; ++i) {
		#ifdef SH_RECT
		for (unsigned j=0; j<M_W; ++j)
		#endif
		#ifdef SH_TRI
		for (unsigned j=M_H-1-i; j<M_W; ++j)
		#endif
		#ifdef SH_PARA
		for (unsigned j=i; j<M_W+i; ++j)
		#endif
		{
			TB b=BSTOP; TC c=0,c2;  // stop
			if (!INIT(i,j)) {
				#ifdef SH_RECT // SWat with arbitrary cost
				for (unsigned k=1; k<j; ++k) { c2=c_cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=B(DIR_LEFT,k); } }
				for (unsigned k=1; k<i; ++k) { c2=c_cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=B(DIR_UP,k); } }
				c2 = c_cost[idx(i-1,j-1)]+p_cost(c_in[0][i],c_in[1][j]); if (c2>=c) { c=c2; b=B(DIR_DIAG,1); }
				#endif
				#ifdef SH_TRI // Matrix multiplication
				c = COST_MAX;
				for (unsigned k=M_H-1-i; k<j; ++k) {
					c2=c_cost[idx(i,k)] + c_cost[idx(M_H-k-2,j)] + in0[i].rows * in0[k].cols * in0[j].cols;
					if (c2<c) { c=c2; b=B(DIR_DIAG,k); }
				}
				#endif
			}
			c_cost[idx(i,j)] = c;
			c_back[idx(i,j)] = b;
		}
	}
}

// -----------------------------------------------------------------------------

#if 0

#define M_STRIPES ((M_H+B_H-1)/B_H) // number of CUDA block stripes (of height B_H) in the matrix
__global__ void gpu_solve(TI* in0, TI* in1, TC* cost, TB* back, volatile unsigned* sync) { // 437ms -> 555ms for volatile (but ensures correctness)
/*
	const int tx=threadIdx.x;
	if (threadIdx.x==0)
	for (unsigned i=0; i<M_H; ++i) {
		for (unsigned j=0; j<M_W; ++j) {
			TB b=BSTOP; TC c=0,c2;  // stop
			if (!INIT(i,j)) {
				for (size_t k=1; k<j; ++k) { c2=cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=B(DIR_LEFT,k); } }
				for (size_t k=1; k<i; ++k) { c2=cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=B(DIR_UP,k); } }
				c2 = cost[idx(i-1,j-1)]+p_cost(in0[i],in1[j]); if (c2>=c) { c=c2; b=B(DIR_DIAG,1); }
			}
			cost[idx(i,j)] = c;
			back[idx(i,j)] = b;
		}
	}
*/

	const int tx=threadIdx.x;
	__shared__ unsigned max[32]; // one min per block
	for (unsigned i=0; i<M_H; ++i) {
		for (unsigned j=0; j<M_W; ++j) {
			TB b=BSTOP; TC c=0,c2;  // stop
			max[0]=0;

			if (!INIT(i,j)) {
				for (size_t k=1; k<j; ++k) { c2=cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=B(DIR_LEFT,k); } }
				for (size_t k=1; k<i; ++k) { c2=cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=B(DIR_UP,k); } }

				if (threadIdx.x==0) {
					c2 = cost[idx(i-1,j-1)]+p_cost(in0[i],in1[j]); if (c2>=c) { c=c2; b=B(DIR_DIAG,1); }
				}

				if (tx>=16) max[tx-16]=c;
				if (tx<16 && c>max[tx]) max[tx]=c;
				if (tx<8 && (c2=max[tx+8])>max[tx]) max[tx]=c2;
				if (tx<4 && (c2=max[tx+4])>max[tx]) max[tx]=c2;
				if (tx<2 && (c2=max[tx+2])>max[tx]) max[tx]=c2;
				if (tx==0 && (c2=max[1])>max[0]) max[0]=c2;

			}
			if (c==max[0]) {
				cost[idx(i,j)] = c;
				back[idx(i,j)] = b;
			}
			__threadfence();
		}
	}
	// assign 4 threads to search minimum
	//	const unsigned tx = threadIdx.x+B_H*blockIdx.x;
	// XXX: dynamic number of sub-threads to compute minimum

/* 128x128 = 176.43ms
	const unsigned tx = threadIdx.x+B_H*blockIdx.x;
	const int i=tx;
	for (int jj=0; jj<M_W+M_H; ++jj) {
		int j=jj-tx;

		// Do computations in the valid part of the matrix
		if (j>=0 && j<M_W && i<M_H) {
			TB b=BSTOP; TC c=0,c2; // stop
			if (!INIT(i,j)) {
				for (size_t k=1; k<j; ++k) { c2=cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=B(DIR_LEFT,k); } }
				for (size_t k=1; k<i; ++k) { c2=cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=B(DIR_UP,k); } }
				c2 = cost[idx(i-1,j-1)]+p_cost(in0[i],in1[j]); if (c2>=c) { c=c2; b=B(DIR_DIAG,1); }
			}
			cost[idx(i,j)] = c;
			back[idx(i,j)] = b;
		}

		// Synchronize between blocks
		__threadfence();
		if (threadIdx.x==0) {
			sync[blockIdx.x]=jj;
			if (blockIdx.x>0) {
				while (sync[blockIdx.x-1]<jj) {}
			}
		}
		__syncthreads();
	}
*/
}
#endif

void g_solve() {
/*
	//const unsigned tx = threadIdx.x + blockDim.x * ( blockIdx.x + blockIdx.y*gridDim.x );
	unsigned* sync;
	cuMalloc(sync,sizeof(int)*M_STRIPES); // 64 blocks
	cudaMemset(sync,0,sizeof(unsigned)*M_STRIPES);
	//gpu_solve<<<M_STRIPES,B_H,0,NULL>>>(g_in[0],g_in[1],g_cost,g_back,sync);

	gpu_solve<<<1,32,0,NULL>>>(g_in[0],g_in[1],g_cost,g_back,sync);

	cuFree(sync);
*/
}

TC g_backtrack(unsigned** bt, unsigned* size) { return 0; }



// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	// CPU solving
	for (int i=0;i<2;++i) { t.start(); c_solve(); t.stop(); }
	printf("CPU solve: "); t.print(); printf("\n");

	// GPU solving
	// for (int i=0;i<2;++i) { t.start(); g_solve(); t.stop(); }
	// printf("GPU solve: "); t.print(); printf("\n");

	dbg_print(false,stdout);
	dbg_track(false,stdout);
	// dbg_compare();

	dbg_cleanup();
	return 0;
}




























#if 0
// macro helpers
#define B_LEN(n) (B_H*B_W*(n) + B_H*(B_H-1)-1) // memory length for N contiguous(line) blocks
#define B_IN(i,j) ( ((i)/B_H)*M_W*B_H + ((j)/B_W)*B_W*B_H ) // returns offset of the block containing (i,j)
#define B_AT(bi,bj) ( (bi)*M_W*B_H + (bj)*B_W*B_H ) // return the block (bi,bj)

inline off_t idx(size_t i, size_t j) { return B_H*(j+(i%B_H)) + (i%B_H) + (i/B_H)*M_W*B_H; }

typedef struct {
	unsigned bi, bj;     // block offset
	unsigned mi,mj;     // valid content maximal position
	const TI* in[2];  // related input 0=vert(S),1=horz(T)
	TC* cost;         // cost matrix
	TB* back;         // backtrack matrix
	//bool device;    // whether valid memory is CUDA or CPU memory
	bool wr_back;     // whether memory needs to be written back
} blk_t;

// -----------------------------------------------------------------------------
// Memory manager and problem data structures
// > all-in-main-memory implementation

// memory manager
// XXX: keep track of allocated zones, both function must be mutex-protected
// XXX: we need an atomic list of cost blocks, of input blocks and of backtrack blocks
// pthread_mutex_t* mutex;
// typedef struct { off_t bi,bj; bool cost; bool dev; void* ptr; unsigned retained; } mem_t;
	// XXX: test whether these zone were already allocated in CUDA memory to
	// avoid using duplicate memory
 // all these loads need to be atomically done, also released on demand
 // ==> allocate an array of pointers (both main and device mem) and do atomic CAS on them to get pointer + counter
 // See http://www.boost.org/doc/libs/1_39_0/boost/interprocess/detail/atomic.hpp
 // instead take into account blocks that have been written to disk so that reloading into memory is easier
 // also note that writing on disk must reorder differently to avoid writing dirty surrounding data

#define COST_BLEFT(i,k) (cl_left[(k-1)/B_W][ i*(B_H+1)+ (B_W-k%B_W)%B_W *B_H ])
#define COST_BTOP(k,j) (cl_top[k/B_H][idx((B_H-(k%B_H))%B_H,j)])

// Handle non-serial dependencies out of the block
void blk_precompute2(blk_t* blk, TC** cl_top, TC** cl_left) {
	const unsigned long oi=blk->bi*B_H, oj=blk->bj*B_W; // block offset in global memory
	for (unsigned i=0;i<blk->mi;++i) {
		for (unsigned j=0;j<blk->mj;++j) {
			TB b='/'; TC c=0,c2;  // default(0,stop)
			if (!INIT(oi+i,oj+j)) {
				// Non-serial partial dependencies
				for (unsigned k=1; k<oj; ++k) { c2=COST_BLEFT(i,k) - p_gap(j+k); if (c2>c) { c=c2; b=p_left[j+k]; } }
				for (unsigned k=1; k<oi; ++k) { c2=COST_BTOP(k,j) - p_gap(k+i); if (c2>=c) { c=c2; b=p_up[k+i]; } }

			}
			blk->cost[idx(i,j)] = c;
			blk->back[idx(i,j)] = b;
		}
	}
}

// Get the cost value with backward search of at most 1 block
#define COST_B1(i,j) ({ int _i=(i),_j=(j); TC* _c=_i<0?(_j<0?c_diag:c_top):(_j<0?c_left:blk->cost); _i=(_i+B_H)%B_H; _j=(_j+B_W)%B_W; _c[B_H*(_j+_i)+_i]; })

void blk_solve2(blk_t* blk, TC* c_top, TC* c_left, TC* c_diag) {
	for (unsigned i=0;i<blk->mi;++i) {
		for (unsigned j=0;j<blk->mj;++j) {
			TB b='/'; TC c=0,c2;  // stop
			if (!INIT(blk->bi*B_H+i,blk->bj*B_W+j)) {
				c2=blk->cost[idx(i,j)];
				// Non-serial partial result
				if (c2>c) { c=c2; b=blk->back[idx(i,j)]; }
				// Finish non-serial
				for (size_t k=1; k<=j; ++k) { c2=blk->cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=p_left[k]; } }
				for (size_t k=1; k<=i; ++k) { c2=blk->cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=p_up[k]; } }
				// Monadic diagonal
				c2=COST_B1(i-1,j-1) + p_cost(blk->in[0][i],blk->in[1][j]); if (c2>=c) { c=c2; b='\\'; }
			}
			blk->cost[idx(i,j)] = c;
			blk->back[idx(i,j)] = b;
		}
	}
}

int main(int argc, char** argv) {
	init();
	FILE* f;
	f=fopen("ref.txt","w"); solve1(); print(f); fclose(f);
	f=fopen("t.txt","w"); solve2(); print(f); fclose(f);
	int r=sys_exec("diff","-dur","ref.txt","t.txt",NULL);
	printf("\n\n");
	sys_exec("cat","t.txt",NULL);
	printf("\nCorrectness: %s\n",!r?"no differences":"FAILURE !!!");
	unlink("ref.txt"); unlink("t.txt");

	return 0;
}


/*
//GPU lock-free synchronization function
__device__ void __gpu_sync(int goalVal, volatile int *Arrayin, volatile int *Arrayout) {
	// thread ID in a block
	int tid_in_blk = threadIdx.x * blockDim.y + threadIdx.y;
	int nBlockNum = gridDim.x * gridDim.y;
	int bid = blockIdx.x * gridDim.y + blockIdx.y;
	// only thread 0 is used for synchronization
	if (tid_in_blk == 0) Arrayin[bid] = goalVal;
	if (bid == 1) {
		if (tid_in_blk < nBlockNum)	{
			while (Arrayin[tid_in_blk] != goalVal) {}
			__syncthreads();
		}
		if (tid_in_blk<nBlockNum) Arrayout[tid_in_blk] = goalVal;
	}
	if (tid_in_blk == 0) {
		while (Arrayout[bid] != goalVal) {}
	}
	__syncthreads();
}
*/

#endif
