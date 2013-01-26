#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
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
#define _unroll _Pragma("unroll 1")
//#define M_W 1024
//#define M_H 1024
#define MEM_MATRIX ((M_H*(M_H+1))/2)
#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - ((_d*(_d-1))>>1) +_i; })
static input_t *g_in1 = NULL, *g_in2 = NULL;
static cost_t *g_cost = NULL;
static back_t *g_back = NULL;
__device__ static __attribute__((unused)) input_t *_in1=NULL, *_in2=NULL;
__global__ void gpu_input(input_t* in1, input_t* in2) { _in1=in1; _in2=in2; }

// --------------------------------
#include "../../src/librna/vienna/vienna.h"

__constant__ paramT0 param0;

#define my_len (M_H-1)
#define my_seq _in1
#define my_P g_P
#define my_P0 param0

#define my_dev __device__
#include "../../src/librna/librna_impl.h"
#include "../../src/librna/vienna/vienna.c"
#include "../../src/librna/vienna/energy_par.c"

static paramT *cg_P=NULL;
__global__ static void _initP(paramT* params) { g_P=params; }
static inline void rna_init() {
  read_parameter_file("../../src/librna/vienna/rna_turner2004.par");
  paramT* P = get_scaled_parameters();
  cudaMemcpyToSymbol(param0,&(P->p0),sizeof(paramT0));

  cuMalloc(cg_P,sizeof(paramT));
  cuPut(P,cg_P,sizeof(paramT),NULL);
  _initP<<<1,1>>>(cg_P); free(P);
}
static inline void rna_free() { cuFree(cg_P); }
// --------------------------------

__device__ static inline int fun0(int lb, int e, int rb) { return e + sr_energy(lb,rb); }
__device__ static inline int fun1(int lb, int f1, T2ii x, int f2, int rb) { return hl_energy(f1,f2) + sr_energy(lb,rb); }
__device__ static inline int fun10(int c1, int c) { return c1+c; }
__device__ static inline int fun11(int c1, T2ii e) { return c1; }
__device__ static inline int fun12(int x, int e) { return x+e; }
__device__ static inline int fun13() { return 0; }
__device__ static inline int fun2(int lb, int f1, T2ii b, int x, int f2, int rb) { return x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb,rb); }
__device__ static inline int fun3(int lb, int f1, int x, T2ii b, int f2, int rb) { return x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb,rb); }
__device__ static inline int fun4(int f1, int f2, T2ii r1, int x, T2ii r2, int f3, int f4) { return x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1,f4); }
__device__ static inline int fun5(int lb, int f1, int x, int f2, int rb) { return ml_energy() + ul_energy() + x + termau_energy(f1,f2) + sr_energy(lb,rb) + ml_mismatch_energy(f1,f2); }
__device__ static inline bool fun6(int i, int j) { return i+4<=j && bp_index(_in1[i],_in1[j-1])!=NO_BP && bp_index(_in1[i+1],_in1[j-2])!=NO_BP; }
__device__ static inline int fun7(int lb, int e) { return e; }
__device__ static inline int fun8(int lb, int e, int rb) { return e + ext_mismatch_energy(lb,rb-1) + termau_energy(lb,rb-1); }
__device__ static inline int fun9(int c1) { return ul_energy()+c1; }

