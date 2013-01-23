#include <stdio.h>
#include <stdlib.h>
#include "comp1.h"

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
#define M_W 1025
#define M_H 1025
#define B_H 32
#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)
#define idx(i,j) ({ unsigned _i=(i); (B_H*((j)+(_i%B_H)) + (_i%B_H) + (_i/B_H)*M_W*B_H); })
static input_t *g_in1 = NULL, *g_in2 = NULL;
static cost_t *g_cost = NULL;
static back_t *g_back = NULL;
__device__ static __attribute__((unused)) input_t *_in1=NULL, *_in2=NULL;
__global__ void gpu_input(input_t* in1, input_t* in2) { _in1=in1; _in2=in2; }


__device__ static inline int fun0(int p) { return 0; }
__device__ static inline int fun1(int a, char c2) { return a>3 ? a-3 : 0; }
__device__ static inline int fun2(int a, char c2) { return a>1 ? a-1 : 0; }
__device__ static inline int fun3(char c1, int a) { return a>3 ? a-3 : 0; }
__device__ static inline int fun4(char c1, int a) { return a>1 ? a-1 : 0; }
__device__ static inline int fun5() { return 0; }
__device__ static inline int fun6(char c1, int a, char c2) { return a + (c1==c2 ? 10 : -3); }

__global__ void gpu_solve(const input_t* in1, const input_t* in2, cost_t* cost, back_t* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
  const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;
  const unsigned tN = blockDim.x * gridDim.x;
  const unsigned tB = blockIdx.x;
  unsigned tP=s_start; // block progress
  for (unsigned jj=s_start; jj<s_stop; ++jj) {
    for (int i=tI; i<M_H; i+=tN) {
      int j = jj-i; if (j>=0)
      if (j<M_W) {
        back_t _back = {{-1},{-1},{-1}};
        cost_t _cost = {}; // init to 0
        #define VALID(I,J,RULE) (back[idx(I,J)].RULE.rule!=-1)
        /* --- g2[i,j] --- */
        if (0==j) {
          { int _c=fun0((i)); if (_c>_cost.g2 || _back.g2.rule==-1) { _cost.g2=_c; _back.g2=(bt0){7}; } }
        }
        if (1<=j) {
          { int _c=fun1(cost[idx(i,j-1)].M,_in2[j-1]); if (_c>_cost.g2 || _back.g2.rule==-1) { _cost.g2=_c; _back.g2=(bt0){8}; } }
        }
        if (1<=j) {
          { int _c=fun2(cost[idx(i,j-1)].g2,_in2[j-1]); if (_c>_cost.g2 || _back.g2.rule==-1) { _cost.g2=_c; _back.g2=(bt0){9}; } }
        }
        cost[idx(i,j)].g2 = _cost.g2;
        back[idx(i,j)].g2 = _back.g2;
        /* --- g1[i,j] --- */
        if (0==i) {
          { int _c=fun0((j)); if (_c>_cost.g1 || _back.g1.rule==-1) { _cost.g1=_c; _back.g1=(bt0){4}; } }
        }
        if (1<=i) {
          { int _c=fun3(_in1[i-1],cost[idx(i-1,j)].M); if (_c>_cost.g1 || _back.g1.rule==-1) { _cost.g1=_c; _back.g1=(bt0){5}; } }
        }
        if (1<=i) {
          { int _c=fun4(_in1[i-1],cost[idx(i-1,j)].g1); if (_c>_cost.g1 || _back.g1.rule==-1) { _cost.g1=_c; _back.g1=(bt0){6}; } }
        }
        cost[idx(i,j)].g1 = _cost.g1;
        back[idx(i,j)].g1 = _back.g1;
        /* --- M[i,j] --- */
        if (i==j && 0==i && 0==j) {
          { int _c=fun5(); if (_c>_cost.M || _back.M.rule==-1) { _cost.M=_c; _back.M=(bt0){0}; } }
        }
        if (1<=i && 1<=j) {
          { int _c=fun6(_in1[i-1],cost[idx(i-1,j-1)].M,_in2[j-1]); if (_c>_cost.M || _back.M.rule==-1) { _cost.M=_c; _back.M=(bt0){1}; } }
        }
        { typeof(cost[idx(0,0)].g1) _c=cost[idx(i,j)].g1; if (_c>_cost.M || _back.M.rule==-1) { _cost.M=_c; _back.M=(bt0){2}; } }
        { typeof(cost[idx(0,0)].g2) _c=cost[idx(i,j)].g2; if (_c>_cost.M || _back.M.rule==-1) { _cost.M=_c; _back.M=(bt0){3}; } }
        cost[idx(i,j)].M = _cost.M;
        back[idx(i,j)].M = _back.M;
      }
    }
    // Sync between blocks, removing __threadfence() here is incorrect but works
    // __threadfence();
    if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
    __syncthreads();
  }
}

