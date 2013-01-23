#include "include/common.h"
// Problem style (one among the 3 below)
//#define SH_RECT
//#define SH_TRI
//#define SH_PARA

// Problem dimensions
#define B_W 32LU    // block width
#define B_H 32LU    // block height
//#define M_W 4096LU   // matrix dimension (<=14336LU theo., <=12288LU actually)
//#define M_H 4096LU   // matrix dimension
#define SPLITS splits  // number of kernels to be successively launched
int splits = 1;

// -----------------------------------------------------------------------------
#include "include/small_prob.h" // problem definitions
#include "include/small.h"      // common functions
#include "include/small_cpu.h"  // cpu implementation
#include "include/small_gpu.h"  // gpu implementation
#include "include/small_dbg.h"  // debug helpers
// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;

	splits = (M_W+M_H)/2048; if (splits<=0) splits=1;
	splits = splits*splits*splits;
	dbg_init();

#if 1
	#define WARM_GPU 10
	#define RUNS_GPU 20
	#define RUNS_CPU 20
#else
	#define WARM_GPU 1
	#define RUNS_GPU 7
	#define RUNS_CPU 3
#endif
	// GPU solving
	printf("sprintf('%c.3f',",'%'); fflush(stdout); for (int i=0;i<10;++i) g_solve(); printf("median(["); fflush(stdout);
	for (int i=0;i<20;++i) { t.start(); g_solve(); double dt=t.stop(); printf(" %.3f",dt/1000.0); fflush(stdout); }
	printf(" ])) %c CUDA (%ld)\n",'%',M_W); fflush(stdout);
	// CPU solving
	printf("sprintf('%c.3f',",'%'); fflush(stdout); c_solve(); printf("median(["); fflush(stdout);
	for (int i=0;i<20;++i) { t.start(); c_solve(); double dt=t.stop(); printf(" %.3f",dt/1000.0); fflush(stdout); }
	printf(" ])) %c CPU (%ld)\n",'%',M_W); fflush(stdout);

	/*
	#define FAST
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
	for (int i=0;i<loops;++i) { t.start(); g_solve(); t.stop(); }
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