__global__ void gpu_solve(const input_t* in1, const input_t* in2, cost_t* cost, back_t* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {
  const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;
  const unsigned tN = blockDim.x * gridDim.x;
  const unsigned tB = blockIdx.x;
  unsigned tP=s_start; // block progress
  for (unsigned jj=s_start; jj<s_stop; ++jj) {
    for (int ii=tI; ii<M_H; ii+=tN) {
      int i = M_H-1-ii, j = i+jj;
      if (j<M_W) {
        back_t _back = {{-1,{0,0}},{-1,{0}},{-1,{0}},{-1,{0}}};
        cost_t _cost = {}; // init to 0
        #define VALID(I,J,RULE) (back[idx(I,J)].RULE.rule!=-1)
        /* --- cl[i,j] --- */
        if (fun6(i,j)) {
          if (i+9<=j && VALID(i+1,j-1,cl)) {
            { int _c=fun0((i),cost[idx(i+1,j-1)].cl,(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){0}; } }
          }
          if (i+7<=j) {
            { int _c=fun1((i),(i+1),(T2ii){i+2,j-2},(j-2),(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){1}; } }
          }
          if (i+12<=j) _unroll for(int k=i+3,ku=j-9; k<=ku; ++k) {
            if (k-32<=i && VALID(k,j-2,cl)) {
              { int _c=fun2((i),(i+1),(T2ii){i+2,k},cost[idx(k,j-2)].cl,(j-2),(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){2,{k}}; } }
            }
          }
          if (i+12<=j) _unroll for(int k=i+9,ku=j-3; k<=ku; ++k) {
            if (j-32<=k && VALID(i+2,k,cl)) {
              { int _c=fun3((i),(i+1),cost[idx(i+2,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){3,{k}}; } }
            }
          }
          if (i+13<=j) for(int k=MAX(i+10,j-32),ku=j-3; k<=ku; ++k) {
            _unroll for(int l=i+3,lu=MIN(k-7,i+32); l<=lu; ++l) {
              if (VALID(l,k,cl)) {
                { int _c=fun4((i),(i+1),(T2ii){i+2,l},cost[idx(l,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){4,{l,k}}; } }
              }
            }
          }
          if (i+18<=j && VALID(i+2,j-2,ml)) {
            { int _c=fun5((i),(i+1),cost[idx(i+2,j-2)].ml,(j-2),(j-1)); if (_c<_cost.cl || _back.cl.rule==-1) { _cost.cl=_c; _back.cl=(bt2){5}; } }
          }
        }
        cost[idx(i,j)].cl = _cost.cl;
        back[idx(i,j)].cl = _back.cl;
        /* --- ml[i,j] --- */
        if (i+15<=j && VALID(i+1,j,ml)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml); if (_c<_cost.ml || _back.ml.rule==-1) { _cost.ml=_c; _back.ml=(bt1){6}; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_cost.ml || _back.ml.rule==-1) { _cost.ml=_c; _back.ml=(bt1){7,{k}}; } }
          }
        }
        cost[idx(i,j)].ml = _cost.ml;
        back[idx(i,j)].ml = _back.ml;
        /* --- ml1[i,j] --- */
        if (i+8<=j && VALID(i+1,j,ml1)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml1); if (_c<_cost.ml1 || _back.ml1.rule==-1) { _cost.ml1=_c; _back.ml1=(bt1){8}; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_cost.ml1 || _back.ml1.rule==-1) { _cost.ml1=_c; _back.ml1=(bt1){9,{k}}; } }
          }
        }
        if (i+7<=j && VALID(i,j,cl)) {
          { int _c=fun9(fun8((i),cost[idx(i,j)].cl,(j))); if (_c<_cost.ml1 || _back.ml1.rule==-1) { _cost.ml1=_c; _back.ml1=(bt1){10}; } }
        }
        _unroll for(int k=i+7; k<j; ++k) {
          if (VALID(i,k,cl)) {
            { int _c=fun11(fun9(fun8((i),cost[idx(i,k)].cl,(k))),(T2ii){k,j}); if (_c<_cost.ml1 || _back.ml1.rule==-1) { _cost.ml1=_c; _back.ml1=(bt1){11,{k}}; } }
          }
        }
        cost[idx(i,j)].ml1 = _cost.ml1;
        back[idx(i,j)].ml1 = _back.ml1;
        /* --- st[i,j] --- */
        if (i+1<=j) {
          { int _c=fun7((i),cost[idx(i+1,j)].st); if (_c<_cost.st || _back.st.rule==-1) { _cost.st=_c; _back.st=(bt1){12}; } }
        }
        _unroll for(int k=i+7; k<=j; ++k) {
          if (VALID(i,k,cl)) {
            { int _c=fun12(fun8((i),cost[idx(i,k)].cl,(k)),cost[idx(k,j)].st); if (_c<_cost.st || _back.st.rule==-1) { _cost.st=_c; _back.st=(bt1){13,{k}}; } }
          }
        }
        if (i==j) {
          { int _c=fun13(); if (_c<_cost.st || _back.st.rule==-1) { _cost.st=_c; _back.st=(bt1){14}; } }
        }
        cost[idx(i,j)].st = _cost.st;
        back[idx(i,j)].st = _back.st;
      }
    }
    // Sync between blocks, removing __threadfence() here is incorrect but works
    // __threadfence();
    if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }
    __syncthreads();
  }
}

