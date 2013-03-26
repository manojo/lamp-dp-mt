#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "zu.h"

#define _unroll _Pragma("unroll 1")
#define M_W (SIZE+1)
#define M_H (SIZE+1)
#define MEM_MATRIX (M_W*M_H)
#define idx(i,j) ((i)*M_W+j)
#include <strings.h>
static input_t *_in1=NULL, *_in2=NULL;
static cost_t* c_cost=NULL;
static back_t* c_back=NULL;
#define my_len (M_H-1)
#define my_seq _in1
#define my_P c_P
#define my_dev
#include "../src/librna/vienna/vienna.h"
#include "../src/librna/librna_impl.h"

static inline int fun0(int lb, int e, int rb) { return e + sr_energy(lb,rb); }
static inline int fun1(int lb, int f1, T2ii x, int f2, int rb) { return hl_energy(f1,f2) + sr_energy(lb,rb); }
static inline int fun10(int c1, int c) { return c1+c; }
static inline int fun11(int c1, T2ii e) { return c1; }
static inline int fun12(int x, int e) { return x+e; }
static inline int fun13() { return 0; }
static inline bool fun14(int i, int j) { return j==M_W-1; }
static inline int fun2(int lb, int f1, T2ii b, int x, int f2, int rb) { return x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb,rb); }
static inline int fun3(int lb, int f1, int x, T2ii b, int f2, int rb) { return x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb,rb); }
static inline int fun4(int f1, int f2, T2ii r1, int x, T2ii r2, int f3, int f4) { return x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1,f4); }
static inline int fun5(int lb, int f1, int x, int f2, int rb) { return ml_energy() + ul_energy() + x + termau_energy(f1,f2) + sr_energy(lb,rb) + ml_mismatch_energy(f1,f2); }
static inline bool fun6(int i, int j) { return i+4<=j && bp_index(_in1[i],_in1[j-1])!=NO_BP && bp_index(_in1[i+1],_in1[j-2])!=NO_BP; }
static inline int fun7(int lb, int e) { return e; }
static inline int fun8(int lb, int e, int rb) { return e + ext_mismatch_energy(lb,rb-1) + termau_energy(lb,rb-1); }
static inline int fun9(int c1) { return ul_energy()+c1; }

void cpu_solve(const input_t* _in1, const input_t* _in2, cost_t* cost, back_t* back) {
  for (int jj=0; jj<M_W; ++jj) {
    for (int ii=jj; ii<M_H; ++ii) {
      int i=M_H-1-ii, j=i+jj;
      #define VALID(I,J,RULE) (cost[idx(I,J)].RULE!=999999)
      #include "zu_kern.h"
    }
  }
}

void cpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {
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

void my_init(input_t* in1, input_t* in2) {
  size_t sz1=(M_H-1)*sizeof(input_t); _in1=(input_t*)malloc(sz1); memcpy(_in1,in1,sz1);
  if (in2) { size_t sz2=(M_W-1)*sizeof(input_t); _in2=(input_t*)malloc(sz2); memcpy(_in2,in2,sz2); }
  c_cost=(cost_t*)malloc(sizeof(cost_t)*MEM_MATRIX);
  c_back=(back_t*)malloc(sizeof(back_t)*MEM_MATRIX);
  read_parameter_file(LIBRNA "vienna/rna_turner2004.par");
  c_P = get_scaled_parameters();
}

void my_solve() { cpu_solve(_in1, _in2, c_cost, c_back); }
void my_free() { free(_in1); free(_in2); free(c_cost); free(c_back); free(c_P); }
int my_backtrack(trace_t** trace, unsigned* size) {
  int res; unsigned i0=0, j0=M_W-1;
  res = c_cost[idx(i0,j0)].st;
  if (trace && size) { *trace=(trace_t*)malloc((M_W+M_H)*sizeof(trace_t)); cpu_backtrack(*trace,size,c_back,i0,j0); }
  return res;
}
