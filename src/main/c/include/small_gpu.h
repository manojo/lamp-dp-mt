#ifdef __CUDACC__
#define WARP_SIZE 32
// -----------------------------------------------------------------------------
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

__global__ void gpu_solve(const TI* in0, const TI* in1, TC* cost, TB* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
	const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x; // * (  + blockIdx.y*gridDim.x );
	const unsigned tN = blockDim.x * gridDim.x;
	const unsigned tB = blockIdx.x;
	unsigned tP=s_start; // block progress

#ifdef SH_RECT
	#ifdef SPLITS
	s_start += (tN*s_start)/M_W;
	s_stop += (tN*s_stop)/M_W;
	tP=s_start;
	#else
	s_stop+=tN;
	#endif

	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned i=tI; i<M_H; i+=tN) {
			unsigned j = jj-i;
			if (j<M_W) {
#endif
#ifdef SH_TRI
	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned ii=tI; ii<M_H; ii+=tN) {
			unsigned i=M_H-1-ii;
			unsigned j=i+jj;
			if (j<M_W) {
#endif
#ifdef SH_PARA
	for (unsigned jj=s_start; jj<s_stop; ++jj) {
		for (unsigned i=tI; i<M_H; i+=tN) {
			unsigned j=jj+i;
			{
#endif
				TB b=BT_STOP; __attribute__((unused)) TC c=INIT_COST,c2; // stop
				if (!INIT(i,j)) { p_kernel }
				cost[idx(i,j)] = c;
				back[idx(i,j)] = b;
			}
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

// -----------------------------------------------------------------------------

void g_solve() {
	unsigned blk_size = WARP_SIZE;
	unsigned blk_num = (M_H+blk_size-1)/blk_size;
#ifdef SH_PARA // 384 cores (GF650M) XXX: find out why deadlock at >32 blocks
	if (blk_num>32) blk_num=32;
#endif
	unsigned* lock;
	cuMalloc(lock,sizeof(unsigned)*blk_num);
	cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
#ifdef SPLITS
	cudaStream_t stream;
	cuErr(cudaStreamCreate(&stream));
	for (int i=0;i<SPLITS;++i) {
		unsigned s0=(M_W*i)/SPLITS;
		unsigned s1=(M_W*(i+1))/SPLITS;
		gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in[0], g_in[1], g_cost, g_back, lock, s0, s1);
	}
	cuSync(stream);
	cuErr(cudaStreamDestroy(stream));
#else
	gpu_solve<<<blk_num, blk_size, 0, NULL>>>(g_in[0], g_in[1], g_cost, g_back, lock, 0, M_W);
#endif
	cuFree(lock);
}

// -----------------------------------------------------------------------------

typedef struct { unsigned size; TS score; } bt_info;
#define QUEUE_PUSH(i,j) { tail[0]=i; tail[1]=j; tail+=2; ++sz; }
#define QUEUE_POP(i,j) { i=head[0]; j=head[1]; head+=2; }
#define QUEUE_EMPTY (head==tail)

__global__ void gpu_backtrack(bt_info* info, unsigned* bt, TC* cost, TB* back) {
	unsigned i,j,sz=0,*tail=bt;
	#ifndef SH_RECT
	unsigned *head=bt;
	#endif

#if SH_RECT
	// Find the position with maximal cost along bottom+right borders
	unsigned mi=0; TS ci=0;
	unsigned mj=0; TS cj=0;
	for (unsigned i=0; i<M_H; ++i) { TS c=TS_MAP(cost[idx(i,M_W-1)]); if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TS c=TS_MAP(cost[idx(M_H-1,j)]); if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }
	info->score = TS_MAP(cost[idx(i,j)]);

	// Backtrack, returns a pair of coordinates in reverse order
	if (!bt) return;
	TB b;
	do {
		QUEUE_PUSH(i,j)
		b = back[idx(i,j)];
		switch(BT_D(b)) {
			case DIR_LEFT: j-=BT_V(b); break;
			case DIR_UP: i-=BT_V(b); break;
			case DIR_DIAG: i-=BT_V(b); j-=BT_V(b); break;
		}
	} while (b!=BT_STOP);
#endif

#ifdef SH_TRI
	info->score = cost[idx(0,M_H-1)];
	if (!bt) return;
	QUEUE_PUSH(0,M_H-1);
	while (!QUEUE_EMPTY) {
		QUEUE_POP(i,j)
		TB k = back[idx(i,j)];
		if (k!=BT_STOP) {
			QUEUE_PUSH(i,k);
			QUEUE_PUSH(k+1,j);
		}
	}
#endif

#ifdef SH_PARA
	i=0,j=M_W-1;
	unsigned score=cost[idx(i,j)];
	for (unsigned k=1;k<M_H;++k) { // find max along last diagonal
		TC c2=cost[idx(k,M_W-1+k)];
		if (c2>score) { score=c2; i=k; j=M_W-1+k; }
	}
	info->score=score;

	if (!bt) return;
	QUEUE_PUSH(i,j);
	while (!QUEUE_EMPTY) {
		// queue pop + modulo
		i=head[0]; j=head[1];
		head[0]=i%M_H; head[1]=j%M_H;
		head+=2;

		TB k = back[idx(i,j)];
		if (k!=BT_STOP) {
			if (k-i>1) QUEUE_PUSH(i,k);
			if (j-k>1) QUEUE_PUSH(k,j);
		}
	}
#endif
	info->size=sz;
}

TS g_backtrack(unsigned** bt, unsigned* size) {
	//if (bt && size) { *size=0; *bt=NULL; } return 0;
	const unsigned sz=(M_W+M_H)*2*sizeof(unsigned);
	const bool full = bt && size;
	unsigned *g_bt=NULL;
	bt_info *g_info, info;

	if (full) { cuMalloc(g_bt,sz); *bt=(unsigned*)malloc(sz); }
	cuMalloc(g_info,sizeof(bt_info));
	gpu_backtrack<<<1, 1, 0, NULL>>>(g_info, g_bt, g_cost, g_back);
	cuGet(&info,g_info,sizeof(bt_info),NULL); cuFree(g_info);
	if (full) { *size=info.size; cuGet(*bt,g_bt,sz,NULL); cuFree(g_bt); }
	return info.score;
}

// -----------------------------------------------------------------------------
#endif
