#include <stdio.h>
#include <stdlib.h>
#include "nu.h"

#define cuReset cudaDeviceReset()
#define cuDevSync cudaDeviceSynchronize()
#define cuErr(err) cuErr_(err,__FILE__,__LINE__)
__attribute__((unused)) static inline void cuErr_(cudaError_t err, const char *file, int line) {
  if (err==cudaSuccess) return;
  fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); cuReset; exit(EXIT_FAILURE);
}
#define cuMalloc(ptr,size) cuErr(cudaMalloc((void**)&ptr,size))
#define cuFree(ptr) cuErr(cudaFree(ptr))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
#define cuMap(host,dev,size) { cuErr(cudaHostAlloc((void**)&host,size,cudaHostAllocMapped)); cuErr(cudaHostGetDevicePointer((void**)&dev,host,0)); }
#define cuUnmap(host) cuErr(cudaFreeHost(host))
#define cuStream(stream) cudaStream_t stream; cuErr(cudaStreamCreate(&stream));
#define cuSync(stream) cuErr(cudaStreamSynchronize(stream))
#define cuStreamDestroy(stream) cuErr(cudaStreamDestroy(stream))
#define cuAlloc2(cond,host,dev,size) bool cond = cudaMalloc((void**)&dev,size)==cudaSuccess; if (!cond) { cuMap(host,dev,size); }
#define cuFree2(host,dev) { if (host!=NULL) { cuUnmap(host); host=NULL; } else cuFree(dev); dev=NULL; }
#define _unroll _Pragma("unroll 5")
#define M_W (SIZE+1)
#define M_H (SIZE+1)
#define MEM_MATRIX ((M_H*(M_H+1))/2)
#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - ((_d*(_d-1))>>1) +_i; })
static input_t *g_in1 = NULL, *g_in2 = NULL;
static cost_t *g_cost = NULL;
static back_t *g_back = NULL;
__device__ static __attribute__((unused)) input_t *_in1=NULL, *_in2=NULL;
__global__ void gpu_input(input_t* in1, input_t* in2) { _in1=in1; _in2=in2; }

__device__ static inline int fun0() { return 0; }
__device__ static inline int fun1(char c, int a) { return a; }
__device__ static inline int fun2(int a, char c) { return a; }
__device__ static inline int fun3(char l, int a, char r) { return a+1; }
__device__ static inline bool fun4(int i, int j) { if (i+2>j) return false; char a=_in1[i],b=_in1[j-1]; return (a=='a'&&b=='u') || (a=='u'&&b=='a') || (a=='g'&&b=='u') || (a=='u'&&b=='g') || (a=='c'&&b=='g') || (a=='g'&&b=='c'); }
__device__ static inline int fun5(int l, int r) { return l+r; }

__global__ void gpu_solve(const input_t* in1, const input_t* in2, cost_t* cost, back_t* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
  const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;
  const unsigned tN = blockDim.x * gridDim.x;
  const unsigned tB = blockIdx.x;
  unsigned tP=s_start; // block progress
  for (unsigned jj=s_start; jj<s_stop; ++jj) {
    for (int ii=tI; ii<M_H; ii+=tN) {
      int i=M_H-1-ii, j=i+jj;
      if (j<M_W) {
        #define VALID(I,J,RULE) (cost[idx(I,J)].RULE!=-1000)
        #include "nu_kern.h"
      }
    }
    // Sync between blocks, removing __threadfence() here is incorrect but works
    // __threadfence();
    if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
    __syncthreads();
  }
}

__global__ void gpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {
  const unsigned trace_len[5] = {1,1,1,1,1};
  trace_t *rd=trace, *wr=trace; *size=0;
  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++(*size); }
  PUSH_BACK(i0,j0,0);
  for(;rd<wr;++rd) {
    bt1* bt;
    switch (rd->rule) {
      case 0: bt=(bt1*)&back[idx(rd->i,rd->j)].s; break;
      case 1: bt=(bt1*)&back[idx(rd->i,rd->j)].s; break;
      case 2: bt=(bt1*)&back[idx(rd->i,rd->j)].s; break;
      case 3: bt=(bt1*)&back[idx(rd->i,rd->j)].s; break;
      case 4: bt=(bt1*)&back[idx(rd->i,rd->j)].s; break;
    }
    rd->rule=bt->rule;
    for (int i=0,l=trace_len[rd->rule]; i<l; ++i) rd->pos[i]=bt->pos[i];
    switch (rd->rule) {
      case 0: break;
      case 1: PUSH_BACK(rd->i+1,rd->j,0); break;
      case 2: PUSH_BACK(rd->i,MAX(rd->i+0,rd->j-1),0); break;
      case 3: PUSH_BACK(rd->i+1,MAX(rd->i+1,rd->j-1),0); break;
      case 4: PUSH_BACK(rd->i,rd->pos[0],0); PUSH_BACK(rd->pos[0],rd->j,0); break;
    }
  }
}

static cost_t* c_cost=NULL;
static back_t* c_back=NULL;

void my_init(input_t* in1, input_t* in2) {
  int dev=-1; cuErr(cudaGetDevice(&dev));
  cuMalloc(g_in1,sizeof(input_t)*(M_H-1)); cuPut(in1,g_in1,sizeof(input_t)*(M_H-1),NULL);
  g_in2=NULL;
  size_t s_cost = sizeof(cost_t)*MEM_MATRIX;
  size_t s_back = sizeof(back_t)*MEM_MATRIX;
  cuAlloc2(costDev,c_cost,g_cost,s_cost); cuAlloc2(backDev,c_back,g_back,s_back);
  gpu_input<<<1,1>>>(g_in1,g_in2);
  cudaDeviceProp prop; cuErr(cudaGetDeviceProperties(&prop, dev));
}

void my_free() {
  cuFree(g_in1);
  cuFree2(c_cost,g_cost); cuFree2(c_back,g_back); cuReset;
}

void my_solve() {
  #define WARP_SIZE 32 // constant over CUDA devices
  unsigned blk_size = WARP_SIZE;
  unsigned blk_num = (M_H+blk_size-1)/blk_size;
  unsigned* lock; cuMalloc(lock,sizeof(unsigned)*blk_num);
  cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
  cuStream(stream);
  for (int i=0;i<1;++i) {
    unsigned s0=((M_W)*i)/1, s1=((M_W)*(i+1))/1;
    gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in1, g_in2, g_cost, g_back, lock, s0, s1);
  }
  cuSync(stream); cuStreamDestroy(stream); cuFree(lock);
}

int my_backtrack(trace_t** trace, unsigned* size) {
  int res; unsigned i0=0, j0=M_W-1;
  cuGet(&res,&g_cost[idx(i0,j0)].s,sizeof(int),NULL);
  if (trace && size) {
    unsigned mem=(M_W+M_H)*sizeof(trace_t);
    trace_t *g_trace=NULL,*c_trace=NULL; cuAlloc2(traceDev,c_trace,g_trace,mem);
    unsigned *g_size=NULL; cuMalloc(g_size,sizeof(unsigned));
    gpu_backtrack<<<1,1,0,NULL>>>(g_trace, g_size, g_back, i0, j0);
    cuGet(size,g_size,sizeof(unsigned),NULL); cuFree(g_size); mem=(*size)*sizeof(trace_t);
    *trace=(trace_t*)malloc(mem); cuGet(*trace,g_trace,mem,NULL); cuFree2(c_trace,g_trace);
  }
  return res;
}
