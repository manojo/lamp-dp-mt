// SMALL PROBLEMS: serial and non-serial problems that fit into device memory
// - Non-serial problem, fills a square, triangle or parallelogram matrix
// - All the data fits in the GPU memory (up to about 12K x 12K matrix)
// - Progress must be possible along one (anti-)diagonal in parallel
//
//      SH_RECT          SH_TRI               SH_PARA
// +---------------+  +-----------+  +-----------+-----------+ --
// | 0 2 4 6 8     |  | \ 0 4     |  | \ 0 5       \ X X X X |
// | 3 5 7 9       |  | X \ 1 5   |  | X \ 1 6       \ X X X |
// |   ¨ ¨ ¨ B_H   |  | X X \ 2 6 |  | X X \ 2 7       \ X X | M_H
// |               |  | X X X \ 3 |  | X X X \ 3 8       \ X |
// |               |  | X X X X \ |  | X X X X \ 4 9       \ |
// +---------------+  +-----------+  +-----------+-----------+ --
// |      M_W      |  |    M_H    |              |    M_W    |
//
// -----------------------------------------------------------------------------
// Ensure we picked exactely one shape
#if defined(SH_RECT)&&defined(SH_TRI) || defined(SH_TRI)&&defined(SH_PARA) || defined(SH_PARA)&&defined(SH_RECT)
#error "Cannot define two shapes for the matrix"
#endif
#if !defined(SH_RECT)&&!defined(SH_TRI)&&!defined(SH_PARA)
#error "Matrix must have a shape"
#endif
#if !defined(M_H) || !defined(M_W)
#error "Matrix dimensions undefined"
#endif

#if !defined(B_H) || !defined(B_W)
#undef B_H
#undef B_W
#define B_W 32LU
#define B_H 32LU
#endif

// -----------------------------------------------------------------------------
// Memory addressing strategies
#if defined(SH_TRI)
	#define SH_SHAPE "Triangle"
	#ifdef M_W
	#undef M_W
	#endif
	#define M_W M_H
	// compact triangle address: full main diagonal, then the second, ...
	// idx(i,j) = |M| - |/\| +i  (with |M|=MEM_MATRIX)
	//     |/\| = d*(d+1)/2      (smallest triangle including position element)
	//        d = M_H+1+_i-_j
	#define MEM_MATRIX ((M_H*(M_H+1))/2) // lower right triangle, including diagonal
	#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - (_d*(_d-1))/2 +_i; })
#elif defined(SH_PARA)
	#define SH_SHAPE "Parallelogram"
	// parallelogram address: leftmost diagonal, then the second, ...
	// circular structure for n steps, hence the modulo
	#define MEM_MATRIX (M_H*M_W)
	#define idx(i,j) ({ unsigned _i=(i); ((j)-_i)*M_H + _i%M_H; })
#elif defined(SH_RECT)
	#define SH_SHAPE "Rectangle"
	// block-lines address: smaller parallelograms in lines of height B_H
	#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)
	#define idx(i,j) ({ unsigned _i=(i); (B_H*((j)+(_i%B_H)) + (_i%B_H) + (_i/B_H)*M_W*B_H); })
#endif

// Wavefront: horizontal and vertical swipes
#define MEM_WAVEFRONT MAX((M_H+B_H-1)/B_H,(M_W+B_W-1)/B_W)
#define wh_idx(i) (i)
#define wv_idx(j) (M_H+j)

// -----------------------------------------------------------------------------
// Maximal cost
#define COST_MAX ((1ULL<<(sizeof(TC)*8-1))-1) // max signed value

// Backtracking
#define BT_STOP ((TB)(~0ULL)) // = 0xff...ff        // base case, stop backtracking
// - (direction,value), sizeof(TB)*8-2 bits available for the value
#define DIR_UP   0x1 // up direction
#define DIR_LEFT 0x2 // left direction
#define DIR_DIAG 0x3 // up-left diagonal direction
#define BT(dir,value) ((dir) | ((value)<<2)) // new (direction,value) backtrack
#define BT_V(b) ((b)>>2)                      // extract the value
#define BT_D(b) ((b)&3)                       // extract the direction

// Backtrack as (i,j), sizeof(TB)*4 bits available for each coordinate
// in CUDA, might use prmt.b32{.mode}
// #define _BSH (sizeof(TB)*4)
// #define BP(i,j) ( (i)<<_BSH | (j) )      // new (i,j) backtrack pair
// #define BI(bp) ( (bp)>>_BSH)             // extract the i value
// #define BJ(bp) ( (bp) & ((1<<_BSH)-1) )  // extract the j value

// -----------------------------------------------------------------------------
// Solve the recurrence by filling the matrix
void c_solve(); // CPU
void g_solve(); // GPU
// Backtrack the solution, using the matrix
TC c_backtrack(unsigned** bt, unsigned* size);
TC g_backtrack(unsigned** bt, unsigned* size);

// -----------------------------------------------------------------------------
// CPU helpers
static TI* c_in[2]={NULL,NULL};
static TC* c_cost = NULL;
static TB* c_back = NULL;
#ifdef TW
static TW* c_wave = NULL;
#endif

void c_init(TI* in0, TI* in1) {
	c_in[0]=in0;
	#ifdef SH_RECT
	c_in[1]=in1;
	#else
	c_in[1]=c_in[0];
	#endif
	c_cost=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
	c_back=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
	#ifdef TW
	c_wave=(TW*)malloc(sizeof(TW)*(M_H+M_W));
	#endif
}

void c_free() {
	free(c_in[0]);
	#ifdef SH_RECT
	free(c_in[1]);
	#endif
	free(c_cost); free(c_back);
	#ifdef TW
	free(c_wave);
	#endif
}

// -----------------------------------------------------------------------------
// GPU helpers
#ifdef __CUDACC__
static TI* g_in[2]={NULL,NULL};
static TC* g_cost = NULL;
static TB* g_back = NULL;
#ifdef TW
static TW* g_wave = NULL;
#endif

void g_init(TI* in0, TI* in1) {
	cuMalloc(g_in[0],sizeof(TI)*M_H);
	cuPut(in0,g_in[0],sizeof(TI)*M_H,NULL);
	#ifdef SH_RECT
		cuMalloc(g_in[1],sizeof(TI)*M_W);
		cuPut(in1,g_in[1],sizeof(TI)*M_W,NULL);
	#else
		g_in[1]=g_in[0];
	#endif
	cuMalloc(g_cost,sizeof(TC)*MEM_MATRIX);
	cuMalloc(g_back,sizeof(TB)*MEM_MATRIX);
	#ifdef TW
	cuMalloc(g_wave,sizeof(TW)*(M_H+M_W));
	#endif
}

void g_free() {
	cuFree(g_in[0]);
	#ifdef SH_RECT
	cuFree(g_in[1]);
	#endif
	cuFree(g_cost); cuFree(g_back);
	#ifdef TW
	cuFree(g_wave);
	#endif
}
#endif
