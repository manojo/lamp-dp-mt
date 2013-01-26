#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <limits.h>

/**
 *  Compute minimum free energy and an appropriate secondary structure of an RNA sequence
 *
 *  The first parameter given, the RNA sequence, must be \a uppercase and should only contain
 *  an alphabet \f$\Sigma\f$ that is understood by the RNAlib\n
 *  (e.g. \f$ \Sigma = \{A,U,C,G\} \f$)\n
 *
 *  The second parameter, \a structure, must always point to an allocated
 *  block of memory with a size of at least \f$\mathrm{strlen}(\mathrm{sequence})+1\f$
 *
 *  After a successful call of fold_par(), a backtracked secondary structure (in dot-bracket notation)
 *  that exhibits the minimum of free energy will be written to the memory \a structure is pointing to.
 *  The function returns the minimum of free energy for any fold of the sequence given.
 *
 *  \param sequence       RNA sequence
 *  \param structure      A pointer to the character array where the
 *                        secondary structure in dot-bracket notation will be written to
 *  \return the minimum free energy (MFE) in kcal/mol
 */
float fold_par(const char *sequence, char *structure);

// -----------------------------------------------------------------------------
// IMPLEMENTATION
// -----------------------------------------------------------------------------

#include "vienna.h"
#include "energy_const.h"
#include "energy_par.h"

#define PUBLIC
#define PRIVATE static

#define space(S) calloc(1,(S))
#define MIN2(A,B) ((A) < (B) ? (A) : (B))

typedef struct sect { int i,j,ml; } sect; /** stack of partial structures for backtracking */
typedef struct bondT { unsigned int i,j; } bondT; /** base pair */

extern void nrerror(const char message[]);

#define NBASES 8
static int pair[NBASES][NBASES]=
/* _  A  C  G  U  X  K  I */
{{ 0, 0, 0, 0, 0, 0, 0, 0},
 { 0, 0, 0, 0, 5, 0, 0, 5},
 { 0, 0, 0, 1, 0, 0, 0, 0},
 { 0, 0, 2, 0, 3, 0, 0, 0},
 { 0, 6, 0, 4, 0, 0, 0, 6},
 { 0, 0, 0, 0, 0, 0, 2, 0},
 { 0, 0, 0, 0, 0, 1, 0, 0},
 { 0, 6, 0, 0, 5, 0, 0, 0}};

static short alias[NBASES+1];
static int rtype[8] = {0, 2, 1, 4, 3, 6, 5, 7}; /* rtype[pair[i][j]]:=pair[j][i] */

static void make_pair_matrix(void) {
   int i,j;

   for (i=0; i<5; i++) alias[i] = (short) i;
   alias[5] = 3; /* X <-> G */
   alias[6] = 2; /* K <-> C */
   alias[7] = 0; /* I <-> default base '@' */

   for (i=0; i<NBASES; i++) for (j=0; j<NBASES; j++) rtype[pair[i][j]] = pair[j][i];
}

static int encode_char(char c) {
  static const char Law_and_Order[] = "_ACGUTXKI";
  /* return numerical representation of base used e.g. in pair[][] */
  int code;
  const char *pos = strchr(Law_and_Order, c);
  if (pos==NULL) code=0;
  else code = (int) (pos-Law_and_Order);
  if (code>5) code = 0;
  if (code>4) code--; /* make T and U equivalent */
  return code;
}

static short *encode_sequence(const char *sequence, short how){
  unsigned int i,l = (unsigned int)strlen(sequence);
  short         *S = (short *) space(sizeof(short)*(l+2));

  switch(how){
    /* standard encoding as always used for S */
    case 0: for(i=1; i<=l; i++) /* make numerical encoding of sequence */
            S[i]= (short) encode_char(toupper(sequence[i-1]));
            S[l+1] = S[1];
            S[0] = (short) l;
            break;
    /* encoding for mismatches of nostandard bases (normally used for S1) */
    case 1: for(i=1; i<=l; i++) S[i] = alias[(short) encode_char(toupper(sequence[i-1]))];
            S[l+1] = S[1];
            S[0] = S[l];
            break;
  }
  return S;
}

#include "loop_energies.h"

#define MAXSECTORS    500  /* dimension for a backtrack array */
#define LOCALITY      0.   /* locality parameter for base-pairs */

