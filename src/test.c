#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#define ASSERT(cond) extern int __assert__[1-2*(!(cond))];

// directions for recurrences
#define DIR_HORZ  0x1
#define DIR_VERT  0x2
#define DIR_DIAG  0x4

// -----------------------------------------------------------------------------
// Problem definition SWat(S,T) with arbitrary gap cost.
// By convention, S is the longest string and put vertically
// M[i,j] = max { 0                                 stop } = B[i,j]
//              { M[i-1,j-1]+cost(S[i],T[j])        NW   }
//              { max{1<=k<=j-1} M[i,j-k] - gap(k)  N(k) }
//              { max{1<=k<=i-1} M[i-k,j] - gap(k)  W(k) }
//
const char* p_S = "gattaccaggatacatacagattaccaggatacataca";
const char* p_T = "gtaccaggatacaagtacatagcacataca";
// g++ required to compile this [do not remove this line] CC:=g++
const unsigned long p_SL = strlen(p_S);
const unsigned long p_TL = strlen(p_T);
// debug pretty-print
const char* p_up="!ABCDEFGHIJKLMNOPQRStUVWXYZ0123456789|||||||||||"; // go up(k): 1=A,2=B...
const char* p_left="!abcdefghijklmnopqrstuvwxyz0123456789---------"; // go left(k): 1=a,2=b...

inline int p_gap(int k) { return 20-k; }
inline int p_cost(char s, char t) { return s==t?1:0; }

// -----------------------------------------------------------------------------
// Tweaking parameters
#define NONSERIAL (DIR_HORZ|DIR_VERT)          // non-serial direction
#define POLYADIC  (DIR_HORZ|DIR_VERT|DIR_HORZ) // polyadic direction
#define POLY_SZ   1                            // polyadic length (1=mondaic)

#define INIT(i,j)  ((i)==0 || (j)==0)          // matrix initialization to (stop)

// Data types
#define TI char      // input data type
#define TC int       // cost type
#define TB char      // backtrack type
#define TW int       // wavefront type (if not defined, there is no wavefront)

// Dimensions
#define B_W 8LU      // block width
#define B_H 4LU      // block height

#define C_W p_TL     // content width
#define C_H p_SL     // content height

// -----------------------------------------------------------------------------
ASSERT(POLY_SZ<=B_H) // we want to go at most 1 block backward in polyadic case
ASSERT(POLY_SZ<=B_W)

#define M_W (((C_W-1)/B_W+1)*B_W) // memory width
#define M_H (((C_H-1)/B_H+1)*B_H) // memory height

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
// all-in-main-memory implementation

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
		g_wave[0]=(TW*)malloc(sizeof(TW)*C_H);
		g_wave[1]=(TW*)malloc(sizeof(TW)*C_W);
		g_wave[2]=(TW*)malloc(sizeof(TW)*M_H/B_H);
	#endif
	g_in[0]=p_S;
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

blk_t blk_get(off_t bi, off_t bj) {
	blk_t b; b.bi=bi; b.bj=bj;
	// XXX: test whether these zone were already allocated in CUDA memory to
	// avoid using duplicate memory
	b.in[0]=&g_in[0][bi*B_H];
	b.in[1]=&g_in[1][bj*B_W];
	b.cost=&g_cost[B_AT(bi,bj)];
	b.back=&g_back[B_AT(bi,bj)];
	b.mi=C_H-bi*B_H; if (b.mi>B_H) b.mi=B_H;
	b.mj=C_W-bj*B_W; if (b.mj>B_W) b.mj=B_W;
	return b;
}

