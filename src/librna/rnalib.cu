/* RNA energy library, CUDA wrapper for Vienna-Tables */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "vienna/vienna.h" // paramT

enum base_t { N_BASE, A_BASE, C_BASE, G_BASE, U_BASE, GAP_BASE };
enum iupac_t { N_IUPAC = 0, B_IUPAC = 6, D_IUPAC = 7, H_IUPAC = 8, R_IUPAC = 9, V_IUPAC = 10, Y_IUPAC = 11 };
enum bp_t { N_BP, CG_BP, GC_BP, GU_BP, UG_BP, AU_BP, UA_BP, NO_BP };
typedef unsigned int rsize;

// -----------------------------------------------------------------------------
// Header

__device__ int termau_energy(rsize i, rsize j);
__device__ int hl_energy(rsize i, rsize j);
__device__ int hl_energy_stem(rsize i, rsize j);
__device__ int il_energy(rsize i, rsize j, rsize k, rsize l);
__device__ int bl_energy(rsize bl, rsize i, rsize j, rsize br, rsize Xright);
__device__ int br_energy(rsize bl, rsize i, rsize j, rsize br, rsize Xleft);
__device__ int sr_energy(rsize i, rsize j);
__device__ int sr_pk_energy(char a, char b, char c, char d);
__device__ int dl_energy(rsize i, rsize j);
__device__ int dr_energy(rsize i, rsize j);
__device__ int dli_energy(rsize i, rsize j);
__device__ int dri_energy(rsize i, rsize j);
__device__ int ext_mismatch_energy(rsize i, rsize j);
__device__ int ml_mismatch_energy(rsize i, rsize j);
__device__ int ml_energy();
__device__ int ul_energy();
__device__ int sbase_energy();
__device__ int ss_energy(rsize i, rsize j);

__device__ int dl_dangle_dg(enum base_t dangle, enum base_t i, enum base_t j);
__device__ int dr_dangle_dg(enum base_t i, enum base_t j, enum base_t dangle);

__device__ double mk_pf(double x);
__device__ double scale(int x);

__device__ bool iupac_match(enum base_t base, unsigned char iupac_base);

// -----------------------------------------------------------------------------
// Implementation

__device__ static paramT *g_P = NULL;
__device__ static const char* g_seq = NULL;
__device__ static int g_len = 0;

#define my_len g_len
#define my_seq g_seq
#define my_P g_p

// -----------------------------------------------------------------------------

__device__ static int bp_index(char x, char y) {
  switch (x) {
    case A_BASE: if (y==U_BASE) return AU_BP; break;
    case C_BASE: if (y==G_BASE) return CG_BP; break;
    case G_BASE : switch (y) { case C_BASE: return GC_BP; case U_BASE: return GU_BP; } break;
    case U_BASE : switch (y) { case G_BASE: return UG_BP; case A_BASE: return UA_BP; } break;
  }
  return NO_BP;
}

__device__ static rsize noGaps(rsize i, rsize j) {
  rsize noGaps=0; for (rsize k=i; k<=j; ++k) if (g_seq[k] == GAP_BASE) ++noGaps;
  return noGaps;
}

__device__ static rsize getNext(rsize pos, rsize steps, rsize rightBorder) {
  //assert(steps>0);
  rsize nongaps=0, x=pos+1; if (x>rightBorder) return rightBorder;
  do { if (g_seq[x] != GAP_BASE) ++nongaps; } while (nongaps < steps && ++x < rightBorder);
  return x;
}

__device__ static rsize getPrev(rsize pos, rsize steps, rsize leftBorder) {
  // assert(pos>0); assert(steps>0);
  rsize nongaps=0, x=pos-1; if (x<=leftBorder) return leftBorder;
  do { if (g_seq[x] != GAP_BASE) ++nongaps; } while (nongaps < steps && --x > leftBorder);
  return x;
}

