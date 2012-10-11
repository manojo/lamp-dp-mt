#include "include/common.h"

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// System parameters
// - Data types
#define TI char    // input data type
#define TC int     // cost type
#define TB short   // backtrack type (2 bits for direction + 14 for value)
#define TW int     // wavefront type (if not defined, no wavefront)
// - Problem dimensions
#define B_W 8LU    // block width
#define B_H 4LU    // block height
#define M_W 49LU   // matrix dimension
#define M_H 67LU   // matrix dimension
// - Problem shape (RECT, TRIANG, PARALL)
#define SH_RECT
//#define SH_TRI
//#define SH_PARA
// Initialization
#define INIT(i,j)  ((i)==0 || (j)==0) // matrix initialization at [stop]

// Problem definition SWat(S,T) with arbitrary gap cost.
// By convention, S is the longest string and put vertically
// M[i,j] = max { 0                                 stop } = B[i,j]
//              { M[i-1,j-1]+cost(S[i],T[j])        NW   }
//              { max{1<=k<=j-1} M[i,j-k] - gap(k)  N(k) }
//              { max{1<=k<=i-1} M[i-k,j] - gap(k)  W(k) }
//

// Input string that can be free()d
TI* p_input(bool horz=false) {
	static unsigned sh=time(NULL), sv=time(NULL)+573; // keep consistent
	const char alph[4]={'A','C','G','T'};
	unsigned n = horz?M_W:M_H; mseed(horz?sh:sv);
	TI* in = (char*)malloc(n*sizeof(TI));
	for (unsigned i=0;i<n;++i) in[i]=alph[mrand()%4];
	return in;
}
// problem specific helpers
inline TC p_gap(int k) { return 20-k; }
inline TC p_cost(char s, char t) { return s==t?1:0; }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

#include "include/nonserial.h" // must be included after problem definition

// XXX: shall we assume that we could go sub-byte granularity for types ?
// XXX: need a full rework here, depending the configuration

void c_solve() {
	for (unsigned i=0; i<M_H; ++i) {
		for (unsigned j=0; j<M_W; ++j) {
			if (INIT(i,j)) { c_back[idx(i,j)]=BSTOP; c_cost[idx(i,j)]=0; }
			else {
				TB b=BSTOP; TC c=0,c2;  // stop
				for (size_t k=1; k<j; ++k) { c2=c_cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=B(DIR_LEFT,k); } }
				for (size_t k=1; k<i; ++k) { c2=c_cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=B(DIR_UP,k); } }
				c2 = c_cost[idx(i-1,j-1)]+p_cost(c_in[0][i],c_in[1][j]); if (c2>=c) { c=c2; b=B(DIR_DIAG,1); }
				c_cost[idx(i,j)] = c;
				c_back[idx(i,j)] = b;
			}
		}
	}
}

// simply return the pair of indices (i,j) that are in the backtrack
// by default we use the direction-length backtrack
TC c_backtrack(unsigned** bt, unsigned* size) {
	// Find the position with maximal cost
	unsigned mi=0; TC ci=0;
	unsigned mj=0; TC cj=0;
	for (unsigned i=0; i<M_H; ++i) { TC c=c_cost[idx(i,M_W-1)]; if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TC c=c_cost[idx(M_H-1,j)]; if (c>cj) { mj=j; cj=c; } }
	unsigned i,j;
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	// Backtrack
	if (bt && size) {
		TB b;
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;
		do {
			track[0]=i; track[1]=j; track+=2; ++sz;
			b = c_back[idx(i,j)];
			switch(BD(b)) {
				case DIR_LEFT: j-=BV(b); break;
				case DIR_UP: i-=BV(b); break;
				case DIR_DIAG: i-=BV(b); j-=BV(b); break;
			}
		} while (b!=BSTOP);
		*size=sz;
	}
	return MAX(ci,cj);
}

// -----------------------------------------------------------------------------

// GPU structures

