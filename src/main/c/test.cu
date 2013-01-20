#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
//#define M_W 1024LU   // matrix dimension (at most 14336LU for in-memory, 12288LU OK)
//#define M_H 1024LU   // matrix dimension

// -----------------------------------------------------------------------------
#include "include/ns_prob.h" // problem definitions
#include "include/ns.h"      // common functions
#include "include/ns_cpu.h"  // cpu implementation
#include "include/ns_gpu.h"  // gpu implementation
// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	// GPU solving
	printf("- "); fflush(stdout); for (int i=0;i<10;++i) g_solve(); printf("GPU: "); fflush(stdout);
	for (int i=0;i<20;++i) { t.start(); g_solve(); double dt=t.stop(); printf("  %.3f",dt/1000.0); fflush(stdout); }
	printf("\n"); fflush(stdout);

	// CPU solving
	printf("- "); fflush(stdout); c_solve(); printf("CPU: "); fflush(stdout);
	for (int i=0;i<20;++i) { t.start(); c_solve(); double dt=t.stop(); printf("  %.3f",dt/1000.0); fflush(stdout); }
	printf("\n"); fflush(stdout);

	//dbg_compare();
	// XXX: also compare backtrack

	//dbg_print(false,stdout);
	//dbg_track(false,stdout);

	dbg_cleanup();
	return 0;
}