/*
#################################
# PRIVATE VARIABLES             #
#################################
*/
PRIVATE int     *indx     = NULL; /* index for moving in the triangle matrices c[] and fMl[]*/
PRIVATE int     *c        = NULL; /* energy array, given that i-j pair */
PRIVATE int     *cc       = NULL; /* linear array for calculating canonical structures */
PRIVATE int     *cc1      = NULL; /*   "     "        */
PRIVATE int     *f5       = NULL; /* energy of 5' end */
PRIVATE int     *fML      = NULL; /* multi-loop auxiliary energy array */
PRIVATE int     *Fmi      = NULL; /* holds row i of fML (avoids jumps in memory) */
PRIVATE int     *DMLi     = NULL; /* DMLi[j] holds MIN(fML[i,k]+fML[k+1,j])  */
PRIVATE int     *DMLi1    = NULL; /*             MIN(fML[i+1,k]+fML[k+1,j])  */
PRIVATE int     *DMLi2    = NULL; /*             MIN(fML[i+2,k]+fML[k+1,j])  */
PRIVATE sect    sector[MAXSECTORS]; /* stack of partial structures for backtracking */
PRIVATE char    *ptype    = NULL; /* precomputed array of pair types */
PRIVATE short   *S = NULL, *S1 = NULL;
PRIVATE paramT  *P          = NULL;
PRIVATE bondT   *base_pair2 = NULL; // THIS STORES THE BACKTRACK PAIRS

/*
#################################
# PRIVATE FUNCTION DECLARATIONS #
#################################
*/
PRIVATE void  get_arrays(unsigned int size);
PRIVATE void  make_ptypes(const short *S, const char *structure);
PRIVATE void  backtrack(const char *sequence);
PRIVATE int   fill_arrays(const char *sequence);

/*
#################################
# BEGIN OF FUNCTION DEFINITIONS #
#################################
*/

//#define DBG
#ifdef DBG
unsigned my_size=0;
#endif
PRIVATE void get_arrays(unsigned int size){
  if(size >= (unsigned int)sqrt((double)INT_MAX))
    nrerror("get_arrays@fold.c: sequence length exceeds addressable range");
  #ifdef DBG
  my_size=size;
  #endif
  c     = (int *) space(sizeof(int)*((size*(size+1))/2+2)); // cost ??
  fML   = (int *) space(sizeof(int)*((size*(size+1))/2+2)); // cost ??
  ptype = (char*) space(sizeof(char)*((size*(size+1))/2+2)); // type of backtrack ??
  f5    = (int *) space(sizeof(int)*(size+2));
  cc    = (int *) space(sizeof(int)*(size+2));
  cc1   = (int *) space(sizeof(int)*(size+2));
  Fmi   = (int *) space(sizeof(int)*(size+1));
  DMLi  = (int *) space(sizeof(int)*(size+1));
  DMLi1 = (int *) space(sizeof(int)*(size+1));
  DMLi2 = (int *) space(sizeof(int)*(size+1));
  base_pair2 = (bondT *) space(sizeof(bondT)*(1+size/2));
}

/*--------------------------------------------------------------------------*/

PUBLIC void free_arrays(void){
  #ifdef DBG
  unsigned int i,j;
  #define PRINT_TAB(X) \
  for (i=1;i<=my_size;++i) { \
    printf("[ C  ] "); \
    for (j=1;j<=my_size;++j) { \
      if (j>i) { \
       int v = X[indx[j]+i]; \
       if (v>=214748364) printf("  .   |"); \
       else printf("%5d |",v); \
      } else printf("      |"); \
    } \
    printf("\n"); \
  }
  // indx[length]+1

  //printf("Table c:\n");
  PRINT_TAB(c)
  //printf("Table fML:\n"); PRINT_TAB(fML)
  #endif

  if(indx)      free(indx);
  if(c)         free(c);
  if(fML)       free(fML);
  if(f5)        free(f5);
  if(cc)        free(cc);
  if(cc1)       free(cc1);
  if(ptype)     free(ptype);
  if(base_pair2) free(base_pair2);
  if(Fmi)       free(Fmi);
  if(DMLi)      free(DMLi);
  if(DMLi1)     free(DMLi1);
  if(DMLi2)     free(DMLi2);
  if(P)         free(P);
  indx = c = fML = f5 = cc = cc1 = Fmi = DMLi = DMLi1 = DMLi2 = NULL;
  ptype       = NULL;
  base_pair2  = NULL;
  P           = NULL;
}