// - allocate memory
// - access memory[cost,backtrack,wavefront,input] at index (i,j)


void dbg_track(bool gpu, FILE* f) {
	// XXX: fix for GPU

	unsigned* bt;
	unsigned sz;
	unsigned score = c_backtrack(&bt,&sz);
	fprintf(f,"Backtrack with best score : %d\n",score);
	for (unsigned i=sz-1;;--i) {
		printf("(%d,%d) ",bt[i*2],bt[i*2+1]);
		if (!i) break;
	}
	printf("\n");
	free(bt);
}

// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	c_init();
	c_solve();
//	dbg_print(false,stdout);
	dbg_track(false,stdout);
	c_free();

//	g_init();
//	g_free();

/*
	#ifdef SH_RECT
	printf("rectangle\n");
	#endif
	#ifdef SH_TRI
	printf("triangle\n");
	#endif
	#ifdef SH_PARA
	printf("parallelogram\n");
	#endif
*/
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

const TI* g_in[2]={NULL,NULL}; // 0=vert(S), 1=horizontal(T) with |S| >= |T|
TC* g_cost=NULL;
TB* g_back=NULL;
#ifdef TW
TW* g_wave[3]={NULL,NULL,NULL}; // 0=vert,1=horizontal,2=diagonal
#endif

// initialize structures
void init() {
	size_t mem = M_W*M_H+B_H*B_H;
	g_cost=(TC*)malloc(sizeof(TC)*mem);
	g_back=(TB*)malloc(sizeof(TB)*mem);
	#ifdef TW
		g_wave[0]=(TW*)malloc(sizeof(TW)*M_H);
		g_wave[1]=(TW*)malloc(sizeof(TW)*M_W);
		g_wave[2]=(TW*)malloc(sizeof(TW)*MAX(M_H/B_H,M_W/B_W));
	#endif
	g_in[0]=p_S; // also duplicate into CUDA
	g_in[1]=p_T;
}

// cleanup structures
void cleanup() {
	if (g_cost) free(g_cost); g_cost=NULL;
	if (g_back) free(g_back); g_back=NULL;
	#ifdef TW
	for (int i=0;i<3;++i) if (g_wave[i]) { free(g_wave[i]); g_wave[i]=NULL; }
	#endif
}

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
void* mm_alloc(off_t bi, off_t bj, bool cost=true, bool device=false) {
	// attempt to alloc, if cannot, then try to free all the blocks with 0 retain,
	// possibly write-back to disk, then try again
	if (cost) return &g_cost[B_AT(bi,bj)];
	else return &g_back[B_AT(bi,bj)];
}
void mm_free(void* ptr) {}

blk_t blk_get(off_t bi, off_t bj, bool device=false) {
	blk_t b; b.bi=bi; b.bj=bj;
	b.mi=M_H-bi*B_H; if (b.mi>B_H) b.mi=B_H;
	b.mj=M_W-bj*B_W; if (b.mj>B_W) b.mj=B_W;
	b.in[0]=&g_in[0][bi*B_H]; // XXX: depends whether we're on device
	b.in[1]=&g_in[1][bj*B_W];
	b.wr_back=false;
	b.cost=(TC*)mm_alloc(bi,bj,true);
	b.back=(TB*)mm_alloc(bi,bj,false);
	return b;
}

void blk_free(blk_t* blk) {
	if (blk->wr_back) {
		// XXX: write-back to main memory or to storage
	}
	mm_free(blk->cost);
	mm_free(blk->back);
}

// -----------------------------------------------------------------------------
// reference implementation

void solve1() {
	// Recurrence (embeds initialization)
	for (size_t i=0; i<C_H; ++i) {
		for (size_t j=0; j<C_W; ++j) {
			if (i==0 || j==0) {
				g_back[idx(i,j)]='/'; g_cost[idx(i,j)]=0;
			} else {
				TB b='/'; TC c=0,c2;  // stop
				for (size_t k=1; k<j; ++k) { c2=g_cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=p_left[k]; } } // XXX: missing the k information
				for (size_t k=1; k<i; ++k) { c2=g_cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=p_up[k]; } }
				c2 = g_cost[idx(i-1,j-1)]+p_cost(g_in[0][i],g_in[1][j]); if (c2>=c) { c=c2; b='\\'; }
				g_cost[idx(i,j)] = c;
				g_back[idx(i,j)] = b;
			}
		}
	}
}

