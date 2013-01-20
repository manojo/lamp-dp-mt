#define _infinity c=COST_MAX;
#ifdef SH_RECT
#define _ini(i) in0[i]
#define _inj(j) in1[j]
#endif
#ifdef SH_TRI
#define _in(i) in0[i]
#endif
#ifdef SH_PARA
#define _in(i) in0[i%M_H]
#endif

#define _cost(i,j) cost[idx(i,j)]
#define _max_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2>c) { c=c2; b=BACK; } }
#define _max(EXPR,BACK) c2=EXPR; if (c2>=c) { c=c2; b=BACK; }
#define _min_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2<c) { c=c2; b=BACK; } }
#define _min(EXPR,BACK) c2=EXPR; if (c2<=c) { c=c2; b=BACK; }

// -----------------------------------------------------------------------------

__global__ void gpu_solve(const TI* in0, const TI* in1, TC* cost, TB* back, volatile unsigned* lock, unsigned s0, unsigned s1) {
	const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x; // * (  + blockIdx.y*gridDim.x );
	const unsigned tN = blockDim.x * gridDim.x;
	const unsigned tB = blockIdx.x;
	unsigned tP=0; // block progress
	/*
	 * Optimizations to implement when we are confident about the problem structure:
	 * SH_RECT: Since we sweep the rectangle with a diagonal, at iteration M_W+(tN+1)/2
	 *          half of them will we unused. At this point, break the loop and construct
	 *          a new loop where 2 threads are assigned the same cell, that is thread tI
	 *          is assigned to cell (i/2, j). We would require tI/2 shared cost cells to
	 *          exchange maximal cost, the cell with cost=maximum writes (cost,backtrack)
	 *          to the original matrices.
	 * SH_TRI : Similarly, when half of the threads go out of the triangle, we can reassign
	 *          two threads per cell, then repeat the operation at 4 and 8 (possibly 16 and 32).
	 * SH_PARA: No optimization possible since every pair of thread has very different dependences
     */

#ifdef SH_RECT
	// 1 block = 88ms, 128x128, correct, down to 30ms with multi-blocks
	// 1043ms for 1024x1024 => we are above "Optimizing DP on GPU via adaptive thread parallelism"
	// => we need to use the same technique as they do (but first compare on the same problem)
	const unsigned jjN = tN + M_W;
	for (unsigned i=tI; i<M_H; i+=tN) {
		for (unsigned jj=0; jj<jjN; ++jj) {
			unsigned j = jj-tI;
			if (j<M_W) {
	//for (unsigned i=0; i<M_H; ++i) {
	//	for (unsigned j=0; j<M_W; ++j) { {
#endif
#ifdef SH_TRI
	for (unsigned ii=tI; ii<M_H; ii+=tN) {
		unsigned i=M_H-1-ii;
		for (unsigned j=i; j<M_W+i; ++j) {
			if (j<M_W) {
	//for (unsigned ii=0; ii<M_H; ++ii) { unsigned i=M_H-1-ii;
	//	for (unsigned j=i; j<M_W; ++j) { {
#endif
#ifdef SH_PARA
	for (unsigned jj=s0; jj<s1; ++jj) {
		{
			for (unsigned i=tI; i<M_H; i+=tN) {
				unsigned j=jj+i;
	//for (unsigned jj=0; jj<M_W; ++jj) {
	//	for (unsigned i=0; i<M_H; ++i) { unsigned j=jj+i; {
#endif
				TB b=BT_STOP; __attribute__((unused)) TC c=INIT_VAL,c2; // stop
				if (!INIT(i,j)) { p_kernel }
				cost[idx(i,j)] = c;
				back[idx(i,j)] = b;
			}
			// Sync between blocks, removing __threadfence() is incorrect but works
			// __threadfence();
			#ifdef SH_PARA // wait for all blocks
			__syncthreads();
			++tP; if (threadIdx.x==0) lock[tB]=tP;
			for (unsigned b=threadIdx.x;b<gridDim.x;b+=blockDim.x) { // sync with all blocks
				while(lock[(tB+b)%gridDim.x]<tP) {}
			}
			#else // wait for previous block only
			if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
			#endif
			__syncthreads();
		}
	}

	// Sync with all blocks at exit
	/*
	__syncthreads();
	tP=0; if (threadIdx.x==0) lock[tB]=0;
	for (unsigned b=threadIdx.x;b<gridDim.x;b+=blockDim.x) {
		while(lock[(tB+b)%gridDim.x]!=0) {}
	}
	*/
}

void g_solve() {
	unsigned blk_size = 32; // = warp size
	unsigned blk_num = (M_H+blk_size-1)/blk_size;
#ifdef SH_PARA // 384 cores (GF650M) XXX: find out exactly why
	if (blk_num>32) blk_num=32;
#endif
	unsigned* lock;
	cuMalloc(lock,sizeof(unsigned)*blk_num);
	cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));
	int splits = (M_W+M_H)/4096;
	if (splits<1) splits=1;
	splits = splits*splits*splits;
	for (int i=0;i<splits;++i) {
		unsigned s0=(M_W*i)/splits;
		unsigned s1=(M_W*(i+1))/splits;
		gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in[0], g_in[1], g_cost, g_back, lock, s0, s1);
	}
	cuSync(stream);
	cuErr(cudaStreamDestroy(stream));
	cuFree(lock);
}

TS g_backtrack(unsigned** bt, unsigned* size) {
	TS cost;
	unsigned i,j;

	// Find the position with maximal cost along bottom+right borders
	unsigned mi=0; TS ci=0;
	unsigned mj=0; TS cj=0;
	for (unsigned i=0; i<M_H; ++i) { TS c=TS_MAP(c_cost[idx(i,M_W-1)]); if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TS c=TS_MAP(c_cost[idx(M_H-1,j)]); if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	cost = TS_MAP(c_cost[idx(i,j)]);
	// Backtrack, returns a pair of coordinates in reverse order
	if (bt && size) {
		TB b;
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;
		do {
			track[0]=i; track[1]=j; track+=2; ++sz;
			b = c_back[idx(i,j)];
			switch(BT_D(b)) {
				case DIR_LEFT: j-=BT_V(b); break;
				case DIR_UP: i-=BT_V(b); break;
				case DIR_DIAG: i-=BT_V(b); j-=BT_V(b); break;
			}
		} while (b!=BT_STOP);
		*size=sz;
	}
	return cost;
}
