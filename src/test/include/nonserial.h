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

// Memory addressing strategies
#if defined(SH_TRI)
	#ifdef M_W
	#undef M_W
	#endif
	#define M_W M_H
	// compact memory addressing: full main diagonal, then the second, ...
	// idx(i,j) = |M| - |/\| - M_H +i
	//      |M| = M_H*(M_H+1)/2
	//     |/\| = d*(d+1)/2
	//        d = 2*M_H-1-(i+j)
	#define MEM_MATRIX ((M_H*(M_H+1))/2) // lower right triangle, including diagonal
	#define idx(i,j) ({ unsigned _i=(i),_j=(j),_d=2*M_H-1-(_i+_j); MEM_MATRIX-M_H - (_d*(_d-1))/2 +_i; })
#elif defined(SH_PARA)
	// parallelogram addressing: leftmost diagonal, then the second, ...
	// this is as a rectangle column-wise but bend
	#define MEM_MATRIX (M_H*M_W)
	#define idx(i,j) ({ unsigned _i=(i); ((_i+(j)-M_H-1)*M_H + _i; })
	//#define idx(i,j) ((j-i)*M_H + i*(M_H+1) )
#elif defined(SH_RECT)
	// block-line addressing: smaller parallelograms in lines of height B_H
	#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)
	#define idx(i,j) ({ unsigned _i=(i); (B_H*((j)+(_i%B_H)) + (_i%B_H) + (_i/B_H)*M_W*B_H) })
#endif

// The wavefront consists of horizontal and/or vertical swipes
#define MEM_WAVEFRONT MAX((M_H+B_H-1)/B_H,(M_W+B_W-1)/B_W)
#define wh_idx(i) (i)
#define wv_idx(j) (M_H+j)

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


#include <list>
#include <utility> // pair

// simply return the pair of indices (i,j) that are in the backtrack
// by default we use the direction-length backtrack
TC c_backtrack(unsigned** bt, unsigned* size) {
	unsigned i,j;

	#ifdef SH_RECT // SWat
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
	#endif


	#ifdef SH_TRI
	TC cost = c_cost[idx(M_H-1,M_H-1)];

	if (bt && size) {
		// XXX: return the length of the parenthesis content at the given position
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;

		std::list<std::pair<int,int> > queue;
		queue.push_back(std::make_pair(M_H-1,M_H-1));

		while (!queue.empty()) {
			std::pair<int,int> p = queue.front(); queue.pop_front();
			i=p.first; j=p.second;

			// vertical flipping
			#define inv(x) (M_H-1-(x))
			track[0]=inv(i); track[1]=j; track+=2; ++sz;

			TB back = c_back[idx(p.first,p.second)];
			if (back!=BSTOP) {
				int k=BV(back);
				queue.push_back(std::make_pair(i,k));
				// XXX: there must be a bug somewhere in indices here
				queue.push_back(std::make_pair(M_H-k-2,j));
			}
		}
		*size=sz;
	}
	#endif

	return cost;
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
			#ifdef SH_RECT
			TB b = back[idx(i,j)];
			if (BV(b)) fprintf(f," %c%2d",d[BD(b)],BV(b));
			else fprintf(f," %c  ",d[BD(b)]);
			#endif
			#ifdef SH_TRI
			if (i+j>=M_H-1) {
				TB b = back[idx(i,j)];
				if (BV(b)) fprintf(f," %c%2d",d[BD(b)],BV(b));
				else fprintf(f," %c  ",d[BD(b)]);
			} else {
				fprintf(f," _  ");
			}

			#endif
			if (j%B_W==B_W-1) fprintf(f," |");
		}
		fprintf(f,"\n");
		// content (score)
		fprintf(f,"  |");
		for (size_t j=0;j<M_W;++j) {
			#ifdef SH_RECT
			fprintf(f,"%4d",cost[idx(i,j)]);
			#endif
			#ifdef SH_TRI
			if (i+j>=M_H-1) fprintf(f,"%4d",cost[idx(i,j)]);
			else fprintf(f,"    ");
			#endif
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