/*---------------------------------------------------------------------------*/

PRIVATE void make_ptypes(const short *S, const char *structure) {
  int n,i,j,k,l;

  n=S[0];
  for (k=1; k<n-TURN; k++)
    for (l=1; l<=2; l++) {
      int type,ntype=0,otype=0;
      i=k; j = i+TURN+l; if (j>n) continue;
      type = pair[S[i]][S[j]];
      while ((i>=1)&&(j<=n)) {
        if ((i>1)&&(j<n)) ntype = pair[S[i-1]][S[j+1]];
        if ((!otype) && (!ntype)) type = 0; /* i.j can only form isolated pairs */
        ptype[indx[j]+i] = (char) type;
        otype =  type;
        type  = ntype;
        i--; j++;
      }
    }
}

/*--------------------------------------------------------------------------*/


PUBLIC float fold_par(const char *string, char *structure) {
  int length, energy;
  length = (int) strlen(string);
  if (length<1) nrerror("initialize_fold: argument must be greater 0");
  get_arrays((unsigned) length);

  // TCK: set diagonal offsets
  unsigned int i;
  indx = (int *)calloc(1,sizeof(int) * (length+1));
  for (i = 1; i <= length; i++)
    indx[i] = (i*(i-1)) >> 1; // i(i-1)/2

  P = get_scaled_parameters();
  make_pair_matrix();

  S   = encode_sequence(string, 0);
  S1  = encode_sequence(string, 1);

  make_ptypes(S, structure);
  energy = fill_arrays(string);
  backtrack(string);

  free(S); free(S1);

  // TCK: pretty print the backtrack (parenthesis structure)
  int n;
  for (n=0; n<length; structure[n++]='.'); structure[length]='\0';
  for (n=1; n<=base_pair2[0].i; n++) {
    structure[base_pair2[n].i-1] = '(';
    structure[base_pair2[n].j-1] = ')';
  }

  free_arrays();
  return (float) energy/100.;
}

