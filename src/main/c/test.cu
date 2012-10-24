#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
#define M_W 128LU   // matrix dimension (at most 14336LU for in-memory, 12288LU OK)
#define M_H 128LU   // matrix dimension
//#define SPLITS 8  // number of kernels to be successively launched

// -----------------------------------------------------------------------------
#include "include/small_prob.h" // problem definitions
#include "include/small.h"      // common functions
#include "include/small_cpu.h"  // cpu implementation
#include "include/small_gpu.h"  // gpu implementation
// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();
	// CPU solving
	for (int i=0;i<1;++i) { t.start(); c_solve(); t.stop(); }
	fprintf(stderr,"- CPU: "); t.print(); fprintf(stderr,"\n");
	fflush(stderr);

	#ifdef __CUDACC__
	// GPU solving
	for (int i=0;i<4;++i) { t.start(); g_solve(); t.stop(); }
	fprintf(stderr,"- GPU: "); t.print(); fprintf(stderr,"\n");
	#endif

	dbg_compare(); // XXX: also compare backtrack

	//dbg_print(false,stdout);
	dbg_track(false,stdout);
	dbg_track(true,stdout);

	dbg_cleanup();
	return 0;
}
