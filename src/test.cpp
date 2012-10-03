#include <stdio.h>
#include <list>

// COMPUTE THE PROBLEM LINE BY LINE => WE CAN ALLOC SUFFICIENT MEMORY TO FINISH THE LINE

// GET A MEMORY BLOCK POINTER

// XXX: CONVENTION: threads go left-to-right and process the matrix top to bottom

// 1. define the index mapping for coalesced memory
// 2. try to encode a matrix in this pattern
// 3. try to define and operate on such blocks

// Have pack and unpack functions if we want to support lower bitsizes

// XXX: find other implementations to get some hints

#define DIR_HORZ  0x1
#define DIR_VERT  0x2
#define DIR_DIAG 0x4

// ------------------- problem properties -------------------
// types   : TI=input, TM=cost matrix, TB=backtrack, TW=wavefront
// serial  : nserial=non-serial directions
// polyadic: ptype=polyadic directions, psize=length of polyadic, 1=monadic
template<class TI, class TM, class TB, class TW> class DPblock;
template<class TI, class TM, class TB, class TW> class DPload;
template<class TI, class TM, class TB, class TW, int nserial=0, int ptype=DIR_HORZ|DIR_VERT|DIR_HORZ, int psize=1>
class DP {
	size_t m_width, m_height; // matrix memory dimensions
	size_t b_width, b_height; // block dimensions
	size_t d_width, d_height; // data matrix dimensions d_xx<=m_xx


	// ------------------- memory backend -------------------
	// - keep most elements into memory (detect exhaustion by malloc failure)
	// - write-back: blocks are put in the unused list and tagged if they need write before free
	// - eviction rules: pick one that is not in the N-previous lines/rows/diagonals depending
	//   of the pattern and that is possibly not write-back
	std::list<DPblock<TI,TM,TB,TW> > used; // in cuda memory
	std::list<DPblock<TI,TM,TB,TW> > unused; // in main memory browse from start => MRU from last => LRU

	// get the pair of cost/backtrack blocks
	DPblock<TI,TM,TB,TW> block_at(off_t x, off_t y, int num=1) { return NULL; } // blocks are not truncated but memory is padded
	bool block_write(DPblock<TI,TM,TB,TW> bl) { return false; } // to store and free
	bool block_free(DPblock<TI,TM,TB,TW> bl) { return false; } // to free memory
	// XXX: keep track of blocks that are contiguously assigned

	// access to the input
	TI* in_x(off_t pos, size_t len) { return NULL; }
	TI* in_y(off_t pos, size_t len) { return NULL; }
	void  in_free(TI* input) {}
};


// Block processor for a sub-matrix of the problem. We assume that all the
// dependencies are either in the wavefront or pre-computed in the cost and
// backtrack matrices.
template<class TI, class TM, class TB, class TW>
class DPproc { // duplicate for both main memory and cuda memory
	size_t b_x, b_y, b_width, b_height; // block position and dimensions
	size_t max_x,max_y; // actual content maximal position
	bool device; // whether correct memory is on cuda or in main memory
	bool w_back; // whether memory needs to be written back
	TM** cost;   // cost matrix chunk
	TB** bt;     // output data to be written / overwritten

	// Process one block; wavefront is monadic and serves both as in and out.
	void process(TW* w_horz, TW* w_vert, TW* w_diag) {
		// XXX: processing function, take partial results from the wavefront(serial) and block(non-serial) and compute final values
		w_back=true;
	}
};

// A serializer that will pre-aggregate results of previous blocks and compute
// partial aggregation for the current block (but will not do the actual block
// computations.
template<class TI, class TM, class TB, class TW>
class DPload {
	void aggregate(DPblock<TI,TM,TB,TW>* block, // the block to fill
			DPblock<TI,TM,TB,TW>* b_horz, size_t s_horz,
			DPblock<TI,TM,TB,TW>* b_vert, size_t s_vert,
			DPblock<TI,TM,TB,TW>* b_diag, size_t s_diag) {
		// XXX: aggregating function. store in block the partial results
	}
};

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
	return 0;
}