__global__ void gpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {
  const unsigned trace_len[15] = {2,2,2,2,2,2,1,1,1,1,1,1,1,1,1};
  trace_t *rd=trace, *wr=trace; *size=0;
  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++(*size); }
  PUSH_BACK(i0,j0,12);
  for(;rd<wr;++rd) {
    bt2* bt;
    switch (rd->rule) {
      case 0: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 1: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 2: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 3: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 4: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 5: bt=(bt2*)&back[idx(rd->i,rd->j)].cl; break;
      case 6: bt=(bt2*)&back[idx(rd->i,rd->j)].ml; break;
      case 7: bt=(bt2*)&back[idx(rd->i,rd->j)].ml; break;
      case 8: bt=(bt2*)&back[idx(rd->i,rd->j)].ml1; break;
      case 9: bt=(bt2*)&back[idx(rd->i,rd->j)].ml1; break;
      case 10: bt=(bt2*)&back[idx(rd->i,rd->j)].ml1; break;
      case 11: bt=(bt2*)&back[idx(rd->i,rd->j)].ml1; break;
      case 12: bt=(bt2*)&back[idx(rd->i,rd->j)].st; break;
      case 13: bt=(bt2*)&back[idx(rd->i,rd->j)].st; break;
      case 14: bt=(bt2*)&back[idx(rd->i,rd->j)].st; break;
    }
    rd->rule=bt->rule;
    for (int i=0,l=trace_len[rd->rule]; i<l; ++i) rd->pos[i]=bt->pos[i];
    switch (rd->rule) {
      case 0: PUSH_BACK(rd->i+1,MAX(rd->i+8,rd->j-1),0); break;
      case 1: break;
      case 2: PUSH_BACK(rd->pos[0],MAX(rd->i+10,MAX(rd->i+11,rd->j-1)-1),0); break;
      case 3: PUSH_BACK(rd->i+2,rd->pos[0],0); break;
      case 4: PUSH_BACK(rd->pos[0],rd->pos[1],0); break;
      case 5: PUSH_BACK(rd->i+2,MAX(rd->i+16,MAX(rd->i+17,rd->j-1)-1),6); break;
      case 6: PUSH_BACK(rd->i+1,rd->j,6); break;
      case 7: PUSH_BACK(rd->i+0,MAX(rd->i+7,rd->pos[0]-0),0); PUSH_BACK(rd->pos[0],rd->j,8); break;
      case 8: PUSH_BACK(rd->i+1,rd->j,8); break;
      case 9: PUSH_BACK(rd->i+0,MAX(rd->i+7,rd->pos[0]-0),0); PUSH_BACK(rd->pos[0],rd->j,8); break;
      case 10: PUSH_BACK(rd->i+0,MAX(rd->i+7,rd->j-0),0); break;
      case 11: PUSH_BACK(rd->i+0,MAX(rd->i+7,rd->pos[0]-0),0); break;
      case 12: PUSH_BACK(rd->i+1,rd->j,12); break;
      case 13: PUSH_BACK(rd->i+0,MAX(rd->i+7,rd->pos[0]-0),0); PUSH_BACK(rd->pos[0],rd->j,12); break;
      case 14: break;
    }
  }
}

static cost_t* c_cost=NULL;
static back_t* c_back=NULL;

