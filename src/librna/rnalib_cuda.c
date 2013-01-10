/* RNA energy library, CUDA Wrapper for Vienna-Tables */

#include "rnalib.h"
#include "vienna/vienna.h"

paramT *P = 0;

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>

static int bp_index(char x, char y) {
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

static rsize noGaps(const char *s, rsize i, rsize j) {
  rsize noGaps = 0;
  for (rsize k = i; k <= j; ++k) if (s[k] == GAP_BASE) ++noGaps;
  return noGaps;
}

static size_t ungapRegion(const char *s, rsize i, rsize j, char *ungapped) {
  rsize pos = 0;
  for (rsize y = i; y <= j; ++y) if (s[y] != GAP_BASE) ungapped[pos++] = s[y];
  return pos;
}

static rsize getNext(const char *s, rsize pos, rsize steps, rsize rightBorder) {
  assert(steps>0);
  rsize nongaps=0, x=pos+1; if (x > rightBorder) return rightBorder;
  do { if (s[x] != GAP_BASE) ++nongaps; } while (nongaps < steps && ++x < rightBorder);
  return x;
}

static rsize getPrev(const char *s, rsize pos, rsize steps, rsize leftBorder) {
  assert(pos>0); assert(steps>0);
  rsize nongaps=0, x=pos-1; if (x <= leftBorder) return leftBorder;
  do { if (s[x] != GAP_BASE) ++nongaps; } while (nongaps < steps && --x > leftBorder);
  return x;
}

static void decode(char *s, const char *x, const int len) {
	unsigned int i;
	for (i = 0; i < len; ++i) switch (x[i]) {
      case 0 : s[i] = 'N'; break;
      case 1 : s[i] = 'A'; break;
      case 2 : s[i] = 'C'; break;
      case 3 : s[i] = 'G'; break;
      case 4 : s[i] = 'U'; break;
      case 5 : s[i] = '_'; break;
      default: abort();
	}
}

static int jacobson_stockmayer(rsize l) { return (int)(P->lxc*log((l)/(1.0 * MAXLOOP))); }
static int hl_ent(rsize l) { return (l>MAXLOOP) ? P->hairpin[MAXLOOP]+jacobson_stockmayer(l) : P->hairpin[l]; }

static int hl_stack(const char *s, rsize i, rsize j) {
  int bp = bp_index(s[i], s[j]);
  return P->mismatchH[bp][s[getNext(s,i,1,j-1)]][s[getPrev(s,j,1,i+1)]];
}

int termau_energy(const char *s, rsize i, rsize j) {
  if ((s[i] == G_BASE && s[j] == C_BASE) || (s[i] == C_BASE && s[j] == G_BASE)) return 0;
  else return P->TerminalAU;
}

int hl_energy(const char *s, rsize i, rsize j) {
  assert(j-i>1);
  rsize size = j-i-1 - noGaps(s,i+1,j-1);
  int entropy = hl_ent(size);
  int stack_mismatch = hl_stack(s, i, j);

  if (size < 3) return 600;
  if (size == 3 || size == 4 || size == 6) {
	char ungapped[j-i+1];
	int sizeUngapped = ungapRegion(s, i, j, ungapped);
    char loop[sizeUngapped+1];
    loop[sizeUngapped] = 0;
	decode(loop, ungapped, sizeUngapped);
	if (sizeUngapped == 3+2) {
	  char tl[6]={0,0,0,0,0,0}, *ts;
	  strncpy(tl, loop, 5);
	  if ((ts=strstr(P->Triloops, tl))) return (P->Triloop_E[(ts - P->Triloops)/6]);
	} else if (sizeUngapped == 4+2) {
	  //special tetraloop cases
	  char tl[7]={0}, *ts;
	  strncpy(tl, loop, 6);
	  if ((ts=strstr(P->Tetraloops, tl))) return (P->Tetraloop_E[(ts - P->Tetraloops)/7]);
	} else if (sizeUngapped == 6+2) {
	  //special hexaloop cases
	  char tl[9]={0}, *ts;
	  strncpy(tl, loop, 8);
	  if ((ts=strstr(P->Hexaloops, tl))) return (P->Hexaloop_E[(ts - P->Hexaloops)/9]);
	}
  }

  if (size == 3) return entropy + termau_energy(s, i, j); //normal hairpins of loop size 3
  else return entropy + stack_mismatch; //normal hairpins of loop sizes larger than three
}

int hl_energy_stem(const char *s, rsize i, rsize j) {
  int r = hl_energy(s, i, j);
  rsize size = j-i-1 - noGaps(s,i+1,j-1);
  if (size >= 4) {
    int stack_mismatch = hl_stack(s, i, j);
    return r - stack_mismatch;
  }
  return r;
}

static int il11_energy(const char *s, rsize i, rsize k, rsize l, rsize j) {
  int closingBP = bp_index(s[i],   s[j]  );
  int enclosedBP = bp_index(s[getPrev(s,j,2,l)], s[getNext(s,i,2,k)]); //we know that the enclosed base pair is at exactly this position, since both unpaired regions have size 1.  Note, basepair is reversed to preserver 5'-3' order.
  return P->int11[closingBP][enclosedBP][s[getNext(s,i,1,k)]][s[getPrev(s,j,1,l)]];
}

static int il12_energy(const char *s, rsize i, rsize k, rsize l, rsize j) {
  int closingBP = bp_index(s[i],   s[j]  );
  int enclosedBP = bp_index(s[getPrev(s,j,3,l)], s[getNext(s,i,2,k)]);
  return P->int21[closingBP][enclosedBP][s[getNext(s,i,1,k)]][s[getPrev(s,j,2,l)]][s[getPrev(s,j,1,l)]];
}

static int il21_energy(const char *s, rsize i, rsize k, rsize l, rsize j) {
  int closingBP = bp_index(s[getPrev(s,j,2,l)], s[getNext(s,i,3,k)]);
  int enclosedBP = bp_index(s[i],   s[j]  );
  return P->int21[closingBP][enclosedBP][s[getPrev(s,j,1,l)]][s[getNext(s,i,1,k)]][s[getNext(s,i,2,k)]];
}

static int il22_energy(const char *s, rsize i, rsize k, rsize l, rsize j) {
  int closingBP = bp_index(s[i],   s[j]  );
  int enclosedBP = bp_index(s[getPrev(s,j,3,l)], s[getNext(s,i,3,k)]);
  return P->int22[closingBP][enclosedBP][s[getNext(s,i,1,k)]][s[getNext(s,i,2,k)]][s[getPrev(s,j,2,l)]][s[getPrev(s,j,1,l)]];
}

static int il_ent(rsize l) {
  assert(l>1);
  if (l > MAXLOOP) return P->internal_loop[MAXLOOP] + jacobson_stockmayer(l);
  else return P->internal_loop[l];
}

static int il_stack(const char *s, rsize i, rsize k, rsize l, rsize j) {
  int out_closingBP = bp_index(s[i], s[j]);
  unsigned int in_closingBP = bp_index(s[l], s[k]); // Note, basepair and stacking bases are reversed to preserver 5'-3' order
  return P->mismatchI[out_closingBP][s[getNext(s,i,1,j-1)]][s[getPrev(s,j,1,i+1)]] + P->mismatchI[in_closingBP][s[getNext(s,l,1,j-1)]][s[getPrev(s,k,1,i+1)]];
}

static int il_asym(rsize sl, rsize sr) {
  int r = abs(sl-sr) * P->ninio[2];
  return (r < MAX_NINIO) ? r : MAX_NINIO;
}

int il_energy(const char *s, rsize i, rsize k, rsize l, rsize j) {
  rsize sl = k-i-1 - noGaps(s, i+1, k-1);
  rsize sr = j-l-1 - noGaps(s, l+1, j-1);

  int out_closingBP = bp_index(s[i], s[j]);
  int out_lbase = s[getNext(s,i,1,j-1)];
  int out_rbase = s[getPrev(s,j,1,i+1)];
  int in_closingBP = bp_index(s[l], s[k]); // Note, basepair and stacking bases are reversed to preserver 5'-3' order
  int in_lbase = s[getNext(s,l,1,j-1)];
  int in_rbase = s[getPrev(s,k,1,i+1)];

  if (sl == 0) return br_energy(s, i, l+1, j-1, j, k); //internal loop really is an right bulge, because left unpaired region is just a gap
  if (sr == 0) return bl_energy(s, i, i+1, k-1, j, l); //internal loop really is an left bulge, because right unpaired region is just a gap

  if (sl == 1) {
	if (sr == 1) return il11_energy(s, i, k, l, j);
	else if (sr == 2) return il12_energy(s, i, k, l, j);
	else return il_ent(sl+sr) + il_asym(sl,sr) + P->mismatch1nI[out_closingBP][out_lbase][out_rbase] + P->mismatch1nI[in_closingBP][in_lbase][in_rbase];
  } else if (sl == 2) {
	if (sr == 1) return il21_energy(s, i, k, l, j);
	else if (sr == 2) return il22_energy(s, i, k, l, j);
	else if (sr == 3) return P->internal_loop[5]+P->ninio[2] + P->mismatch23I[out_closingBP][out_lbase][out_rbase] + P->mismatch23I[in_closingBP][in_lbase][in_rbase];
  } else if ((sl == 3) && (sr == 2)) {
	return P->internal_loop[5]+P->ninio[2] + P->mismatch23I[out_closingBP][out_lbase][out_rbase] + P->mismatch23I[in_closingBP][in_lbase][in_rbase];
  } else if (sr == 1) {
    return il_ent(sl+sr) + il_asym(sl,sr) + P->mismatch1nI[out_closingBP][out_lbase][out_rbase] + P->mismatch1nI[in_closingBP][in_lbase][in_rbase];
  }
  return il_ent(sl+sr) + il_stack(s, i, k, l, j) + il_asym(sl, sr);
}

static int bl_ent(rsize l) {
  assert(l>0);
  if (l > MAXLOOP) return P->bulge[MAXLOOP] + jacobson_stockmayer(l);
  else return P->bulge[l];
}

int bl_energy(const char *s, rsize i, rsize k, rsize l, rsize j, rsize Xright) {
  assert(j >= 2); // this is of no biological relevance, just to avoid an underflow
  rsize size = l-k+1 - noGaps(s, k, l);

  if (size==0) {
    int closingBP = bp_index(s[i], s[j]);
    int enclosedBP = bp_index(s[getPrev(s,j,1,Xright)],s[l+1]);
    return P->stack[closingBP][enclosedBP];
  }
  if (size==1) {
    int closingBP = bp_index(s[i], s[j]);
    int enclosedBP = bp_index(s[getPrev(s,j,1,Xright)],s[l+1]);
    return bl_ent(size) + P->stack[closingBP][enclosedBP];
  }
  if (size>1) {
	return bl_ent(size) + termau_energy(s, i, j) + termau_energy(s, getPrev(s,j,1,Xright), l+1);
  }

  fprintf(stderr, "bl_energy size < 1\n");
  assert(0);
}

int br_energy(const char *s, rsize i, rsize k, rsize l, rsize j, rsize Xleft) {
  assert(j >= 1); // this is of no biological relevance, just to avoid an underflow
  rsize size = l-k+1 - noGaps(s, k, l);

  if (size == 0) {
    int closingBP = bp_index(s[i], s[j]);
    int enclosedBP = bp_index(s[k-1],s[getNext(s,i,1,Xleft)]);
    return P->stack[closingBP][enclosedBP];
  } else if (size == 1) {
    int closingBP = bp_index(s[i], s[j]);
    int enclosedBP = bp_index(s[k-1],s[getNext(s,i,1,Xleft)]);
    return bl_ent(size) + P->stack[closingBP][enclosedBP];
  } else if (size > 1){
	return bl_ent(size) + termau_energy(s, i, j) + termau_energy(s, k-1, getNext(s,i,1,Xleft));
  }
  fprintf(stderr, "br_energy size < 1\n");
  assert(0);
}

int sr_energy(const char *s, rsize i, rsize j) {
  int closingBP = bp_index(s[i], s[j]);
  int enclosedBP = bp_index(s[j-1],s[i+1]);
  return P->stack[closingBP][enclosedBP];
}

int sr_pk_energy(char a, char b, char c, char d) {
  int closingBP = bp_index(a, b);
  int enclosedBP = bp_index(d, c);
  return P->stack[closingBP][enclosedBP];
}

int dl_energy(const char *s, rsize i, rsize j) {
  if (i == 0) return 0;
  int closingBP = bp_index(s[i], s[j]);
  int dd = P->dangle5[closingBP][s[getPrev(s,i,1,0)]];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

int dr_energy(const char *s, rsize i, rsize j, rsize n) {
  if ((j+1) >= n) return 0;
  int closingBP = bp_index(s[i], s[j]);
  int dd = P->dangle3[closingBP][s[getNext(s,j,1,n)]];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

int dli_energy(const char *s, rsize i, rsize j) {
  int closingBP = bp_index(s[j], s[i]);
  int dd = P->dangle3[closingBP][s[getNext(s,i,1,j-1)]];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

int dri_energy(const char *s, rsize i, rsize j) {
  int closingBP = bp_index(s[j], s[i]);
  int dd = P->dangle5[closingBP][s[getPrev(s,j,1,i+1)]];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

int ext_mismatch_energy(const char *s, rsize i, rsize j, rsize n) {
  if ((i > 0) && ((j+1) < n)) {
    int closingBP = bp_index(s[i],s[j]);
    return P->mismatchExt[closingBP][s[getPrev(s,i,1,0)]][s[getNext(s,j,1,n)]];
  } else {
    if (i > 0) return dl_energy(s,i,j);
    if ((j+1) < n) return dr_energy(s,i,j,n);
    return 0;
  }
}

int ml_mismatch_energy(const char *s, rsize i, rsize j) {
  int closingBP = bp_index(s[j],s[i]); // Note, basepairs and stacking bases are reversed to preserver 5'-3' order
  int lbase = s[getPrev(s,j,1,i+1)];
  int rbase = s[getNext(s,i,1,j-1)];
  return P->mismatchM[closingBP][lbase][rbase];
}

int ml_energy(void) { return P->MLclosing; }
int ul_energy(void) { return P->MLintern[0]; }
int sbase_energy(void) { return 0; }
int ss_energy(rsize i, rsize j) { return 0; }

double mk_pf(double x) { return exp((-1.0 * x/100.0) / (GASCONST/1000 * (temperature + K0))); }

double scale(int x) {
  double mean_nrg= -0.1843;  /* mean energy for random sequences: 184.3*length cal */
  double mean_scale = exp (-1.0 * mean_nrg / (GASCONST/1000 * (temperature + K0)));
  return (1.0 / pow(mean_scale, x));
}

int dl_dangle_dg(enum base_t dangle, enum base_t i, enum base_t j) {
  int closingBP = bp_index(i,j);
  int dd = P->dangle5[closingBP][dangle];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

int dr_dangle_dg(enum base_t i, enum base_t j, enum base_t dangle) {
  int closingBP = bp_index(i, j);
  return P->dangle3[closingBP][dangle];
  int dd = P->dangle3[closingBP][dangle];
  return (dd>0) ? 0 : dd;  /* must be <= 0 */
}

// added by gsauthof, 2012
static const bool map_base_iupac[5][12] = {
    /*      { N    , A     , C     , G     , U     , _     , B     , D     , H     , R     , V     , Y     }  , */
    /* N */ { true , true  , true  , true  , true  , true  , true  , true  , true  , true  , true  , true  }  ,
    /* A */ { true , true  , false , false , false , false , false , true  , true  , true  , true  , false }  ,
    /* C */ { true , false , true  , false , false , false , true  , false , true  , false , true  , true  }  ,
    /* G */ { true , false , false , true  , false , false , true  , true  , false , true  , true  , false }  ,
    /* U */ { true , false , false , false , true  , false , true  , true  , true  , false , false , true  }  ,
};

bool iupac_match(enum base_t base, unsigned char iupac_base) {
  assert(iupac_base<12);
  return map_base_iupac[base][iupac_base];
}