__global__ void gpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {
  trace_t *rd=trace, *wr=trace; *size=0;
  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++(*size); }
  PUSH_BACK(i0,j0,0);
  for(;rd<wr;++rd) {
    bt0* bt;
    switch (rd->rule) {
      case 0: bt=(bt0*)&back[idx(rd->i,rd->j)].M; break;
      case 1: bt=(bt0*)&back[idx(rd->i,rd->j)].M; break;
      case 2: bt=(bt0*)&back[idx(rd->i,rd->j)].M; break;
      case 3: bt=(bt0*)&back[idx(rd->i,rd->j)].M; break;
      case 4: bt=(bt0*)&back[idx(rd->i,rd->j)].g1; break;
      case 5: bt=(bt0*)&back[idx(rd->i,rd->j)].g1; break;
      case 6: bt=(bt0*)&back[idx(rd->i,rd->j)].g1; break;
      case 7: bt=(bt0*)&back[idx(rd->i,rd->j)].g2; break;
      case 8: bt=(bt0*)&back[idx(rd->i,rd->j)].g2; break;
      case 9: bt=(bt0*)&back[idx(rd->i,rd->j)].g2; break;
    }
    rd->rule=bt->rule;
    switch (rd->rule) {
      case 0: break;
      case 1: PUSH_BACK(rd->i-1,rd->j-1,0); break;
      case 2: PUSH_BACK(rd->i,rd->j,4); break;
      case 3: PUSH_BACK(rd->i,rd->j,7); break;
      case 4: break;
      case 5: PUSH_BACK(rd->i-1,rd->j,0); break;
      case 6: PUSH_BACK(rd->i-1,rd->j,4); break;
      case 7: break;
      case 8: PUSH_BACK(rd->i,rd->j-1,0); break;
      case 9: PUSH_BACK(rd->i,rd->j-1,7); break;
    }
  }
}

static cost_t* c_cost=NULL;
static back_t* c_back=NULL;

void g_init(input_t* in1, input_t* in2) {
  int dev=-1; cuErr(cudaGetDevice(&dev));
  cuMalloc(g_in1,sizeof(input_t)*(M_H-1)); cuPut(in1,g_in1,sizeof(input_t)*(M_H-1),NULL);
  cuMalloc(g_in2,sizeof(input_t)*(M_W-1)); cuPut(in2,g_in2,sizeof(input_t)*(M_W-1),NULL);
  size_t s_cost = sizeof(cost_t)*MEM_MATRIX;
  size_t s_back = sizeof(back_t)*MEM_MATRIX;
  cuAlloc2(costDev,c_cost,g_cost,s_cost); cuAlloc2(backDev,c_back,g_back,s_back);
  gpu_input<<<1,1>>>(g_in1,g_in2);
  cudaDeviceProp prop; cuErr(cudaGetDeviceProperties(&prop, dev));
  size_t mem = (sizeof(input_t)+sizeof(trace_t))*(M_W+M_H) + s_cost + s_back;
  printf("%-20s : %.2fMb / %.2fMb [in=%ld,tr=%ld,cost=%ld,back=%ld] -> cost:%s, backtrack:%s\n","Memory selection",mem/1048576.0,prop.totalGlobalMem/1048576.0, sizeof(input_t),sizeof(trace_t),sizeof(cost_t),sizeof(back_t), costDev?"device":"host", backDev?"device":"host");
}

void g_free() {
  cuFree(g_in1); cuFree(g_in2);
  cuFree2(c_cost,g_cost); cuFree2(c_back,g_back); cuReset;
}

void g_solve() {
  #define WARP_SIZE 32 // constant over CUDA devices
  unsigned blk_size = WARP_SIZE;
  unsigned blk_num = (M_H+blk_size-1)/blk_size;
  unsigned* lock; cuMalloc(lock,sizeof(unsigned)*blk_num);
  cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
  cuStream(stream);
  for (int i=0;i<1;++i) {
    unsigned s0=((M_W+M_H)*i)/1, s1=((M_W+M_H)*(i+1))/1;
    gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in1, g_in2, g_cost, g_back, lock, s0, s1);
  }
  cuSync(stream); cuStreamDestroy(stream); cuFree(lock);
}

int g_backtrack(trace_t** trace, unsigned* size) {
  int res; unsigned i0=M_H-1, j0=M_W-1;
  cuGet(&res,&g_cost[idx(i0,j0)].M,sizeof(int),NULL);
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