// -----------------------------------------------------------------------------
// block-split

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

void solve2() {
	// we need to manage concurrency at CPU level here to call multiple blocks
	for (unsigned bi=0;bi<M_H/B_H;++bi) {
		for (unsigned bj=0;bj<M_W/B_W;++bj) {
			blk_t blk = blk_get(bi,bj);
			// --------- Solving non-serial dependencies
			#if NONSERIAL>0
			TC** c_list[2]={NULL,NULL}; // previous blocks list (0=vert,1=horz,2=diag)
			#if (NONSERIAL)&DIR_VERT
			c_list[0]=(TC**)malloc(bi*sizeof(TC**)); for (unsigned k=0;k<bi;++k) c_list[0][k]=(TC*)mm_alloc(bi-k-1,bj);
			#endif
			#if (NONSERIAL)&DIR_HORZ
			c_list[1]=(TC**)malloc(bj*sizeof(TC**)); for (unsigned k=0;k<bj;++k) c_list[1][k]=(TC*)mm_alloc(bi,bj-k-1);
			#endif
			blk_precompute2(&blk,c_list[0],c_list[1]);
			#if (NONSERIAL)&DIR_VERT
			for (unsigned k=0;k<bi;++k) mm_free(c_list[0][k]); free(c_list[0]);
			#endif
			#if (NONSERIAL)&DIR_HORZ
			for (unsigned k=0;k<bj;++k) mm_free(c_list[1][k]); free(c_list[1]);
			#endif
			#endif
			// --------- Block processing
			TC* c_prev[3]={NULL,NULL,NULL};
			#if (POLYADIC)&(DIR_VERT|DIR_DIAG)
			if (bi>0) c_prev[0]=(TC*)mm_alloc(bi-1,bj);
			#endif
			#if (POLYADIC)&(DIR_HORZ|DIR_DIAG)
			if (bj>0) c_prev[1]=(TC*)mm_alloc(bi,bj-1);
			#endif
			#if (POLYADIC)&DIR_DIAG
			if (bi>0 && bj>0) c_prev[2]=(TC*)mm_alloc(bi-1,bj-1);
			#endif
			blk_solve2(&blk,c_prev[0],c_prev[1],c_prev[2]);
			#if (POLYADIC)&(DIR_VERT|DIR_DIAG)
			if (bi>0) mm_free(c_prev[0]);
			#endif
			#if (POLYADIC)&(DIR_HORZ|DIR_DIAG)
			if (bj>0) mm_free(c_prev[1]);
			#endif
			#if (POLYADIC)&DIR_DIAG
			if (bi>0 && bj>0) mm_free(c_prev[2]);
			#endif
		}
	}
}

#include <unistd.h>
#include <stdarg.h>
pid_t sys_exec(const char* path, ...) {
	pid_t f; int r; char** argv=NULL; char* a; va_list ap; int n=2;
	va_start(ap,path); while ((a=va_arg(ap,char*))) ++n; va_end(ap);
	argv=(char**)malloc(n*sizeof(char*)); if (!argv) return -1; argv[0]=(char*)path; n=1;
	va_start(ap,path); while ((a=va_arg(ap,char*))) argv[n++]=a; va_end(ap); argv[n]=NULL;
	switch(f=fork()) { case -1: return -1; case 0: execvp(path,(char** const)argv); _exit(1);
		default: free(argv); if (f!=-1 && waitpid(f,&r,0)!=-1) return WEXITSTATUS(r); else return -1;
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

	cleanup();
	return 0;
}

#endif