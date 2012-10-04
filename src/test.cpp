#include <stdio.h>
#include <list>

#define DIR_HORZ  0x1
#define DIR_VERT  0x2
#define DIR_DIAG  0x4

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
		// Initialization
		for (size_t i=0; i<c_height; ++i) { _back[idx(i,0)]='S'; _cost[idx(i,0)]=0; }
		for (size_t j=0; j<c_width; ++j) { _back[idx(0,j)]='S'; _cost[idx(0,j)]=0; }
		// Recurrence
		const char* du="!ABCDEFGHIJKLMNOPQRStUVWXYZ0123456789|||||"; // go up(k): 1=A,2=B...
		const char* dl="!abcdefghijklmnopqrstuvwxyz0123456789-----"; // go left(k): 1=a,2=b...
		for (size_t i=1; i<c_height; ++i) {
			for (size_t j=1; j<c_width; ++j) {
				TB b='S'; TC c=0;  // stop
				TC c2 = _cost[idx(i-1,j-1)]+cost(_in[1][i],_in[0][j]); if (c2>c) { c=c2; b='\\'; }
				for (size_t k=1; k<j; ++k) { c2=_cost[idx(i,j-k)]-gap(k); if (c2>c) { c=c2; b=dl[k]; } } // XXX: missing the k information
				for (size_t k=1; k<i; ++k) { c2=_cost[idx(i-k,j)]-gap(k); if (c2>c) { c=c2; b=du[k]; } }
				_cost[idx(i,j)] = c;
				_back[idx(i,j)] = b;
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
};

// -----------------------------------------------------------------------------
// A sub-matrix of the global problem
template<class TI, class TC, class TB, class TW>
class DPblock { // duplicate for both main memory and cuda memory
protected:
	size_t b_x, b_y, b_width, b_height; // block position and dimensions
	size_t max_x,max_y; // actual content maximal position
	bool device; // whether correct memory is on cuda or in main memory
	bool w_back; // whether memory needs to be written back
	TC** cost;   // cost matrix chunk
	TB** bt;     // output data to be written / overwritten
public:

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
	void aggregate(DPblock<TI,TC,TB,TW>* block, // the block to fill
			DPblock<TI,TC,TB,TW>* b_horz, size_t s_horz,
			DPblock<TI,TC,TB,TW>* b_vert, size_t s_vert,
			DPblock<TI,TC,TB,TW>* b_diag, size_t s_diag) {
		// XXX: aggregating function. store in block the partial results
	}


};

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