void print(FILE* f) {
	fprintf(f,"Matrix(%ldx%ld), data(%ldx%ld), blocks(%ldx%ld)\n",M_H,M_W,C_H,C_W,B_H,B_W);
	fprintf(f,"  ");
	// header
	for (size_t j=0;j<M_W;++j) { fprintf(f," %c",j<C_W?(char)g_in[1][j]:'#'); if (j%B_W==B_W-1) fprintf(f," |"); }
	fprintf(f,"\n");
	for (size_t i=0;i<M_H;++i) {
		// content
		fprintf(f," %c",i<C_H?(char)g_in[0][i]:'#');
		for (size_t j=0;j<M_W;++j) {
			if (i>=C_H||j>=C_W) fprintf(f," .");
			else {
				// TABLE CONTENT
				char c = g_back[idx(i,j)]; fprintf(f," %c",c?c:' ');
				//fprintf(f,"  ");
			}
			if (j%B_W==B_W-1) fprintf(f," |");
		}
		fprintf(f,"\n");
		// spacer
		if (i%B_H==B_H-1) {
			fprintf(f,"--");
			for (size_t j=0;j<M_W;++j) { fprintf(f,"--"); if (j%B_W==B_W-1) fprintf(f,"-+"); }
			fprintf(f,"\n");
		}
	}
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

void blk_precompute2(blk_t* blk) {
	for (unsigned i=0;i<blk->mi;++i) {
		for (unsigned j=0;j<blk->mj;++j) {
			TB b='/'; TC c=0,c2;  // default(0,stop)
			const unsigned long oi=blk->bi*B_H, oj=blk->bj*B_W; // block offset in global memory
			if (!INIT(oi+i,oj+j)) {
				// XXX: UGLY CODE USING GLOBAL MEMORY, TO BE FIXED
				for (size_t k=j+1; k<oj+j; ++k) { c2=g_cost[idx(oi+i,oj+j-k)]-p_gap(k); if (c2>c) { c=c2; b=p_left[k]; } }
				for (size_t k=i+1; k<oi+i; ++k) { c2=g_cost[idx(oi+i-k,oj+j)]-p_gap(k); if (c2>=c) { c=c2; b=p_up[k]; } }
				// XXX: UGLY CODE USING GLOBAL MEMORY, TO BE FIXED
			}
			blk->cost[idx(i,j)] = c;
			blk->back[idx(i,j)] = b;
			//	if (blk->bi>0&&((NONSERIAL)&DIR_VERT) || blk->bj>0&&((NONSERIAL)&DIR_HORZ) || blk->bi>0&&blk->bj>0&&((NONSERIAL)&DIR_DIAG)) {
		}
	}
}

void blk_solve2(blk_t* blk /*, blk_t* left, blk_t* top, blk_t* diag*/) {
	const unsigned long oi=blk->bi*B_H, oj=blk->bj*B_W; // block offset in global memory
	for (unsigned i=0;i<blk->mi;++i) {
		for (unsigned j=0;j<blk->mj;++j) {
			TB b='/'; TC c=0,c2;  // stop
			if (!INIT(oi+i,oj+j)) {
				c2=blk->cost[idx(i,j)];
				if (c2>c) { c=c2; b=blk->back[idx(i,j)]; }
				for (size_t k=1; k<=j; ++k) { c2=blk->cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=p_left[k]; } }
				for (size_t k=1; k<=i; ++k) { c2=blk->cost[idx(i-k,j)]-p_gap(k); if (c2>=c) { c=c2; b=p_up[k]; } }

				// XXX: BAD: WE ACCESS NEIGHBOR BLOCKS HERE
				// XXX: also pass the 3 contiguous blocks (depending dependencies direction)
				c2 = g_cost[idx(oi+i-1,oj+j-1)]+p_cost(blk->in[0][i],blk->in[1][j]); if (c2>=c) { c=c2; b='\\'; }
			}
			blk->cost[idx(i,j)] = c;
			blk->back[idx(i,j)] = b;
		}
	}
}

