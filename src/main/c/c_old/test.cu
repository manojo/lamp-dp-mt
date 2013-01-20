#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
//#define M_W 128LU   // matrix dimension (<=14336LU theo., <=12288LU actually)
//#define M_H 128LU   // matrix dimension
//#define SPLITS 8  // number of kernels to be successively launched

#define SPLITS splits
int splits = 1;

// -----------------------------------------------------------------------------
#include "include/small_prob.h" // problem definitions
#include "include/small.h"      // common functions
#include "include/small_cpu.h"  // cpu implementation
#include "include/small_gpu.h"  // gpu implementation
#include "include/small_dbg.h"  // debug helpers
// -----------------------------------------------------------------------------

//#define FAST

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	splits = (M_W+M_H)/4096; if (splits==0) splits=1; splits=splits*splits*splits;
	printf("Splits = %d\n",splits);

/*
	c_solve(); // warmup
	printf("- CPU:");
	for (int i=0;i<10;++i) {
		t.start(); c_solve(); double dt = t.stop(); printf(" %8.3f",dt/1000); fflush(stdout);
	}
	printf("\n");
*/

	//for (int i=0;i<10;++i) g_solve(); // warmup
	printf("- GPU:");
	for (int i=0;i<3;++i) {
		t.start(); g_solve(); double dt = t.stop(); printf(" %8.3f",dt/1000); fflush(stdout);
	}
	printf("\n");


	/*
	#ifndef FAST
	// CPU solving
	for (int i=0;i<1;++i) { t.start(); c_solve(); t.stop(); }
	fprintf(stderr,"- CPU: "); t.print(); fprintf(stderr,"\n");
	fflush(stderr);
	#endif

	#ifdef __CUDACC__
	// GPU solving
		#ifdef FAST
		const unsigned loops=1;
		#else
		const unsigned loops=4;
		#endif
	for (unsigned i=0;i<loops;++i) { t.start(); g_solve(); t.stop(); }
	fprintf(stderr,"- GPU: "); t.print(); fprintf(stderr,"\n");
	#endif

	#ifndef FAST
	dbg_compare();
	//dbg_print(false,stdout);
	dbg_track(false,stdout);
	dbg_track(true,stdout);
	#endif
	*/

	dbg_cleanup();
	return 0;
}