/** fill "c", "fML" and "f5" arrays and return optimal energy */
PRIVATE int fill_arrays(const char *string) {
  int   i, j, k, length, energy, en;
  int   decomp, new_fML, max_separation;
  int   type, type_2, tt;
  int   bonus=0;

  length = (int) strlen(string);
  max_separation = (int) ((1.-LOCALITY)*(double)(length-2)); /* not in use */

  for (j=1; j<=length; j++) Fmi[j]=DMLi[j]=DMLi1[j]=DMLi2[j]=INF;

  for (j = 1; j<=length; j++)
    for (i=(j>TURN?(j-TURN):1); i<j; i++) {
      c[indx[j]+i] = fML[indx[j]+i] = INF;
    }

  if (length <= TURN) return 0;

  for (i = length-TURN-1; i >= 1; i--) { /* i,j in [1..length] */
    for (j = i+TURN+1; j <= length; j++) {
      int p, q, ij;
      ij = indx[j]+i;
      bonus = 0;
      type = ptype[ij];
      energy = INF;

      if (j-i-1 > max_separation) type = 0;  /* forces locality degree */

      if (type) {   /* we have a pair */
        int new_c=0, stackEnergy=INF;
        /* hairpin ----------------------------------------------*/
        new_c = E_Hairpin(j-i-1, type, S1[i+1], S1[j-1], string+i-1, P);
        /* check for elementary structures involving more than one closing pair. */
        for (p = i+1; p <= MIN2(j-2-TURN,i+MAXLOOP+1) ; p++) {
          int minq = j-i+p-MAXLOOP-2;
          if (minq<p+1+TURN) minq = p+1+TURN;
          for (q = minq; q < j; q++) {
            type_2 = ptype[indx[q]+p];

            if (type_2==0) continue;
            type_2 = rtype[type_2];

            energy = E_IntLoop(p-i-1, j-q-1, type, type_2,
                                S1[i+1], S1[j-1], S1[p-1], S1[q+1], P);

            new_c = MIN2(energy+c[indx[q]+p], new_c);
            if ((p==i+1)&&(j==q+1)) stackEnergy = energy; /* remember stack energy */

          } /* end q-loop */
        } /* end p-loop */
        /* multi-loop decomposition ------------------------*/
        int MLenergy;
        decomp = DMLi1[j-1];
        tt = rtype[type];
        decomp += E_MLstem(tt, S1[j-1], S1[i+1], P);
        MLenergy = decomp + P->p0.MLclosing;
        new_c = MIN2(new_c, MLenergy);

        new_c = MIN2(new_c, cc1[j-1]+stackEnergy);
        cc[j] = new_c + bonus;
        c[ij] = cc1[j-1]+stackEnergy+bonus;
      } /* end >> if (pair) << */

      else c[ij] = INF;

      /* done with c[i,j], now compute fML[i,j] */
      /* (i,j) + MLstem ? */
      new_fML = INF;
      if(type){
        new_fML = c[ij];
        new_fML += E_MLstem(type, (i==1) ? S1[length] : S1[i-1], S1[j+1], P);
      }

      /* free ends ? -----------------------------------------*/
      /*  we must not just extend 3'/5' end by unpaired nucleotides if
      *   dangle_model == 1, this could lead to d5+d3 contributions were
      *   mismatch must be taken!
      */
      new_fML = MIN2(new_fML, fML[ij+1]+P->p0.MLbase);
      new_fML = MIN2(fML[indx[j-1]+i]+P->p0.MLbase, new_fML);

      /* modular decomposition -------------------------------*/
        for (decomp = INF, k = i + 1 + TURN; k <= j - 2 - TURN; k++)
          decomp = MIN2(decomp, Fmi[k]+fML[indx[j]+k+1]);
        DMLi[j] = decomp;               /* store for use in ML decompositon */
        new_fML = MIN2(new_fML,decomp);
      /* coaxial stacking */
      fML[ij] = Fmi[j] = new_fML;     /* substring energy */
    }

    {
      int *FF; /* rotate the auxilliary arrays */
      FF = DMLi2; DMLi2 = DMLi1; DMLi1 = DMLi; DMLi = FF;
      FF = cc1; cc1=cc; cc=FF;
      for (j=1; j<=length; j++) {cc[j]=Fmi[j]=DMLi[j]=INF; }
    }
  }

  /* calculate energies of 5' and 3' fragments */
  f5[TURN+1]= 0;
  /* duplicated code may be faster than conditions inside loop ;) */
  /* always use dangles on both sides */
  for(j=TURN+2; j<length; j++){
    f5[j] = f5[j-1];
    for (i=j-TURN-1; i>1; i--){
      type = ptype[indx[j]+i];
      if(!type) continue;
      en = c[indx[j]+i];
      f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, S1[i-1], S1[j+1], P));
    }
    type=ptype[indx[j]+1];
    if(!type) continue;
    en = c[indx[j]+1];
    f5[j] = MIN2(f5[j], en + E_ExtLoop(type, -1, S1[j+1], P));
  }
  f5[length] = f5[length-1];
  for (i=length-TURN-1; i>1; i--){
    type = ptype[indx[length]+i];
    if(!type) continue;
    en = c[indx[length]+i];
    f5[length] = MIN2(f5[length], f5[i-1] + en + E_ExtLoop(type, S1[i-1], -1, P));
  }
  type=ptype[indx[length]+1];
  if(type) {
    en = c[indx[length]+1];
    f5[length] = MIN2(f5[length], en + E_ExtLoop(type, -1, -1, P));
  }
  return f5[length];
}