void solve2() {
	for (size_t bi=0;bi<M_H/B_H;++bi) {
		for (size_t bj=0;bj<M_W/B_W;++bj) {
			blk_t blk = blk_get(bi,bj);
			//for (unsigned i=0;i<blk.mi;++i) for (unsigned j=0;j<blk.mj;++j) blk.back[idx(i,j)]='0'+(bi+bj);

			// needs to acc
			blk_precompute2(&blk);
			blk_solve2(&blk);
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



































//#include <list>
/*

	inline size_t blk_size() { return b_height*(B_W+b_height-1)-1; }
	inline off_t blk(size_t y, size_t x) { return (y/b_height)*M_W*b_height + (x/b_width); }
	// maps the position (y,x) into coalesced-by-block-height offsets
	inline off_t idx(size_t y, size_t x) {
		return b_height*(x+(y%b_height)) + (y%b_height) + (y/b_height)*M_W*b_height;
	}
*/
// Known by LMS
// input : S="gattaccaggatacatacagattaccaggatacataca", length=38
//         T="gtaccaggatacaagtacatagcacataca", length=30

#if 0
// -----------------------------------------------------------------------------
// problem properties:
// types    : TI=input, TC=cost matrix, TB=backtrack, TW=wavefront
// serial   : nserial=non-serial directions
// polyadic : ptype=polyadic directions, psize=length of polyadic, 1=monadic
// wavefront: whether we need additional data into the wavefront to be stored
template<class TI, class TC, class TB, class TW> class DPblock;
template<class TI, class TC, class TB, class TW> class DPload;
template<class TI, class TC, class TB, class TW, int nserial=0, int ptype=DIR_HORZ|DIR_VERT|DIR_HORZ, int psize=1, bool wavefront=false>
class DP {
protected:
	size_t m_width, m_height; // matrix memory dimensions
	size_t b_width, b_height; // block dimensions
	size_t c_width, c_height; // content matrix dimensions c_xx<=m_xx
	// bool backend_fs; // use filesystem as a backend (when problem do not fit in memory).

public:

	// ------------------- in-memory backend -------------------
	const TI* _in[2]; // 0=horz(T),1=vert(S) with |S| >= |T|
	TC* _cost;
	TB* _back;
	TW* _wave[3]; // 0=horz,1=vert,2=diag

	DP(size_t height, size_t width, size_t bh, size_t bw, const TI* in_vert, const TI* in_horz) {
		c_width=width; b_width=bw; m_width=((c_width+bw-1)/bw)*bw;
		c_height=height; b_height=bh; m_height=((c_height+bh-1)/bh)*bh;

		size_t mem = m_width*m_height + bh*bh;
		_cost=(TC*)malloc(sizeof(TC)*mem);
		_back=(TB*)malloc(sizeof(TB)*mem);
		if (wavefront) {
			_wave[0]=(TW*)malloc(sizeof(TW)*width);
			_wave[1]=(TW*)malloc(sizeof(TW)*height);
			_wave[2]=(TW*)malloc(sizeof(TW)*m_height/b_height);
		}
		_in[0]=in_horz;
		_in[1]=in_vert;
	}
	~DP() {
		if (_cost) free(_cost);
		if (_back) free(_back);
		if (wavefront) { free(_wave[0]); free(_wave[1]); free(_wave[2]); }
	}

	// XXX: we need to be smarter than doing this computation again and again
	// maps (y,x) to its containing block start and length
	inline size_t blk_size() { return b_height*(b_width+b_height-1)-1; }
	inline off_t blk(size_t y, size_t x) { return (y/b_height)*m_width*b_height + (x/b_width); }
	// maps the position (y,x) into coalesced-by-block-height offsets
	inline off_t idx(size_t y, size_t x) {
		return b_height*(x+(y%b_height)) + (y%b_height) + (y/b_height)*m_width*b_height;
	}

	// -------------------------------------------------------------------------
	// SWat with arbitrary gap function
	// S is the longest string and is vertical
	// M[i,j] = max { 0                                 stop } = B[i,j]
	//              { M[i-1,j-1]+cost(S[i],T[j])        NW   }
	//              { max{1<=k<=j-1} M[i,j-k] - gap(k)  N(k) }
	//              { max{1<=k<=i-1} M[i-k,j] - gap(k)  W(k) }
	//
    // This is the CPU easy implementation that will be refined over time to match blocks system

	inline int gap(int k) { return 20-k; }
	inline int cost(TI s, TI t) { return s==t?1:0; }
	void solve() {
		/*
		// Recurrence (embeds initialization)
		const char* du="!ABCDEFGHIJKLMNOPQRStUVWXYZ0123456789|||||"; // go up(k): 1=A,2=B...
		const char* dl="!abcdefghijklmnopqrstuvwxyz0123456789-----"; // go left(k): 1=a,2=b...
		for (size_t i=1; i<c_height; ++i) {
			for (size_t j=1; j<c_width; ++j) {
				if (i==0 || j==0) {
					_back[idx(0,j)]='S'; _cost[idx(0,j)]=0;
				} else {
					TB b='S'; TC c=0;  // stop
					TC c2 = _cost[idx(i-1,j-1)]+cost(_in[1][i],_in[0][j]); if (c2>c) { c=c2; b='\\'; }
					for (size_t k=1; k<j; ++k) { c2=_cost[idx(i,j-k)]-gap(k); if (c2>c) { c=c2; b=dl[k]; } } // XXX: missing the k information
					for (size_t k=1; k<i; ++k) { c2=_cost[idx(i-k,j)]-gap(k); if (c2>c) { c=c2; b=du[k]; } }
					_cost[idx(i,j)] = c;
					_back[idx(i,j)] = b;
				}
			}
		}
		*/

		for (size_t bi=0;bi<m_height/b_height;++bi) {
			for (size_t bj=0;bj<m_width/b_width;++bj) {
				Block b(this,bi,bj);
				b.solve();
			}
		}


	}
	// -------------------------------------------------------------------------

	void print() {
		printf("Matrix(%ldx%ld), data(%ldx%ld), blocks(%ldx%ld)\n",m_height,m_width,c_height,c_width,b_height,b_width);
		printf("  ");
		// header
		for (size_t j=0;j<m_width;++j) { printf(" %c",j<c_width?(char)_in[0][j]:'#'); if (j%b_width==b_width-1) printf(" |"); }
		printf("\n");
		for (size_t i=0;i<m_height;++i) {
			// content
			printf(" %c",i<c_height?(char)_in[1][i]:'#');
			for (size_t j=0;j<m_width;++j) {
				if (i>=c_height||j>=c_width) printf(" .");
				else {
					// TABLE CONTENT
					char c = _back[idx(i,j)]; printf(" %c",c?c:' ');
					//printf("  ");
				}
				if (j%b_width==b_width-1) printf(" |");
			}
			printf("\n");
			// spacer
			if (i%b_height==b_height-1) {
				printf("--");
				for (size_t j=0;j<m_width;++j) { printf("--"); if (j%b_width==b_width-1) printf("-+"); }
				printf("\n");
			}
		}
	}

	friend class Block;

	// All-in-main-memory block
	class Block {
	private:
		DP* _dp;
		const TI* _in[2]; // 0=horz(T),1=vert(S)
		TC* _cost;        // cost matrix chunk
		TB* _back;        // output data to be written / overwritten
		size_t max_i,max_j; // actual content maximal position
		//bool device; // whether correct memory is on cuda or in main memory
		bool w_back; // whether memory needs to be written back
		off_t b_i, b_j;
	public:
		Block(DP* dp, off_t y, off_t x) {
			b_i=y*dp->b_height; b_j=x*dp->b_width;
			_dp=dp;

			// XXX: test whether these zone were already allocated in CUDA memory
			_in[0]=dp->_in[y*dp->b_height];
			_in[1]=dp->_in[x*dp->b_width];
			_cost=&dp->_cost[dp->blk(y,x)];
			_back=&dp->_back[dp->blk(y,x)];
			max_i=dp->c_height-y*dp->b_height; if (max_i>dp->b_height) max_i=dp->b_height;
			max_j=dp->c_width-x*dp->b_width; if (max_j>dp->b_width) max_j=dp->b_width;
		}
		void write() { w_back=true; }
		~Block() {
			// if (write) write_back();
			// free memory
		}

		void solve() {
			const char* du="!ABCDEFGHIJKLMNOPQRStUVWXYZ0123456789|||||"; // go up(k): 1=A,2=B...
			const char* dl="!abcdefghijklmnopqrstuvwxyz0123456789-----"; // go left(k): 1=a,2=b...
			// Precompute
			if (b_i>0&&(nserial&DIR_VERT) || b_j>0&&(nserial&DIR_HORZ) || (b_i>0&&b_j>0&&(nserial&DIR_DIAG))) {
				for (size_t i=0; i<_dp->b_height; ++i) {
					for (size_t j=0; j<_dp->b_width; ++j) {
						TC c=0,c2; TB b='S'; // default (0,stop)
						// XXX: BAD: we do not use previous block but access global memory
						for (size_t k=1; k<=b_i; ++k) { c2=DP::_cost[_dp->idx(b_i-k,j)]-_dp->gap(k+i); if (c2>c) { c=c2; b=du[k+i]; } }
						for (size_t k=1; k<=b_j; ++k) { c2=DP::_cost[_dp->idx(i,b_j-k)]-_dp->gap(k+j); if (c2>c) { c=c2; b=dl[k+i]; } }
						_cost[_dp->idx(i,j)]=c;
						_back[_dp->idx(i,j)]=b;
					}
				}
			}
			// Solve
			for (size_t i=1; i<_dp->c_height; ++i) {
				for (size_t j=1; j<_dp->c_width; ++j) {
					TB b=_back[_dp->idx(i,j)];
					TC c=_cost[_dp->idx(i,j)];
					if (b_i==0&&i==0 || b_j==0&&j==0) { b='S'; c=0; }
					else {
						TC c2 = _cost[_dp->idx(i-1,j-1)]+_dp->cost(_in[1][i],_in[0][j]); if (c2>c) { c=c2; b='\\'; }
						for (size_t k=1; k<j; ++k) { c2=_cost[_dp->idx(i,j-k)]-_dp->gap(k); if (c2>c) { c=c2; b=dl[k]; } }
						for (size_t k=1; k<i; ++k) { c2=_cost[_dp->idx(i-k,j)]-_dp->gap(k); if (c2>c) { c=c2; b=du[k]; } }
						_cost[idx(i,j)] = c;
						_back[idx(i,j)] = b;
					}
				}
			}
		}
		void precompute() {
			if (!nserial) return;
			//if (nserial&DIR_HORZ)
			//if (nserial&DIR_VERT)
			//if (nserial&DIR_HORZ)
			// XXX: provide a way to access the same column/row/diagonal backward
			// compute the partial cost and write them in the block data
		}

	};



/*
	// ------------------- memory backend -------------------
	// - keep most elements into memory (detect exhaustion by malloc failure)
	// - write-back: blocks are put in the unused list and tagged if they need write before free
	// - eviction rules: pick one that is not in the N-previous lines/rows/diagonals depending
	//   of the pattern and that is possibly not write-back
	std::list<DPblock<TI,TC,TB,TW> > used; // in cuda memory
	std::list<DPblock<TI,TC,TB,TW> > unused; // in main memory browse from start => MRU from last => LRU

	// get the pair of cost/backtrack blocks
	DPblock<TI,TC,TB,TW> block_at(off_t x, off_t y, int num=1) { return NULL; } // blocks are not truncated but memory is padded
	bool block_write(DPblock<TI,TC,TB,TW> bl) { return false; } // to store and free
	bool block_free(DPblock<TI,TC,TB,TW> bl) { return false; } // to free memory
	// XXX: keep track of blocks that are contiguously assigned

	// access to the input
	TI* in_vert(off_t pos, size_t len) { return NULL; }
	TI* in_horz(off_t pos, size_t len) { return NULL; }
	void  in_free(TI* input) {}
*/
};

// -----------------------------------------------------------------------------
/*
// A sub-matrix of the global problem
template<class TI, class TC, class TB, class TW>
class DPblock { // duplicate for both main memory and CUDA memory
protected:
	size_t b_width, b_height; // block position and dimensions
	size_t max_i,max_j; // actual content maximal position
	bool device; // whether correct memory is on cuda or in main memory
	bool w_back; // whether memory needs to be written back

	const TI* _in[2]; // 0=horz(T),1=vert(S) with |S| >= |T|
	TC* _cost;        // cost matrix chunk
	TB* _back;        // output data to be written / overwritten

public:
	DPblock(size_t height, size_t width, const TI* in_vert, const TI* in_horz, TC* cost_mat, TB* bt_mat, off_t _max_i, size_t _max_j) {
		b_width=width; b_height=height;
	}

	// Process one block (sub-matrix of the problem). We assume that all the
	// dependencies are either in the wavefront or pre-computed in the cost and
	// backtrack matrices; wavefront is monadic and serves both as in and out.
	void process(TW* w_horz, TW* w_vert, TW* w_diag) {
		// XXX: processing function, take partial results from the wavefront(serial) and block(non-serial) and compute final values
		w_back=true;
	}

	// A serializer that will pre-aggregate results of previous blocks and compute
	// partial aggregation for the current block (but will not do the actual block
	// computations.

	// XXX: use an ad-hoc numbering backward to address blocks in the row/column
	// XXX: use CUDA streams per line/row to know when we can compute a new block

	void aggregate(DPblock<TI,TC,TB,TW>* block, // the block to fill
			DPblock<TI,TC,TB,TW>* b_horz, size_t s_horz,
			DPblock<TI,TC,TB,TW>* b_vert, size_t s_vert,
			DPblock<TI,TC,TB,TW>* b_diag, size_t s_diag) {
		// XXX: aggregating function. store in block the partial results
	}


};
*/

// COMPUTE THE PROBLEM LINE BY LINE => WE CAN ALLOC SUFFICIENT MEMORY TO FINISH THE LINE
// GET A MEMORY BLOCK POINTER

// XXX: CONVENTION: threads go left-to-right and process the matrix top to bottom

// 1. define the index mapping for coalesced memory
// 2. try to encode a matrix in this pattern
// 3. try to define and operate on such blocks

// Have pack and unpack functions if we want to support lower bitsizes

// XXX: find other implementations to get some hints


/*
// also think of
void f(int* left, int* top, char S, char T, int* right, int* bottom) {
	// this is he core function
}

void block(int x, int y, char* S, char* T, // block definition
	int* left_wave, int* top_wave, int* topleft_wave, int* bottom_wave, int* right_wave, int* botright_wave, // wavefront
	int* cost*, int skip // precomputed array of values, skip=jump between lines
	) {
}
*/

int main(int argc, char** argv) {
	// longest string S vertically by convention
	const char* S="gattaccaggatacatacagattaccaggatacataca";
	const char* T="gtaccaggatacaagtacatagcacataca";
	DP<char,int,char,int> p(strlen(S),strlen(T),4,8,S,T);
	p.solve();
	p.print();

	return 0;
}
#endif