void g_init(input_t* in1, input_t* in2) {
  int dev=-1; cuErr(cudaGetDevice(&dev));
  cuMalloc(g_in1,sizeof(input_t)*(M_H-1)); cuPut(in1,g_in1,sizeof(input_t)*(M_H-1),NULL);
  g_in2=NULL;
  rna_init();
  size_t s_cost = sizeof(cost_t)*MEM_MATRIX;
  size_t s_back = sizeof(back_t)*MEM_MATRIX;
  cuAlloc2(costDev,c_cost,g_cost,s_cost); cuAlloc2(backDev,c_back,g_back,s_back);
  gpu_input<<<1,1>>>(g_in1,g_in2);
  cudaDeviceProp prop; cuErr(cudaGetDeviceProperties(&prop, dev));
  size_t mem = (sizeof(input_t)+sizeof(trace_t))*(M_W+M_H) + s_cost + s_back;
  printf("%-20s : %.2fMb / %.2fMb [in=%ld,tr=%ld,cost=%ld,back=%ld] -> cost:%s, backtrack:%s\n","Memory selection",mem/1048576.0,prop.totalGlobalMem/1048576.0, sizeof(input_t),sizeof(trace_t),sizeof(cost_t),sizeof(back_t), costDev?"device":"host", backDev?"device":"host");
}

void g_free() {
  cuFree(g_in1); rna_free();
  cuFree2(c_cost,g_cost); cuFree2(c_back,g_back); cuReset;
}

void g_solve() {
  #define WARP_SIZE 32 // constant over CUDA devices
  unsigned blk_size = WARP_SIZE;
  unsigned blk_num = (M_H+blk_size-1)/blk_size;
  unsigned* lock; cuMalloc(lock,sizeof(unsigned)*blk_num);
  cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));
  cuStream(stream);

  int steps = (M_W+M_H)/1536;
  steps = steps*steps*steps;
  if (steps<1) steps=1;

  for (int i=0;i<steps;++i) {
    unsigned s0=((M_W)*i)/steps, s1=((M_W)*(i+1))/steps;
    gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in1, g_in2, g_cost, g_back, lock, s0, s1);
  }
  cuSync(stream); cuStreamDestroy(stream); cuFree(lock);
}