/**
*** trace back through the "c", "f5" and "fML" arrays to get the
*** base pairing list. No search for equivalent structures is done.
*** This is fast, since only few structure elements are recalculated.
***
*** normally s=0.
*** If s>0 then s items have been already pushed onto the sector stack
**/
PRIVATE void backtrack(const char *string) {
  int   i, j, ij, k, mm3, length, energy, en, new;
  int   no_close, type, type_2, tt;
  int   bonus;
  int   b=0;
  int   s=0;

  #define PUSH(I,J,ML) { sector[++s].i = (I); sector[s].j = (J); sector[s].ml = (ML); }
  #define PAIR2(I,J) { base_pair2[++b].i = (I); base_pair2[b].j = (J); }

  length = strlen(string);
  if (s==0) PUSH(1,length,0)
  while (s>0) {
    int ml, fij, fi, cij=0, traced, i1, j1, p, q, jj=0;
    int canonical = 1;     /* (i,j) closes a canonical structure */
    i  = sector[s].i;
    j  = sector[s].j;
    ml = sector[s--].ml;   /* ml is a flag indicating if backtracking is to
                              occur in the fML- (1) or in the f-array (0) */
    if (ml==2) {
      PAIR2(i,j)
      goto repeat1;
    }

    if (j < i+TURN+1) continue; /* no more pairs in this interval */
    fij = (ml == 1)? fML[indx[j]+i] : f5[j];
    fi  = (ml == 1)?(fML[indx[j-1]+i]+P->p0.MLbase): f5[j-1];

    if (fij == fi) {  /* 3' end is unpaired */
      PUSH(i,j-1,ml)
      continue;
    }

    if (ml == 0) { /* backtrack in f5 */
    mm3 = (j<length) ? S1[j+1] : -1;
    for(k=j-TURN-1,traced=0; k>=1; k--){
      type = ptype[indx[j]+k];
      if(type)
        if(fij == E_ExtLoop(type, (k>1) ? S1[k-1] : -1, mm3, P) + c[indx[j]+k] + f5[k-1]) {
          traced=j; jj = k-1;
          break;
        }
    }

      if (!traced){ fprintf(stderr, "%s\n", string); nrerror("backtrack failed in f5"); }
      PUSH(1,jj,ml);

      i=k; j=traced;
      PAIR2(i,j)
      goto repeat1;
    } else { /* trace back in fML array */
      if (fML[indx[j]+i+1]+P->p0.MLbase == fij) { /* 5' end is unpaired */
        PUSH(i+1,j,ml);
        continue;
      }
      ij  = indx[j]+i;
      tt  = ptype[ij];
      en  = c[ij];
      if(fij == en + E_MLstem(tt, S1[i-1], S1[j+1], P)) {
        PAIR2(i,j)
        goto repeat1;
      }
      for(k = i + 1 + TURN; k <= j - 2 - TURN; k++)
        if(fij == (fML[indx[k]+i]+fML[indx[j]+k+1])) break;
      PUSH(i,k,ml);
      PUSH(k+1,j,ml);

      if (k>j-2-TURN) nrerror("backtrack failed in fML");
      continue;
    }

  repeat1:
    /*----- begin of "repeat:" -----*/
    ij = indx[j]+i;
    if (canonical)  cij = c[ij];

    type = ptype[ij];

    bonus = 0;
      if (cij == c[ij]){
        /* (i.j) closes canonical structures, thus
           (i+1.j-1) must be a pair                */
        type_2 = ptype[indx[j-1]+i+1]; type_2 = rtype[type_2];
        cij -= P->p0.stack[type][type_2] + bonus;
        PAIR2(i+1,j-1)
        i++; j--;
        canonical=0;
        goto repeat1;
      }
    canonical = 1;

    no_close = 0;
    if (no_close) { if (cij == FORBIDDEN) continue; }
    else if (cij == E_Hairpin(j-i-1, type, S1[i+1], S1[j-1],string+i-1, P)+bonus) continue;

    for (p = i+1; p <= MIN2(j-2-TURN,i+MAXLOOP+1); p++) {
      int minq;
      minq = j-i+p-MAXLOOP-2;
      if (minq<p+1+TURN) minq = p+1+TURN;
      for (q = j-1; q >= minq; q--) {

        type_2 = ptype[indx[q]+p];
        if (type_2==0) continue;
        type_2 = rtype[type_2];

        /* energy = oldLoopEnergy(i, j, p, q, type, type_2); */
        energy = E_IntLoop(p-i-1, j-q-1, type, type_2, S1[i+1], S1[j-1], S1[p-1], S1[q+1], P);

        new = energy+c[indx[q]+p]+bonus;
        traced = (cij == new);
        if (traced) {
          PAIR2(p,q)
          i = p, j = q;
          goto repeat1;
        }
      }
    }

    /* end of repeat: --------------------------------------------------*/

    /* (i.j) must close a multi-loop */
    tt = rtype[type];
    i1 = i+1; j1 = j-1;

    en = cij - E_MLstem(tt, S1[j-1], S1[i+1], P) - P->p0.MLclosing - bonus;
    for(k = i+2+TURN; k < j-2-TURN; k++){
      if(en == fML[indx[k]+i+1] + fML[indx[j-1]+k+1]) break;
    }

    if (k<=j-3-TURN) { /* found the decomposition */
      PUSH(i1,k,1)
      PUSH(k+1,j,1)
    } else {
      fprintf(stderr, "%s\n", string);
      nrerror("backtracking failed in repeat");
    }
  }

  base_pair2[0].i = b;    /* save the total number of base pairs */
}
