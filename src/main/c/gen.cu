#include "include/common.h"

// XXX: place unroll appropriately in code (generated)
#define _unroll _Pragma ("unroll 5") // Optimized by hand for my GPU
#define M_W 9UL // == size(input1) + 1
#define M_H 9UL // == M_W || size(input2) + 1 if (twotracks)

// -----------------------------------------------------------------------------

// Type: sequence parser
// Rule #0  'm1'     : id=1  alt=2  cat=1  min=1 , max=-1
// Rule #1  'aggr'   : id=0  alt=1  cat=2  min=3 , max=-1
// Rule #2  'm2'     : id=3  alt=1  cat=0  min=1 , max=-1
typedef struct __T2ii T2ii;
typedef struct __T3iii T3iii;
typedef struct __bt0 bt0;
typedef struct __bt1 bt1;
typedef struct __bt2 bt2;
struct __T2ii { int _1; int _2; };
struct __T3iii { int _1; int _2; int _3; };
struct __bt0 { short rule; };
struct __bt1 { short rule; short pos[1]; };
struct __bt2 { short rule; short pos[2]; };
__device__ inline T3iii fun0(T2ii i) { return (T3iii){i._1,0,i._2}; }
__device__ inline int fun1(T3iii a) { return a._2; }
__device__ inline T3iii fun2(T3iii l, T3iii r) { return (T3iii){l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3}; }
__device__ inline bool fun3(int i, int j) { return i%2==j%2; }
#define TI T2ii
typedef struct { T3iii m1; T3iii aggr; T3iii m2; } cost_t;
#define TC cost_t
typedef struct { bt1 m1; bt2 aggr; bt0 m2; } back_t;
#define TB back_t
typedef struct { short i,j,rule; short pos[2]; } trace_t;
#define MEM_MATRIX ((M_H*(M_H+1))/2)
#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - (_d*(_d-1))/2 +_i; })
static TI *g_in1 = NULL, *g_in2 = NULL;
static cost_t *g_cost = NULL;
static back_t *g_back = NULL;
void g_init(TI* in1, TI* in2);
void g_free();
void g_solve();
T3iii g_backtrack(trace_t* trace, unsigned* size);

__global__ void gpu_solve(const TI* in1, const TI* in2, TC* cost, TB* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
  const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;
  const unsigned tN = blockDim.x * gridDim.x;
  const unsigned tB = blockIdx.x;
  unsigned tP=s_start; // block progress
  for (unsigned jj=s_start; jj<s_stop; ++jj) {
    for (unsigned ii=tI; ii<M_H; ii+=tN) {
      unsigned i = M_H-1-ii, j = i+jj;
      if (j<M_W) {
        back_t _back = {{-1,{0}},{-1,{0,0}},{-1}};
        cost_t _cost = {}; // init to 0
        #define VALID(I,J,RULE) (back[idx(I,J)].RULE.rule!=-1)
        /* --- m1[i,j] --- */
        if (i+1==j) {
          T3iii _c=fun0(in1[i]); if (fun1(_c)<fun1(_cost.m1) || _back.m1.rule==-1) { _cost.m1=_c; _back.m1=(bt1){1}; }
        }
        for(int k=i+1; k<j; ++k) {
          T3iii _c=fun2(cost[idx(i,k)].m1,cost[idx(k,j)].m1); if (fun1(_c)<fun1(_cost.m1) || _back.m1.rule==-1) { _cost.m1=_c; _back.m1=(bt1){2,{k}}; }
        }
        /* --- aggr[i,j] --- */
        for(int k=i+1,ku=j-2; k<=ku; ++k) {
          T3iii _c1; bt0 _b1={-1};
          if (i+1<=k && 1==0) {
            T3iii _c=fun2((T3iii){},cost[idx(i,k)].m1); if (fun1(_c)<fun1(_c1) || _b1.rule==-1) { _c1=_c; _b1=(bt0){0}; }
          }
          T3iii _c2; bt1 _b2={-1,{}};
          for(int l=k+1; l<j; ++l) {
            if (fun3(k,l)) {
              T3iii _c=fun2(cost[idx(k,l)].m1,cost[idx(l,j)].m1); if (fun1(_c)<fun1(_c2) || _b2.rule==-1) { _c2=_c; _b2=(bt1){0,{l}}; }
            }
          }
          if (_b1.rule!=-1 && _b2.rule!=-1) {
            T3iii _c=fun2(_c1,_c2); if (fun1(_c)<fun1(_cost.aggr) || _back.aggr.rule==-1) { _cost.aggr=_c; _back.aggr=(bt2){0,{k,_b2.pos[0]}}; }
          }
        }
        /* --- m2[i,j] --- */
        if (i+1<=j) {
          T3iii _c=cost[idx(i,j)].m1; if (fun1(_c)<fun1(_cost.m2) || _back.m2.rule==-1) { _cost.m2=_c; _back.m2=(bt0){3}; }
        }
        cost[idx(i,j)] = _cost;
        back[idx(i,j)] = _back;
      }
    }
    // Sync between blocks, removing __threadfence() here is incorrect but works
    // __threadfence();
    if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
    __syncthreads();
  }
}

