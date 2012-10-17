// NON-SERIAL:
// - Non-serial problem, fills a square, triangle or parallelogram matrix
// - All the data fits in the GPU memory
// - Progress must be possible along anti-diagonal in parallel
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
#if !defined(M_H) || !defined(M_W) || !defined(B_H) || !defined(B_W)
#error "Matrix or block dimensions missing"
#endif

// -----------------------------------------------------------------------------
// Memory addressing strategies
#if defined(SH_TRI)
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
	// parallelogram address: leftmost diagonal, then the second, ...
	// circular structure for n steps, hence the modulo
	#define MEM_MATRIX (M_H*M_W)
	#define idx(i,j) ({ unsigned _i=(i); ((j)-_i)*M_H + _i%M_H; })
#elif defined(SH_RECT)
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

void c_init() {
	c_in[0]=p_input();
	#ifdef SH_RECT
	c_in[1]=p_input(true);
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

// -----------------------------------------------------------------------------
// Debug helpers

// Pretty print the matrix(cost+backtrack) into the file descriptor
void dbg_print(bool gpu, FILE* f) {
	TI* in0 = c_in[0];
	TI* in1 = c_in[1];
	TB* back = c_back;
	TC* cost = c_cost;
	if (gpu) {
		in0=(TI*)malloc(sizeof(TI)*M_H);
		in1=(TI*)malloc(sizeof(TI)*M_W);
		back=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
		cost=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
		#ifdef __CUDACC__
		cuStream(stream);
		cuGet(in0,g_in[0],sizeof(TI)*M_H,stream);
		cuGet(in1,g_in[1],sizeof(TI)*M_W,stream);
		cuGet(back,g_back,sizeof(TB)*MEM_MATRIX,stream);
		cuGet(cost,g_cost,sizeof(TC)*MEM_MATRIX,stream);
		cuSync(stream);
		cuStrFree(stream);
		#endif
	}

	#if defined(SH_RECT)
		const char d[]={'#','|','-','\\'};
		#define PR_W M_W
		#define PR_BACK TB b = back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else if (BT_V(b)) fprintf(f," %c%-2d",d[BT_D(b)],BT_V(b)); else fprintf(f," %c  ",d[BT_D(b)]);
		#define PR_COST fprintf(f,"%4ld",(long)cost[idx(i,j)]);
	#elif defined(SH_TRI)
		#define PR_W M_W
		#define PR_BACK if (i<=j) { TB b=back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else fprintf(f," _%-2d",b); } else fprintf(f,"    ");
		#define PR_COST if (i<=j) fprintf(f,"%4ld",(long)cost[idx(i,j)]); else fprintf(f,"    ");
	#elif defined(SH_PARA)
		#define PR_W (2*M_W)
		#define PR_BACK if (i<=j && j<i+M_W) { TB b=back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else fprintf(f," _%-2d",b); } else fprintf(f,"    ");
		#define PR_COST if (i<=j && j<i+M_W) fprintf(f,"%4ld",(long)cost[idx(i,j)]); else fprintf(f,"    ");
	#endif

	fprintf(f,"Matrix(%ldx%ld), blocks(%ldx%ld)\n",M_H,M_W,B_H,B_W);
	fprintf(f,"  |");
	// header
	for (size_t j=0;j<PR_W;++j) { fprintf(f," %c  ",TI_CHR(in1[j%M_W])); if (j%B_W==B_W-1) fprintf(f," |"); }
	fprintf(f,"\n");
	for (size_t i=0;i<=M_H;++i) {
		// spacer
		if (i%B_H==0) {
			fprintf(f,"--+");
			for (size_t j=0;j<PR_W;++j) { fprintf(f,"----"); if (j%B_W==B_W-1) fprintf(f,"-+"); }
			fprintf(f,"\n");
		}
		if (i==M_H) break;
		// content (backtrack)
		fprintf(f,"%c |",TI_CHR(in0[i]));
		for (size_t j=0;j<PR_W;++j) { PR_BACK if (j%B_W==B_W-1) fprintf(f," |"); }
		fprintf(f,"\n");
		// content (score)
		fprintf(f,"  |");
		for (size_t j=0;j<PR_W;++j) { PR_COST if (j%B_W==B_W-1) fprintf(f," |"); }
		fprintf(f,"\n");
	}

	if (gpu) { free(in0); free(in1); free(back); free(cost); }
}

// Backtrack the solved problem and pretty-print it
void dbg_track(bool gpu, FILE* f) {
	// XXX: add for GPU
	unsigned* bt;
	unsigned sz;
	unsigned score = c_backtrack(&bt,&sz);
	fprintf(f,"Backtrack with best score : %d\n",score);
	if (sz) for (unsigned i=sz-1;;--i) {
		printf("(%d,%d) ",bt[i*2],bt[i*2+1]);
		if (!i) break;
	}
	printf("\n");
	free(bt);
}

// Checks that the CPU and GPU implementation return the same costs
// Note that backtrack may vary depending the ordering of paths selection
void dbg_compare(bool full=false) {
	#ifdef __CUDACC__
	cudaMemset(g_cost,0xff,sizeof(TC)*MEM_MATRIX);
	cudaMemset(g_back,0xff,sizeof(TB)*MEM_MATRIX);
	g_solve();
	#endif
	TC* tc=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
	TB* tb=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
	#ifdef __CUDACC__
	cuGet(tc,g_cost,sizeof(TC)*MEM_MATRIX,NULL);
	cuGet(tb,g_back,sizeof(TB)*MEM_MATRIX,NULL);
	#endif
	c_solve();
	int err=0;
	#ifdef SH_RECT // some extra memory is needed, we want to ignore it
	for (int i=0;i<M_H;++i) for (int j=0;j<M_W;++j) { if (tc[idx(i,j)]!=c_cost[idx(i,j)]) ++err; }
	#else
	for (unsigned i=0;i<MEM_MATRIX;++i) { if (tc[i]!=c_cost[i]) ++err; }
	#endif
	if (err==0) fprintf(stderr,"Compare cpu/gpu: identical.\n");
	else fprintf(stderr,"Compare cpu/gpu: WARNING %d ERRORS !!\n",err);
	free(tc);
	free(tb);
}

// Initialize some structures
void dbg_init() {
	#ifdef __CUDACC__
	cuInfo();
	#endif
	c_init();
	#ifdef __CUDACC__
	g_init();
	#endif
}

// Cleanup the initialized structures
void dbg_cleanup() {
	c_free();
	#ifdef __CUDACC__
	g_free();
	cudaDeviceReset();
	#endif
}

// -----------------------------------------------------------------------------
// Unused functions

#if 0
// Check the memory addressing / together with print
void dbg_checkmem() {
	// Memory mapping
	//for (int i=0;i<MEM_MATRIX;++i) { c_cost[i]=i; c_back[i]=BT_STOP; }
	// Swipe lines and columns numbers
	#define CHK(i0,in,j0,jn,x) for (unsigned i=i0;i<in;++i) for (unsigned j=j0;j<jn;++j) { c_cost[idx(i,j)]=x; c_back[idx(i,j)]=BT_STOP; } dbg_print(false,stdout);
	#ifdef SH_RECT
	CHK(0,M_H,0,M_W,i) CHK(0,M_H,0,M_W,j)
	#endif
	#ifdef SH_PARA
	CHK(0,M_H,i,i+M_W,i) CHK(0,M_H,i,i+M_W,j)
	#endif
	#ifdef SH_TRI
	CHK(0,M_H,i,M_W,i) CHK(0,M_H,i,M_W,j)
	#endif
}

// Get additional data to check correctness of printed solution
void dbg_print2() {
	#ifdef SH_TRI
		mat_t* in0=c_in[0];
		for (unsigned i=0; i<M_H; ++i) printf("%dx%d ",in0[i].rows,in0[i].cols); printf("\n");
	#endif
	#ifdef SH_PARA
		for (unsigned i=0;i<M_H;++i) {
			for (unsigned j=i+1;j<=i+M_W;++j) {
				printf("<%c-%c> = %2ld  ",c_in[0][i],c_in[0][j%M_H],p_cost(c_in[0][i],c_in[0][j%M_H]));
			}
			printf("\n");
		}
	#endif
}

#endif