int g_backtrack(trace_t** trace, unsigned* size) {
  int res; unsigned i0=0, j0=M_W-1;
  cuGet(&res,&g_cost[idx(i0,j0)].st,sizeof(int),NULL);
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

// FLAGS := -arch=sm_30

int main() {
  struct timeval ts,te; double delta;
  gettimeofday(&ts,NULL);
  char in1[8193]="aauaaaccacucuuuaucaccucauuucagugauaagugagaaugauacgacgaguucaucgguaauuaagguucugucaccacgaacuuaagcuaugugacaugggacaaagcggucacgucuauauucgauuaauguuaugcggacgccaacauccauggcccccuguccgaugguuuggcucucuguaaagggucuaaagacaaacuuccugacgaaggaccucuaaggauacaucgaaaggguguggcccaguuuggguggcucaugacacggagcaguuaaaagcacgugaugacugguggcgcgugacuugccgaaaauuacgugacgugacugggccaugacggaugagcgcuuccuucuggugcggagcauacccccggacacuuuccaucgcuucccaucaugccaugaacgcucaagcuacccucagugcuugugcccgacuagcgcacaccgaccuggugacgagcuuuggucaccucacgaggggcggcccugucacgaacguaacguaagggacagugguguucaaaagguuaccuuccuaacaaagcccuuaaaguucacaccaucguucuacgcaccggcagucaagauacgugugcucgaaaagcguagauuuuacauauuacuaugacagugauaucaauauauugugagacaaggcgaaucucaacaagaaccggcucguaucgggagaacguagaaagcaugccgaacaugauaauccagucguauaggauggagcgauuugacuacugguugucuugcacugauggagcauagucaaaaguacaucccuuagugccaucucgugaggccuuacaggcauucgcacccaugcccaagaagcuaccuucuaaguggcaauacguacacauggaggacuuagcucgagugcgacggggggaugcuuucauggccccuuaucgcccgguaauccaugccuugaugaucgugugaacagggcuaugcucuuacucaaaugguuggguucaacgguagcgcauagguuuacacauguaaggaaacugguuagagcggcaggauuggauucauaagauuuucauugacauuuacacaccagccgaggagugcguguugcagugguaguuucguuuuucugagcgcucgaaguaauguucgcgccuuugggggagaaucauacgagaucauccaucgcugauaagcuugggaucucguucacuccgggucgucaccgcaguaaccgauucagggugaucagacucguaaccgauuguuucacacugugauugcagugccggugcucgcuaacaauccaaccggcaucgaacgugaagcgcuucgugcucggcuaaacugccguuaaccggaaugacaccgcgcggagaagagauagaaccggguuuacucuacgacuggccgagguuguaccuaauaagcuguacauacgggacgagcgagcaauaaccagucuauauggcaucaaguaaguucgcagaaccagacaaccgcuauggcaacgacacuuggcugacgaggaaaucaguauuugcauuuuucuaccccuauuaguguugguacccgcgcauagucaggauaacaaugucggacagcaaaacuaccaacgcaaucauuuccgguaaacuuuggucgcucguguauaagguuuggcccguugaugacuacacucacgauugugguacacucgcuacagaauuacaggguauucacuauaccgauuacuucgccaaaaauccucggaaccaccggauugcuauuccaacacacuggccuccguguuuucuuucucgaacagaucagccgggugcauaaucguuuguaucguugaagugaugggauaucugaguuggacggcuggcccacaucaauuuaagcacgacagcuuguaggcgacucgaucuggauacgagucuuagucaacccaguacacauuucuagccccucggcuggaaucguuccuaauaaucuacacacggcuugccgucgaugucaaucaaaugccgcuauuugcuuggccacgcuuauaacauguggcgauccugccgauggcgacgaucgucagccccggcacgcaguuuucucccagaaggaaacuuuaagaugaucagacuuagucugaagagaacauuccgucuaucacuugguaggaaugcagcaguucccuuguucggggauccgggaggacgacaacuagcaggaagacucccccccgcuaaccuaaaccaguggguucugccugauacuuuggcuugauauugaccucaaaacauucguuaggucaguguguuagccucuugcaucgccaggugucucccucucuuuuaaaaccauguuuacgugugugaugugguuaucgaacccuauguguugaauuuacguaguagcaauguuggucggaccacagcccaaaugcgacauuaggcuaguucauggcauucaguacgccgcaggaaaagggcuucuggguuuucacggaagugucgaacacgaaauaggggggcugaggcacugagugaguaauucgcaauuccguucugagugaagucccguucauucauaagaccuccaacgagcauuaauaugucacgaucccaauuugagaauugccgcggauauguacagagggugccucauucacucacaagggcuaucacaccuggguacaaaucucgacugugcuacaucagggugcguuccuguccauaggauuuugaagucucgggaucuaucgcaccgcccggauggagauugauaggugugggaguuuccauuaggagguuccacagcaacugcgccgguucuuacuccuggugcuguucgagucgaauaaacuggcuuuauauggcaccucacugucagucccguguuagcgaaugguggaguuacaugcguucuauguuuagcacgcccgugcagggggcauuacgguguuaggccaucauuugauguacauggagaugagcuucgugugaacccguuuggaaccgcaacccgaauugccaauuuuuuguucgauucaauucgaguguguucuacgucgggagggcuaaaacuguacuuacuccccucugccgcgucggaaugccuccaccuguauaauaggaugguuuucucagcuuaccacaugcugcuuuagcgauaauccuaucugcggcuuuggcguggauuggggccaugagguccugacacgggcaguuuaacccacuuggacuccuaaccuaagggcagacgaguagaauaggguuguugucuuguaucggugucaaaucgauauugguguccgguuccaacaggggucaaucuacgcuauugguugccuuauuaaaaauuaccaggguccggucugucgggucaaucgauaacggcauuggacauugauuaacauauaugccggcgagugaauucagguccaaucagcacauaccaagaagaguuagaaagggcggggucacguaacgcugggugcugcgagucauugcagucuuugcgaucgggcgugguuccgcgcuuucauccccuucgaaagucuccagcaagaauuccguucauuugacagaaauuagucgaauaucgaucggagcgcgaaauggguagaaacgcuagagcuuuuacugggguacgacuauaucucuaagcaucuaucccuccaguaaaagugucggccaagcaaugccaccguuaccguaagcuacuacacagucgggggcucgccucaucgaagcauaugaccccccauguucuugggauauacugagguuuauguucaggcucacuugcauagugagagugucccuuagaagguacaauguaaaggacagcggaccaaccugaucuuagaguguaaucuacguucaguucagucuguuuaagucacaagagugagcuccagcuaagaggccgcucuugaccggguuccaauauuggcguuaacguucguuuguuguaucgacgcccgaaggggggcagggaagaaucugaaauauguucgauagguuguaguccaucgaccugccgcaccauuucccgccuaaaggguacgggagccucgagcaaagccacgauaggaagcuagcaagcggugauaaagccuggcccaaguaaacauucggcuccucauaggcccagguagaccgaugacauggcgcgaaacucuugcuguaggucuuucacguggacggcacuaccugcaaaagacgggaaucgaccucaugcaggguucuugguacagcaucgguuuuuaccgggguagggaggcuugugccuucggcucccuacaugaaggcgcuaggacugccauuuuucauuaccccacaucgcgcgcauaaaacugcuucuacccuggauggcaauuguuucauauccacaguuccggaauucuuuagcgagggcaaaggggauuacguaaagauggauaaaaguacuacuuaucaagcgcuguaggggucuugcgcgucgcuucucuaguuggugggcaaaguccaguucauaccuugggguaggcauugaaggauauggcucgcuugucuccagggcuccggcgguaucgcguucuauucucgaguggccuaggauuugucuugccaaaagaauacuucgcagcauagucgucaccccaguagucuagccauacucucgccgucgccucucguccagcuugcgaauuugaggccgaugagccgcgaucugccacagggaagucguugacucgaaugguauagcguggaggggaagaccaacuucacgucagacuaauacgccgugggucgccuucagucgcagaugugaccacagguuauggauauagcaauugucagcccgacaccauuuaguucgcuauuauccuaugccgccgagauucaaggcacugggaagcacacaaggcuccggaucgcccgacuaacccauaccaaucaagcagagaggucgaagguuucuccguguauacaacuauucaaaaaagauggaauacccacggugagccgcgaucaacuuuacgcgaucgcucuuguaccgcuagacucacgucacaccgacgagucguacgucucuugagcuuaccucauuggacagccacccggaaaagacaucugcgaaaugcucgagaugcuuagucgcgcaaggggguuccguuuaaugaguucgacugggauaucgauauggucucgacaguucacuuuugacagcaguuggaauuagaggacuucucuuaaacgcuccgaguccucuuugccaggggagcgugaacaccccgagugauuugagcacaacaaugggucugaucaggggggaggcgcuguggacgaaacacguucccuucaccggauuggaaauauggccgaucuauaguaccagacaccgcgcgaaggauccguuugcacguaguaagggcuuggaaagucuugcggugguaugauucaguuaucguuauaagagcguuuucugaggagagcgggaguagcgaugacucgcggugaggggugauauucaauaguugcgcguauaggggauaccccuaucuaguacuugacgacaaaaacauuuacgaugugguuucuccuguaagggacggcgacugacccuugacugaucuaugcugagcucccgggaccccgauauggguuagggucugccagaucaagcggauugggagggucggggugauauuugcacacgccgggcccgucacgcauugggcuggcaggcacgugcgugugucaagggggaauuucgaggucccuuaacuuaugcgguggugagcccgugcuaucagaacagaucccuccugccgauaaauaacgagcagcgaucgaaccaugcaacgacagucaauugaccauguggcgggcuguaggacgcgugaaucagcgcucccagacagcaagauucagccuaucgcauuaaugggacacaagagcucuuccguaagcuaauacgucgcggagcguauuaaugagccgauuaaugccccgcgaaggucugcgaucaugguucagugggaguauggcguggaaaucacgaaugcgaacccgucgccgaacuggcgaucacaccucacuuggggucagcuuuuacuagaguggccccgcuauaggggucuacgaacgauaucagacagguucuacuuugggucggcaugcuauaguucgcagggguugcuacgagugaauuggcucccguaaucggugacgcuucacugauauuguaguugcgagcugcugcguuaacagguuccaacgccguacagaauggcucuacgccgcagcguauuauaacccgugacaucgcguagcgagggugcacuuugagggccgcccggggcaccgucgcagcccggguauacauaccagaggaaauuccacuugccgauauagaggcuucaagauugcauggcauccuuacaucuuuauuuaaguucggugcacguagacacuugccgcgucuucuuucagaagaauaaaugagggggcacuucuuagacacaccuuuuuuuaauccucgcguccucgaaacagcggaugugcugcugucuguaagggagguccguguuauagcgugucccuagacgcucuagucauccacacugugccugggcauugggacgcuggggucguauugugcgaguaagcggaccgguuccgacaugauaugaggcggagaaacuucuuccuagagacuuucaaguaagauaauucugaacgcuuacgccugaugugucugaacaggcuucgauggguugccuaggcagcacgaaggacguggaagugcuuugaguggagagccgggccuuuguuacaguaaacgucauccggcuagcuaaccaauacguuuuccuacagcacguccggcgcccuguguuuucauguggaauacaacuaccgcauugauaccucgcaccgcaaaaguaguuccccugcagaguacuccuuagguuucguaacaaaaacgagaguaguccgcucuucguagcguuaaacgucgaccgggcgccauuuggaggaagcgugucgaccugggauaggugcgacgguugagagaccgcgaagcuauuuucguuccggacguaaguuggcucacgugugcggcuuuucauuacuauaguuuauagugcugggaucguucuuugcgguaaguuucuaagcggguacucgccgacagucaugucaaaugaagaguuacugaacacgauguggguguccuaguaguugcuaaacauccugguuauaucuauggacgguacaaggauuccgaucauccacacgacgugaucguuggcgcacgcaucuaagagauucacucacaaaaugccaccgcuggccaaacgauaucgucacgaccagccacacgaaggugcaaguauauggccuuggaugaauugaagcgcgcacuggaagcugcaccccguagggucaaagggcaugagccagucucguauggguaacgguagguagaucuuaaaguaggugggucgggcgauacaaauggagaauaagggagugagguucguaaaauucucacugcaauacguaaaggagagauauccugaguaccucacagggucaacaaagaacgguucgcuggaccggguuaccgaacauacuuguccucuugcgauuuuacccaucugcgagauacucccucccgaauccuuggugcauuuuccgaacgagucacggccagaccuaccugugacugccgguauacuugguccaagcauccguuaagucaguagaucuucaaaaugcuaucacaagucuaucucgucucaacgguccaaugcgggacguugucguuuauugggaguaacgccacccuugguucucgcguggggucgagagucagcucuauauauccauuucucaccaaccugguguuauaaccaagcuaauuggagagcguuucccgacaccagugguagaugcacuauaggaacggaggacccacuccguaccgggugcgcaccacgggaugcgcauuaugccugccguagcuggcugaaacuagucuacaugugcgcuucucuagcaugaauuuaguagugagcgguccgguuuacgaggcuggaguuaccauuggcugugucggggaaggggacaggauguccggacguccaccgacucuuaguaccgacacucacacccuuauuuggaaaaagaggaggacucucccgcggcaacguacg";
  for (char* p=in1;*p;++p) switch(*p) {
    case 'a': *p=1; break;
    case 'c': *p=2; break;
    case 'g': *p=3; break;
    case 'u': *p=4; break;
  }
  g_init(in1,NULL);
  // free(in1);

  gettimeofday(&ts,NULL); g_solve(); gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- CUDA compute",delta/1000.0);

  trace_t *trace=NULL; unsigned size=0;

  gettimeofday(&ts,NULL); g_backtrack(&trace,&size); gettimeofday(&te,NULL);
  delta=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("%-20s : %.3f sec\n","- CUDA backtrack",delta/1000.0);

  free(trace);
  g_free();
  return 0;
}