__global__ void gpu_backtrack(trace_t* trace, unsigned* size, TB* back, int i0, int j0) {
  const unsigned trace_len[4] = {2,1,1,0};
  trace_t *rd=trace, *wr=trace; *size=0;
  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++(*size); }
  PUSH_BACK(i0,j0,1);
  for(;rd<wr;++rd) {
    bt2* bt;
    switch (rd->rule) {
      case 0: bt=(bt2*)&back[idx(rd->i,rd->j)].aggr; break;
      case 1: bt=(bt2*)&back[idx(rd->i,rd->j)].m1; break;
      case 2: bt=(bt2*)&back[idx(rd->i,rd->j)].m1; break;
      case 3: bt=(bt2*)&back[idx(rd->i,rd->j)].m2; break;
    }
    rd->rule=bt->rule;
    for (int i=0,l=trace_len[rd->rule]; i<l; ++i) rd->pos[i]=bt->pos[i];
    switch (rd->rule) {
      case 0: PUSH_BACK(rd->i+0,rd->pos[0],1); PUSH_BACK(rd->pos[0],rd->pos[1],1); PUSH_BACK(rd->pos[1],rd->j,1); break;
      case 1: break;
      case 2: PUSH_BACK(rd->i,rd->pos[0],1); PUSH_BACK(rd->pos[0],rd->j,1); break;
      case 3: PUSH_BACK(rd->i,rd->j,1); break;
    }
  }
}

void g_init(TI* in1, TI* in2) {
  cuMalloc(g_in1,sizeof(TI)*(M_H-1));
  cuPut(in1,g_in1,sizeof(TI)*(M_H-1),NULL);
  g_in2=NULL;
  cuMalloc(g_cost,sizeof(TC)*MEM_MATRIX);
  cuMalloc(g_back,sizeof(TB)*MEM_MATRIX);
}

void g_free() { cuFree(g_in1); cuFree(g_cost); cuFree(g_back); cudaDeviceReset(); }

void g_solve() {
  #define WARP_SIZE 32 // constant over CUDA devices
  unsigned blk_size = WARP_SIZE;
  unsigned blk_num = (M_H+blk_size-1)/blk_size;
  unsigned* lock;
  cuMalloc(lock,sizeof(unsigned)*blk_num);
  cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
#ifdef SPLITS
  cudaStream_t stream;
  cuErr(cudaStreamCreate(&stream));
  for (int i=0;i<SPLITS;++i) {
    #ifdef SH_RECT
    unsigned s0=((M_H+M_W)*i)/SPLITS;
    unsigned s1=((M_H+M_W)*(i+1))/SPLITS;
    #else
    unsigned s0=(M_W*i)/SPLITS;
    unsigned s1=(M_W*(i+1))/SPLITS;
    #endif
    gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in1, g_in2, g_cost, g_back, lock, s0, s1);
  }
  cuSync(stream);
  cuErr(cudaStreamDestroy(stream));
#else
  #ifdef SH_RECT
  unsigned s1 = M_W+M_H;
  #else
  unsigned s1 = M_W;
  #endif
  gpu_solve<<<blk_num, blk_size, 0, NULL>>>(g_in1, g_in2, g_cost, g_back, lock, 0, s1);
#endif
  cuFree(lock);
}

T3iii g_backtrack(trace_t** trace, unsigned* size) {
  unsigned mem=(M_W+M_H)*sizeof(trace_t);
  trace_t *g_trace=NULL; cuMalloc(g_trace,mem);
  unsigned *g_size=NULL; cuMalloc(g_size,sizeof(unsigned));
  unsigned i0=0, j0=M_W-1;
  gpu_backtrack<<<1,1,0,NULL>>>(g_trace, g_size, g_back, i0, j0);
  cuGet(size,g_size,sizeof(unsigned),NULL); cuFree(g_size); mem=(*size)*sizeof(trace_t);
  *trace=(trace_t*)malloc(mem); cuGet(*trace,g_trace,mem,NULL); cuFree(g_trace);
  T3iii res; cuGet(&res,&g_cost[idx(i0,j0)].m1,sizeof(T3iii),NULL);
  return res;
}

// -----------------------------------------------------------------------------

int main() {
	cudaDeviceReset();
	TI a[8] = {{1,2},{2,20},{20,2},{2,4},    {4,2},{2,1},{1,7},{7,3}};
	// 1,2,2,20,20,2,2,4,4,2,2,1,1,7,7,3
	g_init(a,NULL);

	g_solve();
	trace_t* t;
	unsigned sz;
	T3iii res = g_backtrack(&t,&sz);
	for (unsigned i=0;i<sz;++i) {
		printf("Trace: %2d,%2d : %2d [%d,%d]\n",t[i].i,t[i].j,t[i].rule,
								t[i].pos[0],t[i].pos[1]);
	}

	printf("Result = (%d, %d, %d)\n",res._1,res._2,res._3);

	g_free();
	cudaDeviceReset();
	return 0;
}
