#include "include/common.h" // XXX: fix path
#define SH_TRI
#define B_W 32LU
#define B_H 32LU
#define M_W 128LU
#define M_H 128LU

////////////////////////////////////////////////////////////////////////////////
// Data types
typedef struct { unsigned rows,cols; char print() { return 'X'; } } mat_t;
#define TI mat_t         // input data type
#define TI_CHR(X) ('0'+(X).rows) // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)

// Initialization
#define INIT(i,j) (j<=i) // matrix initialization at [stop]

// Matrix multiplication parenthesizing (triangular matrix)
//
//   M[i,j]= min {i<=k<j} M[i,k] + M [k+1,j] + r_i * c_k * c_j
//
#define p_kernel \
	_infinity \
	_min_loop(k,i,j,  _cost(i,k) + _cost(k+1,j) + _in(i).rows * _in(k).cols * _in(j).cols, k )

// Once generated: execute
// nvcc -arch=sm_21 -O2 <FILE>.cu -DSH_RECT -o <OUT>
// optirun <OUT>
////////////////////////////////////////////////////////////////////////////////

// Input
TI* p_input() {
	static unsigned s=time(NULL); mseed(s); // keep consistent
	TI* in = (TI*)malloc(M_H*sizeof(TI));
	#define RNZ ({ unsigned x; do { x=mrand()%10; } while (!x); x; })
	in[0].rows=RNZ;
	for (unsigned i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; }
	in[M_H-1].cols=RNZ;
	return in;
}

// XXX: fix path
#include "include/small.h"      // common functions
#include "include/small_cpu.h"  // cpu implementation
#include "include/small_gpu.h"  // gpu implementation

int main(int argc, char** argv) {
	dbg_init();
	dbg_compare();
	dbg_cleanup();
	return 0;
}

