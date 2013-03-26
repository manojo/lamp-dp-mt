#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "nu.h"

#define _unroll _Pragma("unroll 5")
#define M_W (SIZE+1)
#define M_H (SIZE+1)
#define MEM_MATRIX (M_W*M_H)
#define idx(i,j) ((i)*M_W+j)
#include <strings.h>
static input_t *_in1=NULL, *_in2=NULL;
static cost_t* c_cost=NULL;
static back_t* c_back=NULL;

static inline int fun0() { return 0; }
static inline int fun1(char c, int a) { return a; }
static inline int fun2(int a, char c) { return a; }
static inline int fun3(char l, int a, char r) { return a+1; }
static inline bool fun4(int i, int j) { if (i+2>j) return false; char a=_in1[i],b=_in1[j-1]; return (a=='a'&&b=='u') || (a=='u'&&b=='a') || (a=='g'&&b=='u') || (a=='u'&&b=='g') || (a=='c'&&b=='g') || (a=='g'&&b=='c'); }
static inline int fun5(int l, int r) { return l+r; }

void cpu_solve(const input_t* _in1, const input_t* _in2, cost_t* cost, back_t* back) {
  for (int jj=0; jj<M_W; ++jj) {
    for (int ii=jj; ii<M_H; ++ii) {
      int i=M_H-1-ii, j=i+jj;
      #define VALID(I,J,RULE) (cost[idx(I,J)].RULE!=-1000)
      #include "nu_kern.h"
    }
  }
}

void cpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {
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

void my_init(input_t* in1, input_t* in2) {
  size_t sz1=(M_H-1)*sizeof(input_t); _in1=(input_t*)malloc(sz1); memcpy(_in1,in1,sz1);
  if (in2) { size_t sz2=(M_W-1)*sizeof(input_t); _in2=(input_t*)malloc(sz2); memcpy(_in2,in2,sz2); }
  c_cost=(cost_t*)malloc(sizeof(cost_t)*MEM_MATRIX);
  c_back=(back_t*)malloc(sizeof(back_t)*MEM_MATRIX);
}

void my_solve() { cpu_solve(_in1, _in2, c_cost, c_back); }
void my_free() { free(_in1); free(_in2); free(c_cost); free(c_back); }
int my_backtrack(trace_t** trace, unsigned* size) {
  int res; unsigned i0=0, j0=M_W-1;
  res = c_cost[idx(i0,j0)].s;
  if (trace && size) { *trace=(trace_t*)malloc((M_W+M_H)*sizeof(trace_t)); cpu_backtrack(*trace,size,c_back,i0,j0); }
  return res;
}

