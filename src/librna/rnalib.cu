/* RNA energy library, CUDA Wrapper for Vienna-Tables */

// ------------- HEADER
enum base_t { N_BASE, A_BASE, C_BASE, G_BASE, U_BASE, GAP_BASE };
enum iupac_t { N_IUPAC = 0, B_IUPAC = 6, D_IUPAC = 7, H_IUPAC = 8, R_IUPAC = 9, V_IUPAC = 10, Y_IUPAC = 11 };
enum bp_t { N_BP, CG_BP, GC_BP, GU_BP, UG_BP, AU_BP, UA_BP, NO_BP };
typedef unsigned int rsize;

__device__ int termau_energy(rsize i, rsize j);
__device__ int hl_energy(rsize i, rsize j);
__device__ int hl_energy_stem(rsize i, rsize j);
__device__ int il_energy(rsize i, rsize j, rsize k, rsize l);
__device__ int bl_energy(rsize bl, rsize i, rsize j, rsize br, rsize Xright);
__device__ int br_energy(rsize bl, rsize i, rsize j, rsize br, rsize Xleft);
__device__ int sr_energy(rsize i, rsize j);
__device__ int sr_pk_energy(char a, char b, char c, char d);
__device__ int dl_energy(rsize i, rsize j);
__device__ int dr_energy(rsize i, rsize j, rsize n);
__device__ int dli_energy(rsize i, rsize j);
__device__ int dri_energy(rsize i, rsize j);
__device__ int ext_mismatch_energy(rsize i, rsize j, rsize n);
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
// ------------- HEADER

#include "vienna/vienna.h" // paramT

__device__ paramT *g_P = 0;
__device__ const char* g_seq;

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

__device__ static int bp_index(char x, char y) {
  switch (x) {
    case A_BASE : switch (y) {
        case U_BASE : return AU_BP;
        case GAP_BASE : return NO_BP;
      }
      break;
    case C_BASE : switch (y) {
        case G_BASE : return CG_BP;
        case GAP_BASE : return NO_BP;
      }
      break;
    case G_BASE : switch (y) {
        case C_BASE : return GC_BP;
        case U_BASE : return GU_BP;
        case GAP_BASE : return NO_BP;
      }
      break;
    case U_BASE : switch (y) {
        case G_BASE : return UG_BP;
        case A_BASE : return UA_BP;
        case GAP_BASE : return NO_BP;
      }
      break;
    case GAP_BASE : return NO_BP;
  }
  return NO_BP;
}
#define _bp(i,j) bp_index(g_seq[i],g_seq[j])

__device__ static rsize noGaps(rsize i, rsize j) {
  rsize noGaps=0; for (rsize k=i; k<=j; ++k) if (g_seq[k] == GAP_BASE) ++noGaps;
  return noGaps;
}