#define _next(pos,steps,left) g_seq[getNext(pos,steps,left)]
#define _prev(pos,steps,right) g_seq[getPrev(pos,steps,right)]
#define _bp(i,j) bp_index(g_seq[i],g_seq[j])
#define _bp2(a,b,c, d,e,f) bp_index(g_seq[getPrev(a,b,c)], g_seq[getNext(d,e,f)])

__device__ static int jacobson_stockmayer(rsize l) { return (int)(g_P->lxc*log((l)/(1.0 * MAXLOOP))); }
__device__ static int hl_ent(rsize l) { return (l>MAXLOOP) ? g_P->hairpin[MAXLOOP]+jacobson_stockmayer(l) : g_P->hairpin[l]; }
__device__ static int hl_stack(rsize i, rsize j) { return g_P->mismatchH[_bp(i,j)][_next(i,1,j-1)][_prev(j,1,i+1)]; }

__device__ int termau_energy(rsize i, rsize j) {
  return ((g_seq[i]==G_BASE && g_seq[j]==C_BASE) || (g_seq[i]==C_BASE && g_seq[j]==G_BASE)) ? 0 : g_P->TerminalAU;
}

__device__ static int ungappedLength(rsize i, rsize j) { int pos=0; for (rsize y=i;y<=j;++y) if (g_seq[y] != GAP_BASE) ++pos; return pos; }
__device__ static int strMatch(rsize i, rsize j, const char *str, int strlen, int step) {
  int len = j-i+1; // length of the sequence to match
  for (const char* p=str; p<p+strlen; p+=step) { // p is str candidate
    int n,k;
    for (n=0,k=0;n<len;++n) { // for all items in [i,j]
      char c=g_seq[i+n]; if (c==GAP_BASE) continue;
      else if (c==N_BASE) { if (p[k]!='N') break; ++k; }
      else if (c==A_BASE) { if (p[k]!='A') break; ++k; }
      else if (c==C_BASE) { if (p[k]!='C') break; ++k; }
      else if (c==G_BASE) { if (p[k]!='G') break; ++k; }
      else if (c==U_BASE) { if (p[k]!='U') break; ++k; }
      else break;
    }
    if (n==len) return ((int)(p-str))/step;
  }
  return -1; // not found
}

__device__ int hl_energy(rsize i, rsize j) {
  // assert(j-i>1);
  rsize size = j-i-1 - noGaps(i+1,j-1);
  int entropy = hl_ent(size);
  int stack_mismatch = hl_stack(i,j);

  if (size < 3) return 600;
  if (size == 3 || size == 4 || size == 6) {
    int pos;
    switch (ungappedLength(i,j)) {
      case 3+2: if ((pos=strMatch(i,j,g_P->Triloops  ,g_P->TriloopsLen  ,6))!=-1) return g_P->Triloop_E[pos/6]; break; // special triloop cases
      case 4+2: if ((pos=strMatch(i,j,g_P->Tetraloops,g_P->TetraloopsLen,7))!=-1) return g_P->Tetraloop_E[pos/7]; break; // special tetraloop cases
      case 6+2: if ((pos=strMatch(i,j,g_P->Hexaloops ,g_P->HexaloopsLen ,9))!=-1) return g_P->Hexaloop_E[pos/9]; break; //special hexaloop cases
    }
  }
  if (size == 3) return entropy + termau_energy(i, j); //normal hairpins of loop size 3
  else return entropy + stack_mismatch; //normal hairpins of loop sizes larger than three
}

__device__ int hl_energy_stem(rsize i, rsize j) { int r=hl_energy(i,j); rsize size = j-i-1 - noGaps(i+1,j-1); return r - (size >= 4 ? hl_stack(i,j) : 0); }

