// NON-SERIAL:
// - Non-serial problem, fills a square, triangle or parallelogram matrix
// - All the data fits in the GPU memory
// - Progress must be possible along anti-diagonal in parallel
//
//      SH_RECT          SH_TRI               SH_PARA
// +---------------+  +-----------+  +-----------+-----------+ --
// |               |  | X X X X / |  | X X X X /           / |
// |               |  | X X X /   |  | X X X /           / X |
// |               |  | X X /     |  | X X /           / X X | M_H
// |               |  | X /       |  | X /           / X X X |
// |               |  | /         |  | /           / X X X X |
// +---------------+  +-----------+  +-----------+-----------+ --
// |      M_W      |  |    M_H    |  |    M_H    |
//
// -----------------------------------------------------------------------------
// make sure we picked exactely one shape
#if defined(SH_RECT)&&defined(SH_TRI) || defined(SH_TRI)&&defined(SH_PARA) || defined(SH_PARA)&&defined(SH_RECT)
#error "Cannot define two shapes for the matrix"
#endif
#if !defined(SH_RECT)&&!defined(SH_TRI)&&!defined(SH_PARA)
#error "Matrix must have a shape"
#endif

// Backtracking macros
#define BSTOP (0)

// Backtrack as (direction,value), sizeof(TB)*8-2 bits available for the value
#define DIR_UP   0x1 // up direction
#define DIR_LEFT 0x2 // left direction
#define DIR_DIAG 0x3 // up-left diagonal direction
#define B(dir,value) ((dir) | ((value)<<2)) // new (direction,value) backtrack
#define BV(b) ((b)>>2)                      // extract the value
#define BD(b) ((b)&3)                       // extract the direction

// Backtrack as (i,j), sizeof(TB)*4 bits available for each coordinate
// in CUDA, might use prmt.b32{.mode}
#define _BSH (sizeof(TB)*4)
#define BP(i,j) ( (i)<<_BSH | (j) )         // new (i,j) backtrack pair
#define BI(bp) ( (bp)>>_BSH)                // extract the i value
#define BJ(bp) ( (bp) & ((1<<_BSH)-1) )     // extract the j value

#define MEM_MATRIX (M_W*M_H+B_H*B_H)
#define MEM_WAVE_D MAX((M_H+B_H-1)/B_H,(M_W+B_W-1)/B_W)

// -----------------------------------------------------------------------------
// CPU helpers

static TI* c_in[2]={NULL,NULL};
static TC* c_cost = NULL;
static TB* c_back = NULL;
#ifdef TW
static TW* c_wave[3] = {NULL,NULL,NULL};
#endif

void c_init() {
	c_in[0]=p_input();
	#ifdef SH_RECT
	c_in[1]=p_input(true);
	#endif
	c_cost=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
	c_back=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
	#ifdef TW
		c_wave[0]=(TW*)malloc(sizeof(TW)*M_H);
		c_wave[1]=(TW*)malloc(sizeof(TW)*M_W);
		c_wave[2]=(TW*)malloc(sizeof(TW)*MEM_WAVE_D);
	#endif
}

void c_free() {
	free(c_in[0]);
	#ifdef SH_RECT
	free(c_in[1]);
	#endif
	free(c_cost); free(c_back);
	#ifdef TW
		for (int i=0;i<3;++i) free(c_wave[i]);
	#endif
}

// -----------------------------------------------------------------------------
// GPU helpers
#ifdef __CUDACC__

static TI* g_in[2]={NULL,NULL};
static TC* g_cost = NULL;
static TB* g_back = NULL;
#ifdef TW
static TW* g_wave[3] = {NULL,NULL,NULL};
#endif

void g_init() {
	TI* tmp = p_input();
	cuMalloc(g_in[0],sizeof(TI)*M_H);
	cuPut(tmp,g_in[0],sizeof(TI)*M_H,NULL);
	free(tmp);
	#ifdef SH_RECT
		tmp = p_input(true);
		cuMalloc(g_in[1],sizeof(TI)*M_W);
		cuPut(tmp,g_in[1],sizeof(TI)*M_W,NULL);
		free(tmp);
	#endif
	cuMalloc(g_cost,sizeof(TC)*MEM_MATRIX);
	cuMalloc(g_back,sizeof(TB)*MEM_MATRIX);
	#ifdef TW
		cuMalloc(g_wave[0],sizeof(TW)*M_H);
		cuMalloc(g_wave[1],sizeof(TW)*M_W);
		cuMalloc(g_wave[2],sizeof(TW)*MEM_WAVE_D);
	#endif
}

void g_free() {
	cuFree(g_in[0]);
	#ifdef SH_RECT
	cuFree(g_in[1]);
	#endif
	cuFree(g_cost); cuFree(g_back);
	#ifdef TW
		for (int i=0;i<3;++i) cuFree(g_wave[i]);
	#endif
}

#endif