__device__ static size_t ungapRegion(rsize i, rsize j, char *ungapped) {
  rsize pos=0; for (rsize y=i; y<=j; ++y) if (g_seq[y] != GAP_BASE) ungapped[pos++] = g_seq[y];
  return pos;
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

__device__ static void decode(char *s, const char *x, const int len) {
	unsigned int i;
	for (i = 0; i < len; ++i) switch (x[i]) {
      case 0 : s[i] = 'N'; break;
      case 1 : s[i] = 'A'; break;
      case 2 : s[i] = 'C'; break;
      case 3 : s[i] = 'G'; break;
      case 4 : s[i] = 'U'; break;
      case 5 : s[i] = '_'; break;
      default: s[i] = '?'; //abort();
	}
}

__device__ static int jacobson_stockmayer(rsize l) { return (int)(g_P->lxc*log((l)/(1.0 * MAXLOOP))); }
__device__ static int hl_ent(rsize l) { return (l>MAXLOOP) ? g_P->hairpin[MAXLOOP]+jacobson_stockmayer(l) : g_P->hairpin[l]; }

__device__ static int hl_stack(rsize i, rsize j) {
  return g_P->mismatchH[_bp(i,j)][_next(i,1,j-1)][_prev(j,1,i+1)];
}

__device__ int termau_energy(rsize i, rsize j) {
  if ((g_seq[i] == G_BASE && g_seq[j] == C_BASE) || (g_seq[i] == C_BASE && g_seq[j] == G_BASE)) return 0;
  else return g_P->TerminalAU;
}

__device__ static char *strstr2(const char *s1, const char *s2) {
  const char* p=s1;
  do {
    int n=0; while(s2[n]==p[n] && p[n]) ++n;
    if (s2[n]==0) return (char*)p;
  } while (*(++p));
  return NULL;
}

__device__ int hl_energy(rsize i, rsize j) {
  // assert(j-i>1);
  rsize size = j-i-1 - noGaps(i+1,j-1);
  int entropy = hl_ent(size);
  int stack_mismatch = hl_stack(i,j);

  if (size < 3) return 600;
  if (size == 3 || size == 4 || size == 6) {
	char ungapped[20]; // XXX: j-i+1
	int sizeUngapped = ungapRegion(i,j,ungapped);
    char loop[20]; // XXX: sizeUngapped+1
    loop[sizeUngapped] = 0;
	decode(loop, ungapped, sizeUngapped);
	if (sizeUngapped == 3+2) {
	  char *ts; loop[5]=0;
	  if ((ts=strstr2(g_P->Triloops, loop))) return (g_P->Triloop_E[(ts - g_P->Triloops)/6]);
	} else if (sizeUngapped == 4+2) { //special tetraloop cases
	  char *ts; loop[6]=0;
	  if ((ts=strstr2(g_P->Tetraloops, loop))) return (g_P->Tetraloop_E[(ts - g_P->Tetraloops)/7]);
	} else if (sizeUngapped == 6+2) { //special hexaloop cases
	  char *ts; loop[8]=0;
	  if ((ts=strstr2(g_P->Hexaloops, loop))) return (g_P->Hexaloop_E[(ts - g_P->Hexaloops)/9]);
	}
  }
  if (size == 3) return entropy + termau_energy(i, j); //normal hairpins of loop size 3
  else return entropy + stack_mismatch; //normal hairpins of loop sizes larger than three
}

__device__ int hl_energy_stem(rsize i, rsize j) {
  int r = hl_energy(i, j);
  rsize size = j-i-1 - noGaps(i+1,j-1);
  if (size >= 4) {
    int stack_mismatch = hl_stack(i, j);
    return r - stack_mismatch;
  }
  return r;
}

__device__ static int il11_energy(rsize i, rsize k, rsize l, rsize j) {
  int closingBP = _bp(i, j);
  int enclosedBP = bp_index(_prev(j,2,l), _next(i,2,k)); //we know that the enclosed base pair is at exactly this position, since both unpaired regions have size 1.  Note, basepair is reversed to preserver 5'-3' order.
  return g_P->int11[closingBP][enclosedBP][_next(i,1,k)][_prev(j,1,l)];
}

__device__ static int il12_energy(rsize i, rsize k, rsize l, rsize j) {
  int closingBP = _bp(i,j);
  int enclosedBP = bp_index(_prev(j,3,l), _next(i,2,k));
  return g_P->int21[closingBP][enclosedBP][_next(i,1,k)][_prev(j,2,l)][_prev(j,1,l)];
}

__device__ static int il21_energy(rsize i, rsize k, rsize l, rsize j) {
  int closingBP = bp_index(_prev(j,2,l), _next(i,3,k));
  int enclosedBP = _bp(i, j);
  return g_P->int21[closingBP][enclosedBP][_prev(j,1,l)][_next(i,1,k)][_next(i,2,k)];
}

__device__ static int il22_energy(rsize i, rsize k, rsize l, rsize j) {
  int closingBP = _bp(i,j);
  int enclosedBP = bp_index(_prev(j,3,l), _next(i,3,k));
  return g_P->int22[closingBP][enclosedBP][_next(i,1,k)][_next(i,2,k)][_prev(j,2,l)][_prev(j,1,l)];
}

__device__ static int il_ent(rsize l) { // assert(l>1);
  return g_P->internal_loop[MAXLOOP] + (l > MAXLOOP ? jacobson_stockmayer(l) : 0);
}

__device__ static int il_stack(rsize i, rsize k, rsize l, rsize j) {
  int out_closingBP = _bp(i,j);
  unsigned int in_closingBP = _bp(l,k); // Note, basepair and stacking bases are reversed to preserver 5'-3' order
  return g_P->mismatchI[out_closingBP][_next(i,1,j-1)][_prev(j,1,i+1)] + g_P->mismatchI[in_closingBP][_next(l,1,j-1)][_prev(k,1,i+1)];
}

__device__ static int il_asym(rsize sl, rsize sr) {
  int r = abs((int)sl-(int)sr) * g_P->ninio[0];
  return (r < g_P->ninio[1]) ? r : g_P->ninio[1];
}

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

__device__ static int bl_ent(rsize l) {
  // assert(l>0);
  if (l>MAXLOOP) return g_P->bulge[MAXLOOP] + jacobson_stockmayer(l);
  else return g_P->bulge[l];
}

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

__device__ int dl_energy(rsize i, rsize j) {
  if (i == 0) return 0;
  int dd = g_P->dangle5[_bp(i,j)][_prev(i,1,0)];
  return (dd>0) ? 0 : dd; // must be <= 0
}

__device__ int dr_energy(rsize i, rsize j, rsize n) {
  if ((j+1) >= n) return 0;
  int dd = g_P->dangle3[_bp(i,j)][_next(j,1,n)];
  return (dd>0) ? 0 : dd; // must be <= 0
}

__device__ int dli_energy(rsize i, rsize j) {
  int dd = g_P->dangle3[_bp(j,i)][_next(i,1,j-1)];
  return (dd>0) ? 0 : dd; // must be <= 0
}

__device__ int dri_energy(rsize i, rsize j) {
  int dd = g_P->dangle5[_bp(j,i)][_prev(j,1,i+1)];
  return (dd>0) ? 0 : dd; // must be <= 0
}

__device__ int ext_mismatch_energy(rsize i, rsize j, rsize n) {
  if ((i > 0) && ((j+1) < n)) return g_P->mismatchExt[_bp(i,j)][_prev(i,1,0)][_next(j,1,n)];
  else if (i > 0) return dl_energy(i,j);
  else if ((j+1) < n) return dr_energy(i,j,n);
  else return 0;
}

__device__ int ml_mismatch_energy(rsize i, rsize j) {
  return g_P->mismatchM[_bp(j,i)][_prev(j,1,i+1)][_next(i,1,j-1)]; // Note, basepairs and stacking bases are reversed to preserver 5'-3' order
}

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
    /*      { N    , A     , C     , G     , U     , _     , B     , D     , H     , R     , V     , Y     }  , */
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

#include "vienna/vienna.c"
#include "vienna/energy_par.c"

int main() {
	return 0;
}