// Note, basepair and stacking bases are reversed to preserver 5'-3' order
__device__ static int il11_energy(rsize i, rsize k, rsize l, rsize j) { return g_P->int11[_bp(i,j)][_bp2(j,2,l, i,2,k)][_next(i,1,k)][_prev(j,1,l)]; }
__device__ static int il12_energy(rsize i, rsize k, rsize l, rsize j) { return g_P->int21[_bp(i,j)][_bp2(j,3,l, i,2,k)][_next(i,1,k)][_prev(j,2,l)][_prev(j,1,l)]; }
__device__ static int il21_energy(rsize i, rsize k, rsize l, rsize j) { return g_P->int21[_bp2(j,2,l, i,3,k)][_bp(i,j)][_prev(j,1,l)][_next(i,1,k)][_next(i,2,k)]; }
__device__ static int il22_energy(rsize i, rsize k, rsize l, rsize j) { return g_P->int22[_bp(i,j)][_bp2(j,3,l, i,3,k)][_next(i,1,k)][_next(i,2,k)][_prev(j,2,l)][_prev(j,1,l)]; }

__device__ static int il_ent(rsize l) { /*assert(l>1);*/ return g_P->internal_loop[MAXLOOP] + (l > MAXLOOP ? jacobson_stockmayer(l) : 0); }
__device__ static int il_stack(rsize i, rsize k, rsize l, rsize j) { return g_P->mismatchI[_bp(i,j)][_next(i,1,j-1)][_prev(j,1,i+1)] + g_P->mismatchI[_bp(l,k)][_next(l,1,j-1)][_prev(k,1,i+1)]; }
__device__ static int il_asym(rsize sl, rsize sr) { int r = abs((int)sl-(int)sr) * g_P->ninio[0]; return (r < g_P->ninio[1]) ? r : g_P->ninio[1]; }

__device__ int il_energy(rsize i, rsize k, rsize l, rsize j) {
  rsize sl = k-i-1 - noGaps(i+1, k-1);
  rsize sr = j-l-1 - noGaps(l+1, j-1);

  int out_closingBP = _bp(i,j);
  int out_lbase = _next(i,1,j-1);
  int out_rbase = _prev(j,1,i+1);
  int in_closingBP = _bp(l,k); // Note, basepair and stacking bases are reversed to preserver 5'-3' order
  int in_lbase = _next(l,1,j-1);
  int in_rbase = _prev(k,1,i+1);

  if (sl == 0) return br_energy(i, l+1, j-1, j, k); //internal loop really is an right bulge, because left unpaired region is just a gap
  if (sr == 0) return bl_energy(i, i+1, k-1, j, l); //internal loop really is an left bulge, because right unpaired region is just a gap

  if (sl == 1) {
    if (sr == 1) return il11_energy(i, k, l, j);
    else if (sr == 2) return il12_energy(i, k, l, j);
    else return il_ent(sl+sr) + il_asym(sl,sr) + g_P->mismatch1nI[out_closingBP][out_lbase][out_rbase] + g_P->mismatch1nI[in_closingBP][in_lbase][in_rbase];
  } else if (sl == 2) {
    if (sr == 1) return il21_energy(i, k, l, j);
    else if (sr == 2) return il22_energy(i, k, l, j);
    else if (sr == 3) return g_P->internal_loop[5]+g_P->ninio[0] + g_P->mismatch23I[out_closingBP][out_lbase][out_rbase] + g_P->mismatch23I[in_closingBP][in_lbase][in_rbase];
  } else if ((sl == 3) && (sr == 2)) {
    return g_P->internal_loop[5]+g_P->ninio[0] + g_P->mismatch23I[out_closingBP][out_lbase][out_rbase] + g_P->mismatch23I[in_closingBP][in_lbase][in_rbase];
  } else if (sr == 1) {
    return il_ent(sl+sr) + il_asym(sl,sr) + g_P->mismatch1nI[out_closingBP][out_lbase][out_rbase] + g_P->mismatch1nI[in_closingBP][in_lbase][in_rbase];
  }
  return il_ent(sl+sr) + il_stack(i, k, l, j) + il_asym(sl, sr);
}

