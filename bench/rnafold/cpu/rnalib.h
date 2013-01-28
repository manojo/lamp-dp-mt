/* ---------------------------------------------------------------------------
rnalib.h
RNA energy library, based on Haskell implementation by Jens Reeder
Author: Peter Steffen
$Date: 2006/04/18 08:40:55 $
--------------------------------------------------------------------------- */

#ifndef rnalib_h
#define rnalib_h

#include "adplib.h"

// alphabet size (A,C,G,U,N)
#define ASIZE 5
#define inp(I) z[I]

/* basepair and stackpair predicates */
char canPair[ASIZE][ASIZE];
#define basepairing(I,J)  ((I+1 < J) && canPair[inp((I)+1)][inp(J)])
char canStackPair[ASIZE][ASIZE][ASIZE][ASIZE];
#define stackpairing(I,J) ((I+3 < J) && canPair[inp((I)+1)][inp(J)] && canPair[inp((I)+2)][inp((J)-1)])

/* alternative definition of basepair, working on characters */
char basepair(int i, int j);

/* Constants     */
/* ------------- */

#define const_e    (2.718281828459)
#define mean_scale (1.34855)

/* Energy tables          */
/* ---------------------- */

int stack_dg          [ASIZE][ASIZE][ASIZE][ASIZE];
int *hl_ent_ar;
int tstackh_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
int hl_tetra          [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
int *bl_ent_ar;
int *il_ent_ar;
int tstacki_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
int dr_dangle_dg      [ASIZE][ASIZE][ASIZE+1];
int dl_dangle_dg      [ASIZE+1][ASIZE][ASIZE];
int termaupenalty_ar  [ASIZE][ASIZE];

int intloop11      [ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1];
int intloop21      [ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1];
int intloop22      [ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1][ASIZE+1];
double *scale_ar;

/* Energy Functions                          */
/* ----------------------------------------- */

#define stack_dg_ac(I,J,K,L) stack_dg[inp(I)][inp(J)][inp(K)][inp(L)]
#define sr_energy(I,J) stack_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]

#define hl_ent(size) hl_ent_ar[size]
#define hl_stack(I,J) tstackh_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]

int hl_energy(int i, int j);
#define bl_ent(size) bl_ent_ar[size]

int bl_energy(int bl, int i, int j, int br);
int br_energy(int bl, int i, int j, int br);
#define il_ent(size) il_ent_ar[size]

#define il_stack(I,J,K,L) (tstacki_dg[inp((I))][inp((I)+1)][inp((L))][inp((L)+1)] + \
                           tstacki_dg[inp((J)+1)][inp((J))][inp((K)+1)][inp((K))])

int il_energy(int i, int j, int k, int l);

/* XXX real fix in adpc? */
#define UNDEF 1000000
#define dr_energy(I,J)  (I<1 || J+1 > n ? UNDEF :  dr_dangle_dg[inp((I))][inp((J))][inp((J)+1)] )
#define dli_energy(I,J) dr_dangle_dg[inp((J))][inp((I))][inp((I)+1)]

#define dl_energy(I,J)  (I < 2 ? UNDEF : dl_dangle_dg[inp((I)-1)][inp((I))][inp((J))])

#define dri_energy(I,J) dl_dangle_dg[inp((J)-1)][inp((J))][inp((I))]

#define ss_energy(I,J) 0

#define dangles(i,j,i2,j2,k,l,k2,l2) ((dli_energy(j,k+1) + dri_energy(j2,k2+1)))
#define sspenalty(a) (npp * (a))

#define termaupenalty(I,J) (I < 1 ? UNDEF : termaupenalty_ar[inp(I)][inp(J)] )

#define mk_pf(X) (exp ((X)/ (-61.6321)))
#define scale(size) scale_ar[size]

/* initializations */
void rnalib_init(toptions *opts, tsequence *seq);
void rnalib_free();

#endif
