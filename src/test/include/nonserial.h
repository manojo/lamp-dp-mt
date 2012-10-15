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
#if !defined(M_H) || !defined(M_W) || !defined(B_H) || !defined(B_W)
#error "Matrix or block dimensions missing"
#endif

#ifndef SH_RECT
#ifdef M_W
#undef M_W
#endif
#define M_W M_H
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
// #define _BSH (sizeof(TB)*4)
// #define BP(i,j) ( (i)<<_BSH | (j) )      // new (i,j) backtrack pair
// #define BI(bp) ( (bp)>>_BSH)             // extract the i value
// #define BJ(bp) ( (bp) & ((1<<_BSH)-1) )  // extract the j value

#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)
#define MEM_WAVE_D MAX((M_H+B_H-1)/B_H,(M_W+B_W-1)/B_W)

// element indices
_hostdev _inline unsigned idx(unsigned i, unsigned j) {
	#ifdef SH_PARA
		return B_H*((j%M_W)+(i%B_H)) + (i%B_H) + (i/B_H)*M_W*B_H;
	#else
		return B_H*(j+(i%B_H)) + (i%B_H) + (i/B_H)*M_W*B_H;
	#endif
}

// -----------------------------------------------------------------------------
// Solve the recurrence/fill the matrix
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

// simply return the pair of indices (i,j) that are in the backtrack
// by default we use the direction-length backtrack
TC c_backtrack(unsigned** bt, unsigned* size) {
	unsigned i,j;
	// Find the position with maximal cost
	unsigned mi=0; TC ci=0;
	unsigned mj=0; TC cj=0;
	for (unsigned i=0; i<M_H; ++i) { TC c=c_cost[idx(i,M_W-1)]; if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TC c=c_cost[idx(M_H-1,j)]; if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	TC cost = c_cost[idx(i,j)];
	// Backtrack, returns a pair of coordinates in reverse order
	if (bt && size) {
		TB b;
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;
		do {
			track[0]=i; track[1]=j; track+=2; ++sz;
			b = c_back[idx(i,j)];
			switch(BD(b)) {
				case DIR_LEFT: j-=BV(b); break;
				case DIR_UP: i-=BV(b); break;
				case DIR_DIAG: i-=BV(b); j-=BV(b); break;
			}
		} while (b!=BSTOP);
		*size=sz;
	}
	return cost;
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

	const char d[]={'#','|','-','\\'};
	fprintf(f,"Matrix(%ldx%ld), blocks(%ldx%ld)\n",M_H,M_W,B_H,B_W);
	fprintf(f,"  |");
	// header
	for (size_t j=0;j<M_W;++j) { fprintf(f," %c  ",TI_CHR(in1[j])); if (j%B_W==B_W-1) fprintf(f," |"); }
	fprintf(f,"\n");
	for (size_t i=0;i<M_H;++i) {
		// spacer
		if (i%B_H==0) {
			fprintf(f,"--+");
			for (size_t j=0;j<M_W;++j) { fprintf(f,"----"); if (j%B_W==B_W-1) fprintf(f,"-+"); }
			fprintf(f,"\n");
		}
		// content (backtrack)
		fprintf(f,"%c |",TI_CHR(in0[i]));
		for (size_t j=0;j<M_W;++j) {
			TB b = back[idx(i,j)];
			if (BV(b)) fprintf(f," %c%2d",d[BD(b)],BV(b));
			else fprintf(f," %c  ",d[BD(b)]);

			if (j%B_W==B_W-1) fprintf(f," |");
		}
		fprintf(f,"\n");
		// content (score)
		fprintf(f,"  |");
		for (size_t j=0;j<M_W;++j) {
			TB c = cost[idx(i,j)];
			fprintf(f,"%4d",c);
			if (j%B_W==B_W-1) fprintf(f," |");
		}
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
	for (unsigned i=sz-1;;--i) {
		printf("(%d,%d) ",bt[i*2],bt[i*2+1]);
		if (!i) break;
	}
	printf("\n");
	free(bt);
}

// Checks that the CPU and GPU implementation return the same costs
// Note that backtrack may vary depending the ordering of paths selection
void dbg_compare(bool full=false) {
	cudaMemset(g_cost,0xff,sizeof(TC)*MEM_MATRIX);
	cudaMemset(g_back,0xff,sizeof(TB)*MEM_MATRIX);
	g_solve();
	TC* tc=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
	TB* tb=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
	#ifdef __CUDACC__
	cuGet(tc,g_cost,sizeof(TC)*MEM_MATRIX,NULL);
	cuGet(tb,g_back,sizeof(TB)*MEM_MATRIX,NULL);
	#endif
	c_solve();
	int err=0;
	for (int i=0;i<M_H;++i) {
		for (int j=0;j<M_W;++j) {
			if (tc[idx(i,j)]!=c_cost[idx(i,j)]) { ++err; if (full) printf(" (%d,%d)",i,j); }
		}
	}
	printf("Compare CPU/GPU: %d errors.\n",err);
	free(tc);
	free(tb);
}

// Initialize some structures
void dbg_init() {
	#ifdef __CUDACC__
	cuInfo();
	#endif
	printf("Matrix: %ldx%ld, blocks: %ldx%ld.\n",M_H,M_W,B_H,B_W);
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