__device__ static int bl_ent(rsize l) { /*assert(l>0);*/ return (l>MAXLOOP) ? g_P->bulge[MAXLOOP] + jacobson_stockmayer(l) : g_P->bulge[l]; }

__device__ int bl_energy(rsize i, rsize k, rsize l, rsize j, rsize Xright) {
  // assert(j >= 2); // this is of no biological relevance, just to avoid an underflow
  rsize size = l-k+1 - noGaps(k, l);
  if (size==0) return g_P->stack[_bp(i,j)][_bp(getPrev(j,1,Xright),l+1)];
  if (size==1) return bl_ent(size) + g_P->stack[_bp(i,j)][_bp(getPrev(j,1,Xright),l+1)];
  if (size>1) return bl_ent(size) + termau_energy(i,j) + termau_energy(getPrev(j,1,Xright), l+1);
  return -1000000; // error
}

__device__ int br_energy(rsize i, rsize k, rsize l, rsize j, rsize Xleft) {
  // assert(j >= 1); // this is of no biological relevance, just to avoid an underflow
  rsize size = l-k+1 - noGaps(k, l);
  if (size == 0) return g_P->stack[_bp(i,j)][_bp(k-1,getNext(i,1,Xleft))];
  if (size == 1) return bl_ent(size) + g_P->stack[_bp(i,j)][_bp(k-1,getNext(i,1,Xleft))];
  if (size > 1) return bl_ent(size) + termau_energy(i, j) + termau_energy(k-1, getNext(i,1,Xleft));
  return -1000000; // error
}

__device__ int sr_energy(rsize i, rsize j) { return g_P->stack[_bp(i,j)][_bp(j-1,i+1)]; }
__device__ int sr_pk_energy(char a, char b, char c, char d) { return g_P->stack[_bp(a,b)][_bp(d,c)]; }

__device__ int dl_energy(rsize i, rsize j) { if (i==0) return 0; int dd = g_P->dangle5[_bp(i,j)][_prev(i,1,0)]; return (dd>0) ? 0 : dd; } // must be <= 0
__device__ int dr_energy(rsize i, rsize j) { if ((j+1)>=g_len) return 0; int dd = g_P->dangle3[_bp(i,j)][_next(j,1,g_len)]; return (dd>0) ? 0 : dd; } // must be <= 0
__device__ int dli_energy(rsize i, rsize j) { int dd = g_P->dangle3[_bp(j,i)][_next(i,1,j-1)]; return (dd>0) ? 0 : dd; } // must be <= 0
__device__ int dri_energy(rsize i, rsize j) { int dd = g_P->dangle5[_bp(j,i)][_prev(j,1,i+1)]; return (dd>0) ? 0 : dd; } // must be <= 0

__device__ int ext_mismatch_energy(rsize i, rsize j) {
  if ((i > 0) && ((j+1) < g_len)) return g_P->mismatchExt[_bp(i,j)][_prev(i,1,0)][_next(j,1,g_len)];
  else if (i > 0) return dl_energy(i,j);
  else if ((j+1) < g_len) return dr_energy(i,j);
  else return 0;
}

__device__ int ml_mismatch_energy(rsize i, rsize j) { return g_P->mismatchM[_bp(j,i)][_prev(j,1,i+1)][_next(i,1,j-1)]; } // Note, basepairs and stacking bases are reversed to preserver 5'-3' order
__device__ int ml_energy() { return g_P->MLclosing; }
__device__ int ul_energy() { return g_P->MLintern[0]; }
__device__ int sbase_energy() { return 0; }
__device__ int ss_energy(rsize i, rsize j) { return 0; }

__device__ double mk_pf(double x) { return exp((-1.0 * x/100.0) / (GASCONST/1000 * (g_P->temperature + K0))); }

__device__ double scale(int x) {
  double mean_nrg= -0.1843;  // mean energy for random sequences: 184.3*length cal
  double mean_scale = exp (-1.0 * mean_nrg / (GASCONST/1000 * (g_P->temperature + K0)));
  return (1.0 / pow(mean_scale, x));
}

__device__ int dl_dangle_dg(enum base_t dangle, enum base_t i, enum base_t j) {
  int dd = g_P->dangle5[_bp(i,j)][dangle]; return (dd>0) ? 0 : dd;  // must be <= 0
}

__device__ int dr_dangle_dg(enum base_t i, enum base_t j, enum base_t dangle) {
  int dd = g_P->dangle3[_bp(i,j)][dangle]; return (dd>0) ? 0 : dd;  // must be <= 0
}

// added by gsauthof, 2012
__device__ static const bool map_base_iupac[5][12] = {
    /*      { N    , A     , C     , G     , U     , _     , B     , D     , H     , R     , V     , Y     } */
    /* N */ { true , true  , true  , true  , true  , true  , true  , true  , true  , true  , true  , true  }  ,
    /* A */ { true , true  , false , false , false , false , false , true  , true  , true  , true  , false }  ,
    /* C */ { true , false , true  , false , false , false , true  , false , true  , false , true  , true  }  ,
    /* G */ { true , false , false , true  , false , false , true  , true  , false , true  , true  , false }  ,
    /* U */ { true , false , false , false , true  , false , true  , true  , true  , false , false , true  }  ,
};

__device__ bool iupac_match(enum base_t base, unsigned char iupac_base) {
  // assert(iupac_base<12);
  return map_base_iupac[base][iupac_base];
}

// -----------------------------------------------------------------------------
// EXAMPLE APPLICATION
// -----------------------------------------------------------------------------

#include "vienna/vienna.c"
#include "vienna/energy_par.c"

// -----------------------------
#define cuReset cudaDeviceReset()
#define cuDevSync cudaDeviceSynchronize()
#define cuErr(err) cuErr_(err,__FILE__,__LINE__)
__attribute__((unused)) static inline void cuErr_(cudaError_t err, const char *file, int line) { if (err==cudaSuccess) return;
    fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); cudaDeviceReset(); exit(EXIT_FAILURE);
}
// Device memory
#define cuMalloc(ptr,size) cuErr(cudaMalloc((void**)&ptr,size))
#define cuFree(ptr) cuErr(cudaFree(ptr))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
// -----------------------------

static paramT *cg_P=NULL;
static char* cg_seq=NULL; // CPU pointers
__global__ void _initP(paramT* params) { g_P=params; }
void initP() { paramT* P = get_scaled_parameters(); cuMalloc(cg_P,sizeof(paramT)); cuPut(P,cg_P,sizeof(paramT),NULL); _initP<<<1,1>>>(cg_P); free(P); }
void freeP() { cuFree(cg_P); }

__global__ void _initSeq(const char* seq, int len) { g_seq=seq; g_len=len; }
void initSeq(const char* str) {
  size_t i,len=strlen(str); char* seq=(char*)malloc((len+1)*sizeof(char));
  for (i=0;i<len;++i) switch(str[i]) {
    case 'a': seq[i]=1; break; case 'c': seq[i]=2; break; case 'g': seq[i]=3; break; case 'u': seq[i]=4; break;
    default: fprintf(stderr,"Bad character '%c' (%d) in the provided sequence.\n",str[i],str[i]); exit(1);
  }
  seq[len]=0; cuMalloc(cg_seq,len); cuPut(seq,cg_seq,len,NULL); _initSeq<<<1,1>>>(cg_seq,len); free(seq);
}
void freeSeq() { cuFree(cg_seq); }

int main() {
    read_parameter_file("vienna/rna_turner2004.par");
    initP();
    initSeq("guaugagaua");
    // execution here
    freeSeq();
    freeP();
    return 0;
}
