/* ---------------------------------------------------------------------------
rnalib.c
RNA energy library, based on Haskell implementation by Jens Reeder
Author: Peter Steffen
$Date: 2006/04/18 08:40:51 $
--------------------------------------------------------------------------- */

#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

#include "options.h"
#include <adplib.h>
#include <rnalib.h>

/* ---------------------------------------------------------------------------------------------------- */
/* input handling                                                                                       */
/* ---------------------------------------------------------------------------------------------------- */

/* The alphabet */
#define A 0
#define C 1
#define G 2
#define U 3
#define N 4

static int   n;
static char *z;

/* initialize basepair predicate */
static void init_canPair(){
  int i,j;
  for (i=0;i<ASIZE;i++)
    for(j=0;j<ASIZE;j++)
      canPair[i][j]=0;

  canPair [A][U] = 1;
  canPair [U][A] = 1;
  canPair [C][G] = 1;
  canPair [G][C] = 1;
  canPair [G][U] = 1;
  canPair [U][G] = 1;
}


/* initialize stackpair predicate */
static void init_canStackPair(){
  int i,j,k,l;
  for (i=0;i<ASIZE;i++)
    for(j=0;j<ASIZE;j++)
      for (k=0;k<ASIZE;k++)
        for(l=0;l<ASIZE;l++)
          canStackPair[i][j][k][l]=canPair[i][j] && canPair[k][l] ;
}

/* alternative definition of basepair, working on characters */
char basepair(int i, int j){
  return(((z[i] == 'a') && (z[j] == 'u')) ||
         ((z[i] == 'u') && (z[j] == 'a')) ||
         ((z[i] == 'c') && (z[j] == 'g')) ||
         ((z[i] == 'g') && (z[j] == 'c')) ||
         ((z[i] == 'g') && (z[j] == 'u')) ||
         ((z[i] == 'u') && (z[j] == 'g')));
}

/* ---------------------------------------------------------------------------------------------------- */
/* Energy stuff                                                                                         */
/* ---------------------------------------------------------------------------------------------------- */

/* subword length */
#define size_of(I,J) ((J)-(I))

/* Some constants and utilities */
/* ---------------------------- */

/* The Jacobson-Stockmayer term for loop interpolation. */
#define jacobson_stockmayer(size) (107.856*log((size)/30.0))

#define UNDEF 1000000

/* ---------------------------------------------------------------------------------------------------- */
/* Stacking Region Energies                                                                             */
/* ---------------------------------------------------------------------------------------------------- */
/*
   Stabilizing energies for canonical basepairs: AU, CG, GU
   Basepairing: Parameters are in 5' 3' order.
   stack_dg a b c d
            ^ ^ ^ ^
            | |_| |
            |_____|
*/

static void init_stack_dg()
{
  int i,j,k,l;
  /* report errors by unrealistic values: */
  for(i=0;i<ASIZE;i++) for(j=0;j<ASIZE;j++) for(k=0;k<ASIZE;k++) for(l=0;l<ASIZE;l++) stack_dg[i][j][k][l] = UNDEF;

  stack_dg[C][G][C][G] =  -240 ;
  stack_dg[C][C][G][G] =  -330 ;
  stack_dg[C][U][G][G] =  -210 ;
  stack_dg[C][G][U][G] =  -140 ;
  stack_dg[C][U][A][G] =  -210 ;
  stack_dg[C][A][U][G] =  -210 ;
  stack_dg[G][G][C][C] =  -330 ;
  stack_dg[G][C][G][C] =  -340 ;
  stack_dg[G][U][G][C] =  -250 ;
  stack_dg[G][G][U][C] =  -150 ;
  stack_dg[G][U][A][C] =  -220 ;
  stack_dg[G][A][U][C] =  -240 ;
  stack_dg[G][G][C][U] =  -210 ;
  stack_dg[G][C][G][U] =  -250 ;
  stack_dg[G][U][G][U] =   130 ;
  stack_dg[G][G][U][U] =   -50 ;
  stack_dg[G][U][A][U] =  -140 ;
  stack_dg[G][A][U][U] =  -130 ;
  stack_dg[U][G][C][G] =  -140 ;
  stack_dg[U][C][G][G] =  -150 ;
  stack_dg[U][U][G][G] =   -50 ;
  stack_dg[U][G][U][G] =    30 ;
  stack_dg[U][U][A][G] =   -60 ;
  stack_dg[U][A][U][G] =  -100 ;
  stack_dg[A][G][C][U] =  -210 ;
  stack_dg[A][C][G][U] =  -220 ;
  stack_dg[A][U][G][U] =  -140 ;
  stack_dg[A][G][U][U] =   -60 ;
  stack_dg[A][U][A][U] =  -110 ;
  stack_dg[A][A][U][U] =   -90 ;
  stack_dg[U][G][C][A] =  -210 ;
  stack_dg[U][C][G][A] =  -240 ;
  stack_dg[U][U][G][A] =  -130 ;
  stack_dg[U][G][U][A] =  -100 ;
  stack_dg[U][U][A][A] =   -90 ;
  stack_dg[U][A][U][A] =  -130 ;
}

#define stack_dg_ac(I,J,K,L) stack_dg[inp(I)][inp(J)][inp(K)][inp(L)]
#define sr_energy(I,J) stack_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]

/* ---------------------------------------------------------------------------------------------------- */
/* Hairpin Loop Energies                                                                                */
/* ---------------------------------------------------------------------------------------------------- */

static void init_hl_ent_ar()
{
  int i;
  hl_ent_ar=(int *) mcalloc(max(31,n+1), sizeof(int));

  /* report errors by unrealistic values: */
  hl_ent_ar[0] = UNDEF;
  hl_ent_ar[1] = UNDEF;
  hl_ent_ar[2] = UNDEF;

  hl_ent_ar[3] = 570 ;
  hl_ent_ar[4] = 560 ;
  hl_ent_ar[5] = 560 ;
  hl_ent_ar[6] = 540 ;
  hl_ent_ar[7] = 590 ;
  hl_ent_ar[8] = 560 ;
  hl_ent_ar[9] = 640 ;
  hl_ent_ar[10] = 650 ;
  hl_ent_ar[11] = 660 ;
  hl_ent_ar[12] = 670 ;
  hl_ent_ar[13] = 678 ;
  hl_ent_ar[14] = 686 ;
  hl_ent_ar[15] = 694 ;
  hl_ent_ar[16] = 701 ;
  hl_ent_ar[17] = 707 ;
  hl_ent_ar[18] = 713 ;
  hl_ent_ar[19] = 719 ;
  hl_ent_ar[20] = 725 ;
  hl_ent_ar[21] = 730 ;
  hl_ent_ar[22] = 735 ;
  hl_ent_ar[23] = 740 ;
  hl_ent_ar[24] = 744 ;
  hl_ent_ar[25] = 749 ;
  hl_ent_ar[26] = 753 ;
  hl_ent_ar[27] = 757 ;
  hl_ent_ar[28] = 761 ;
  hl_ent_ar[29] = 765 ;
  hl_ent_ar[30] = 769 ;

  for (i=31;i<=n;i++) hl_ent_ar[i] = hl_ent_ar[30] + jacobson_stockmayer(i);
}

#define hl_ent(size) hl_ent_ar[size]

/* Stacking Interaction           */
/* ------------------------------ */

static void init_tstackh_dg()
{
  int i,j,k,l;
  /* set to maximal value: */
  for(i=0;i<ASIZE;i++) for(j=0;j<ASIZE;j++) for(k=0;k<ASIZE;k++) for(l=0;l<ASIZE;l++) tstackh_dg[i][j][k][l] = 0;

  for(i=0;i<ASIZE-1;i++) tstackh_dg[C][i][N][G] = -90;
  tstackh_dg[C][N][N][G] = 0;
  for(i=0;i<ASIZE-1;i++) tstackh_dg[G][i][N][C] = -70;
  tstackh_dg[G][N][N][C] = 0;

  tstackh_dg[C][A][A][G] = -150 ;
  tstackh_dg[C][A][C][G] = -150 ;
  tstackh_dg[C][A][G][G] = -140 ;
  tstackh_dg[C][A][U][G] = -180 ;
  tstackh_dg[C][C][A][G] = -100 ;
  tstackh_dg[C][C][C][G] =  -90 ;
  tstackh_dg[C][C][G][G] = -290 ;
  tstackh_dg[C][C][U][G] =  -80 ;
  tstackh_dg[C][G][A][G] = -220 ;
  tstackh_dg[C][G][C][G] = -200 ;
  tstackh_dg[C][G][G][G] = -160 ;
  tstackh_dg[C][G][U][G] = -110 ;
  tstackh_dg[C][U][A][G] = -170 ;
  tstackh_dg[C][U][C][G] = -140 ;
  tstackh_dg[C][U][G][G] = -180 ;
  tstackh_dg[C][U][U][G] = -200 ;
  tstackh_dg[G][A][A][C] = -110 ;
  tstackh_dg[G][A][C][C] = -150 ;
  tstackh_dg[G][A][G][C] = -130 ;
  tstackh_dg[G][A][U][C] = -210 ;
  tstackh_dg[G][C][A][C] = -110 ;
  tstackh_dg[G][C][C][C] =  -70 ;
  tstackh_dg[G][C][G][C] = -240 ;
  tstackh_dg[G][C][U][C] =  -50 ;
  tstackh_dg[G][G][A][C] = -240 ;
  tstackh_dg[G][G][C][C] = -290 ;
  tstackh_dg[G][G][G][C] = -140 ;
  tstackh_dg[G][G][U][C] = -120 ;
  tstackh_dg[G][U][A][C] = -190 ;
  tstackh_dg[G][U][C][C] = -100 ;
  tstackh_dg[G][U][G][C] = -220 ;
  tstackh_dg[G][U][U][C] = -150 ;
  tstackh_dg[G][A][A][U] =   20 ;
  tstackh_dg[G][A][C][U] =  -50 ;
  tstackh_dg[G][A][G][U] =  -30 ;
  tstackh_dg[G][A][U][U] =  -30 ;
  tstackh_dg[G][C][A][U] =  -10 ;
  tstackh_dg[G][C][C][U] =  -20 ;
  tstackh_dg[G][C][G][U] = -150 ;
  tstackh_dg[G][C][U][U] =  -20 ;
  tstackh_dg[G][G][A][U] =  -90 ;
  tstackh_dg[G][G][C][U] = -110 ;
  tstackh_dg[G][G][G][U] =  -30 ;
  tstackh_dg[G][G][U][U] =    0 ;
  tstackh_dg[G][U][A][U] =  -30 ;
  tstackh_dg[G][U][C][U] =  -30 ;
  tstackh_dg[G][U][G][U] =  -40 ;
  tstackh_dg[G][U][U][U] = -110 ;
  tstackh_dg[U][A][A][G] =  -50 ;
  tstackh_dg[U][A][C][G] =  -30 ;
  tstackh_dg[U][A][G][G] =  -60 ;
  tstackh_dg[U][A][U][G] =  -50 ;
  tstackh_dg[U][C][A][G] =  -20 ;
  tstackh_dg[U][C][C][G] =  -10 ;
  tstackh_dg[U][C][G][G] = -170 ;
  tstackh_dg[U][C][U][G] =    0 ;
  tstackh_dg[U][G][A][G] =  -80 ;
  tstackh_dg[U][G][C][G] = -120 ;
  tstackh_dg[U][G][G][G] =  -30 ;
  tstackh_dg[U][G][U][G] =  -70 ;
  tstackh_dg[U][U][A][G] =  -60 ;
  tstackh_dg[U][U][C][G] =  -10 ;
  tstackh_dg[U][U][G][G] =  -60 ;
  tstackh_dg[U][U][U][G] =  -80 ;
  tstackh_dg[A][A][A][U] =  -30 ;
  tstackh_dg[A][A][C][U] =  -50 ;
  tstackh_dg[A][A][G][U] =  -30 ;
  tstackh_dg[A][A][U][U] =  -30 ;
  tstackh_dg[A][C][A][U] =  -10 ;
  tstackh_dg[A][C][C][U] =  -20 ;
  tstackh_dg[A][C][G][U] = -150 ;
  tstackh_dg[A][C][U][U] =  -20 ;
  tstackh_dg[A][G][A][U] = -110 ;
  tstackh_dg[A][G][C][U] = -120 ;
  tstackh_dg[A][G][G][U] =  -20 ;
  tstackh_dg[A][G][U][U] =   20 ;
  tstackh_dg[A][U][A][U] =  -30 ;
  tstackh_dg[A][U][C][U] =  -30 ;
  tstackh_dg[A][U][G][U] =  -60 ;
  tstackh_dg[A][U][U][U] = -110 ;
  tstackh_dg[U][A][A][A] =  -50 ;
  tstackh_dg[U][A][C][A] =  -30 ;
  tstackh_dg[U][A][G][A] =  -60 ;
  tstackh_dg[U][A][U][A] =  -50 ;
  tstackh_dg[U][C][A][A] =  -20 ;
  tstackh_dg[U][C][C][A] =  -10 ;
  tstackh_dg[U][C][G][A] = -120 ;
  tstackh_dg[U][C][U][A] =    0 ;
  tstackh_dg[U][G][A][A] = -140 ;
  tstackh_dg[U][G][C][A] = -120 ;
  tstackh_dg[U][G][G][A] =  -70 ;
  tstackh_dg[U][G][U][A] =  -20 ;
  tstackh_dg[U][U][A][A] =  -30 ;
  tstackh_dg[U][U][C][A] =  -10 ;
  tstackh_dg[U][U][G][A] =  -50 ;
  tstackh_dg[U][U][U][A] =  -80 ;
}

#define hl_stack(I,J) tstackh_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]

/* Tetraloop Bonus Energies       */
/* ------------------------------ */
/*  Ultrastable tetra-loops & energy bonus at 37 C: */

static void init_hl_tetra()
{
  int k1,k2,k3,k4,k5,k6;

  for (k1=0;k1<ASIZE;k1++)
    for (k2=0;k2<ASIZE;k2++)
      for (k3=0;k3<ASIZE;k3++)
         for (k4=0;k4<ASIZE;k4++)
            for (k5=0;k5<ASIZE;k5++)
               for (k6=0;k6<ASIZE;k6++)
                  hl_tetra[k1][k2][k3][k4][k5][k6]=0;

  hl_tetra[G][G][G][G][A][C] = -300 ;
  hl_tetra[G][G][U][G][A][C] = -300 ;
  hl_tetra[C][G][A][A][A][G] = -300 ;
  hl_tetra[G][G][A][G][A][C] = -300 ;
  hl_tetra[C][G][C][A][A][G] = -300 ;
  hl_tetra[G][G][A][A][A][C] = -300 ;
  hl_tetra[C][G][G][A][A][G] = -300 ;
  hl_tetra[C][U][U][C][G][G] = -300 ;
  hl_tetra[C][G][U][G][A][G] = -300 ;
  hl_tetra[C][G][A][A][G][G] = -250 ;
  hl_tetra[C][U][A][C][G][G] = -250 ;
  hl_tetra[G][G][C][A][A][C] = -250 ;
  hl_tetra[C][G][C][G][A][G] = -250 ;
  hl_tetra[U][G][A][G][A][G] = -250 ;
  hl_tetra[C][G][A][G][A][G] = -200 ;
  hl_tetra[A][G][A][A][A][U] = -200 ;
  hl_tetra[C][G][U][A][A][G] = -200 ;
  hl_tetra[C][U][A][A][C][G] = -200 ;
  hl_tetra[U][G][A][A][A][G] = -200 ;
  hl_tetra[G][G][A][A][G][C] = -150 ;
  hl_tetra[G][G][G][A][A][C] = -150 ;
  hl_tetra[U][G][A][A][A][A] = -150 ;
  hl_tetra[A][G][C][A][A][U] = -150 ;
  hl_tetra[A][G][U][A][A][U] = -150 ;
  hl_tetra[C][G][G][G][A][G] = -150 ;
  hl_tetra[A][G][U][G][A][U] = -150 ;
  hl_tetra[G][G][C][G][A][C] = -150 ;
  hl_tetra[G][G][G][A][G][C] = -150 ;
  hl_tetra[G][U][G][A][A][C] = -150 ;
  hl_tetra[U][G][G][A][A][A] = -150 ;
}

/* Terminal AU penalty is included in hl_stack,  */
/* therefore it must be added explicitely only for (size == 3) */

int hl_energy(int i, int j){
  int size;
  int entropy;
  int tetra_bonus, stack_mismatch;
  int termaupen;

  size           = j-i-1;
  entropy        = hl_ent(size);
  stack_mismatch = hl_stack(i,j);
  /* XXX real fix in adpc? */
  if (i+5 > n)
    tetra_bonus = UNDEF;
  else
    tetra_bonus    = hl_tetra[inp(i)][inp(i+1)][inp(i+2)][inp(i+3)][inp(i+4)][inp(i+5)];
  termaupen      = termaupenalty_ar[inp(i)][inp(j)];

  if (size==3) return(entropy + termaupen);
  if (size==4) return(entropy + stack_mismatch + tetra_bonus);
  if (size>4)  return(entropy + stack_mismatch);
  printf("hairpin loop < 3 found. Please use production\n");
  printf("  hl <<< lbase -~~ (region `with` minsize 3)  ~~- lbase\n");
  printf("in your grammar.\n");
  exit(1);
}


/* ---------------------------------------------------------------------------------------------------- */
/* Bulge Loop Energies                                                                                  */
/* ---------------------------------------------------------------------------------------------------- */

static void init_bl_ent_ar()
{
  int i;
  bl_ent_ar=(int *) mcalloc(max(31,n+1), sizeof(int));

  /* report errors by unrealistic values: */
  bl_ent_ar[0] = UNDEF;

  bl_ent_ar[1] = 380 ;
  bl_ent_ar[2] = 280 ;
  bl_ent_ar[3] = 320 ;
  bl_ent_ar[4] = 360 ;
  bl_ent_ar[5] = 400 ;
  bl_ent_ar[6] = 440 ;
  bl_ent_ar[7] = 459 ;
  bl_ent_ar[8] = 470 ;
  bl_ent_ar[9] = 480 ;
  bl_ent_ar[10] = 490 ;
  bl_ent_ar[11] = 500 ;
  bl_ent_ar[12] = 510 ;
  bl_ent_ar[13] = 519 ;
  bl_ent_ar[14] = 527 ;
  bl_ent_ar[15] = 534 ;
  bl_ent_ar[16] = 541 ;
  bl_ent_ar[17] = 548 ;
  bl_ent_ar[18] = 554 ;
  bl_ent_ar[19] = 560 ;
  bl_ent_ar[20] = 565 ;
  bl_ent_ar[21] = 571 ;
  bl_ent_ar[22] = 576 ;
  bl_ent_ar[23] = 580 ;
  bl_ent_ar[24] = 585 ;
  bl_ent_ar[25] = 589 ;
  bl_ent_ar[26] = 594 ;
  bl_ent_ar[27] = 598 ;
  bl_ent_ar[28] = 602 ;
  bl_ent_ar[29] = 605 ;
  bl_ent_ar[30] = 609 ;

  for (i=31;i<=n;i++) bl_ent_ar[i] = bl_ent_ar[30] + jacobson_stockmayer(i);
}

#define bl_ent(size) bl_ent_ar[size]

/* Bulge Loop Left                */
/* ------------------------------ */
/*
      											  .        .
      											  .        .
										       (bl+3) - (br-2)
 If size == 1 the terminal aupenalty for the stem starting after the bulge (that is    (bl+2) - (br-1))
										    bl+1
										          bl  -   br

 is added possibly. This is unwanted. Since we do not have a chance to check the size of the bulge when parsing the stem
 we substract the possible penalty here!
*/

int bl_energy(int bl, int i, int j, int br){
  int stacking, size, entropy;

  if (br < 2 || bl < 1)
    return UNDEF;

  stacking    = stack_dg[inp(bl)][inp(j+1)][inp(br-1)][inp(br)];
  size        = size_of(i,j);
  entropy     = bl_ent(size);

  if     (size==1)  return(stacking + entropy - termaupenalty_ar[inp(bl+2)][inp(br-1)]);
  else if (size>1)  return(entropy + termaupenalty_ar[inp(bl)][inp(br)]);
  else {printf("bl_energy size < 1\n"); exit(-1);}
}

/* Bulge Loop Right               */
/* ------------------------------ */

int br_energy(int bl, int i, int j, int br){
  int stacking, size, entropy;

  if (bl < 1)
    return UNDEF;

  stacking    = stack_dg[inp(bl)][inp(bl+1)][inp(i)][inp(br)];
  size        = size_of(i,j);
  entropy     = bl_ent(size);

  if (size==1) return(stacking + entropy - termaupenalty_ar[inp(bl+1)][inp(br-2)]);
  if (size>1)  return(entropy + termaupenalty_ar[inp(bl)][inp(br)]);
}

/* ---------------------------------------------------------------------------------------------------- */
/* Interior Loop Energies                                                                               */
/* ---------------------------------------------------------------------------------------------------- */

/* Entropic Term                  */
/* ------------------------------ */
/*
  DESTABILIZING ENERGIES BY SIZE OF LOOP

  il_ent 1 and 2 undefined in the tables of Mathews et al. since
  special energy values exist
*/


static void init_il_ent_ar()
{
  int i;
  il_ent_ar=(int *) mcalloc(max(31,n+1), sizeof(int));

  /* report errors by unrealistic values: */
  il_ent_ar[ 0] = UNDEF;
  il_ent_ar[ 1] = UNDEF;

  il_ent_ar[2] = 150  ;
  il_ent_ar[3] = 160 ;
  il_ent_ar[4] = 170 ;
  il_ent_ar[5] = 180 ;
  il_ent_ar[6] = 200 ;
  il_ent_ar[7] = 220 ;
  il_ent_ar[8] = 230 ;
  il_ent_ar[9] = 240 ;
  il_ent_ar[10] = 250 ;
  il_ent_ar[11] = 260 ;
  il_ent_ar[12] = 270 ;
  il_ent_ar[13] = 278 ;
  il_ent_ar[14] = 286 ;
  il_ent_ar[15] = 294 ;
  il_ent_ar[16] = 301 ;
  il_ent_ar[17] = 307 ;
  il_ent_ar[18] = 313 ;
  il_ent_ar[19] = 319 ;
  il_ent_ar[20] = 325 ;
  il_ent_ar[21] = 330 ;
  il_ent_ar[22] = 335 ;
  il_ent_ar[23] = 340 ;
  il_ent_ar[24] = 345 ;
  il_ent_ar[25] = 349 ;
  il_ent_ar[26] = 353 ;
  il_ent_ar[27] = 357 ;
  il_ent_ar[28] = 361 ;
  il_ent_ar[29] = 365 ;
  il_ent_ar[30] = 369 ;

  for (i=31;i<=n;i++) il_ent_ar[i] = il_ent_ar[30] + jacobson_stockmayer(i);
}

#define il_ent(size) il_ent_ar[size]


/* Stacking Interaction           */
/* ------------------------------ */
/*

STACKING ENERGIES : TERMINAL MISMATCHES AND BASE-PAIRS.

Stabilizing energies for canonical basepairs: AU, CG, GU
Basepairing: Paramers are in 5' 3' order.
tstacki_dg a b c d
           ^ ^ ^ ^
           | |_| |
           |_____|

*/

static void init_tstacki_dg()
{
  int i,j,k,l;

  /* set to maximal value: */
  for(i=0;i<ASIZE;i++) for(j=0;j<ASIZE;j++) for(k=0;k<ASIZE;k++) for(l=0;l<ASIZE;l++) tstacki_dg[i][j][k][l] = 0;

  tstacki_dg[C][A][A][G] =    0 ;
  tstacki_dg[C][A][C][G] =    0 ;
  tstacki_dg[C][A][G][G] = -110 ;
  tstacki_dg[C][A][U][G] =    0 ;
  tstacki_dg[C][C][A][G] =    0 ;
  tstacki_dg[C][C][C][G] =    0 ;
  tstacki_dg[C][C][G][G] =    0 ;
  tstacki_dg[C][C][U][G] =    0 ;
  tstacki_dg[C][G][A][G] = -110 ;
  tstacki_dg[C][G][C][G] =    0 ;
  tstacki_dg[C][G][G][G] =    0 ;
  tstacki_dg[C][G][U][G] =    0 ;
  tstacki_dg[C][U][A][G] =    0 ;
  tstacki_dg[C][U][C][G] =    0 ;
  tstacki_dg[C][U][G][G] =    0 ;
  tstacki_dg[C][U][U][G] =  -70 ;
  tstacki_dg[G][A][A][C] =    0 ;
  tstacki_dg[G][A][C][C] =    0 ;
  tstacki_dg[G][A][G][C] = -110 ;
  tstacki_dg[G][A][U][C] =    0 ;
  tstacki_dg[G][C][A][C] =    0 ;
  tstacki_dg[G][C][C][C] =    0 ;
  tstacki_dg[G][C][G][C] =    0 ;
  tstacki_dg[G][C][U][C] =    0 ;
  tstacki_dg[G][G][A][C] = -110 ;
  tstacki_dg[G][G][C][C] =    0 ;
  tstacki_dg[G][G][G][C] =    0 ;
  tstacki_dg[G][G][U][C] =    0 ;
  tstacki_dg[G][U][A][C] =    0 ;
  tstacki_dg[G][U][C][C] =    0 ;
  tstacki_dg[G][U][G][C] =    0 ;
  tstacki_dg[G][U][U][C] =  -70 ;
  tstacki_dg[G][A][A][U] =   70 ;
  tstacki_dg[G][A][C][U] =   70 ;
  tstacki_dg[G][A][G][U] =  -40 ;
  tstacki_dg[G][A][U][U] =   70 ;
  tstacki_dg[G][C][A][U] =   70 ;
  tstacki_dg[G][C][C][U] =   70 ;
  tstacki_dg[G][C][G][U] =   70 ;
  tstacki_dg[G][C][U][U] =   70 ;
  tstacki_dg[G][G][A][U] =  -40 ;
  tstacki_dg[G][G][C][U] =   70 ;
  tstacki_dg[G][G][G][U] =   70 ;
  tstacki_dg[G][G][U][U] =   70 ;
  tstacki_dg[G][U][A][U] =   70 ;
  tstacki_dg[G][U][C][U] =   70 ;
  tstacki_dg[G][U][G][U] =   70 ;
  tstacki_dg[G][U][U][U] =    0 ;
  tstacki_dg[U][A][A][G] =   70 ;
  tstacki_dg[U][A][C][G] =   70 ;
  tstacki_dg[U][A][G][G] =  -40 ;
  tstacki_dg[U][A][U][G] =   70 ;
  tstacki_dg[U][C][A][G] =   70 ;
  tstacki_dg[U][C][C][G] =   70 ;
  tstacki_dg[U][C][G][G] =   70 ;
  tstacki_dg[U][C][U][G] =   70 ;
  tstacki_dg[U][G][A][G] =  -40 ;
  tstacki_dg[U][G][C][G] =   70 ;
  tstacki_dg[U][G][G][G] =   70 ;
  tstacki_dg[U][G][U][G] =   70 ;
  tstacki_dg[U][U][A][G] =   70 ;
  tstacki_dg[U][U][C][G] =   70 ;
  tstacki_dg[U][U][G][G] =   70 ;
  tstacki_dg[U][U][U][G] =    0 ;
  tstacki_dg[A][A][A][U] =   70 ;
  tstacki_dg[A][A][C][U] =   70 ;
  tstacki_dg[A][A][G][U] =  -40 ;
  tstacki_dg[A][A][U][U] =   70 ;
  tstacki_dg[A][C][A][U] =   70 ;
  tstacki_dg[A][C][C][U] =   70 ;
  tstacki_dg[A][C][G][U] =   70 ;
  tstacki_dg[A][C][U][U] =   70 ;
  tstacki_dg[A][G][A][U] =  -40 ;
  tstacki_dg[A][G][C][U] =   70 ;
  tstacki_dg[A][G][G][U] =   70 ;
  tstacki_dg[A][G][U][U] =   70 ;
  tstacki_dg[A][U][A][U] =   70 ;
  tstacki_dg[A][U][C][U] =   70 ;
  tstacki_dg[A][U][G][U] =   70 ;
  tstacki_dg[A][U][U][U] =    0 ;
  tstacki_dg[U][A][A][A] =   70 ;
  tstacki_dg[U][A][C][A] =   70 ;
  tstacki_dg[U][A][G][A] =  -40 ;
  tstacki_dg[U][A][U][A] =   70 ;
  tstacki_dg[U][C][A][A] =   70 ;
  tstacki_dg[U][C][C][A] =   70 ;
  tstacki_dg[U][C][G][A] =   70 ;
  tstacki_dg[U][C][U][A] =   70 ;
  tstacki_dg[U][G][A][A] =  -40 ;
  tstacki_dg[U][G][C][A] =   70 ;
  tstacki_dg[U][G][G][A] =   70 ;
  tstacki_dg[U][G][U][A] =   70 ;
  tstacki_dg[U][U][A][A] =   70 ;
  tstacki_dg[U][U][C][A] =   70 ;
  tstacki_dg[U][U][G][A] =   70 ;
  tstacki_dg[U][U][U][A] =    0 ;
}

/*
the time intensive n^4 version of internal loops
(used in reduced form O(n^2*c^2) where c is the maximal internal loop size)

(i,j) = left region, (k,l) = right region

        i --- l+1
 5'    /        \    3'
 |   i+1         l  / \
 |    |          |   |
\ /   |          |   |
 3'   |          |   5'
      j         k+1
       \        /
        j+1 --- k

*/

#define il_stack(I,J,K,L) (tstacki_dg[inp((I))][inp((I)+1)][inp((L))][inp((L)+1)] + \
                           tstacki_dg[inp((J)+1)][inp((J))][inp((K)+1)][inp((K))])


/* Ninio's equation */
#define il_asym(SL,SR) min(300,((abs((SL)-(SR)))*50))

/* include internal loop energies */
#include "intloop11.c"
#include "intloop21.c"
#include "intloop22.c"

int il_energy(int i, int j, int k, int l)
{
  int sl, sr;
  sl = size_of(i,j);
  sr = size_of(k,l);
  if ((sl > 2) || (sr > 2))
    return((il_ent (sl + sr))
         + (il_stack (i,j,k,l))
         + (il_asym(sl,sr))); else
  if ((sl == 1) && (sr == 1)) return(il11_energy(i,l+1)); else
  if ((sl == 1) && (sr == 2)) return(il12_energy(i,l+1)); else
  if ((sl == 2) && (sr == 1)) return(il21_energy(i,l+1)); else
  if ((sl == 2) && (sr == 2)) return(il22_energy(i,l+1)); else
  return 65000;
}


/* ---------------------------------------------------------------------------------------------------- */
/* Dangling ends                                                                                        */
/* ---------------------------------------------------------------------------------------------------- */

/* dangle right                   */
/* ------------------------------ */

static void init_dr_dangle_dg()
{
  int i,j,k;
  /* report errors by unrealistic values: */
  for(i=0;i<ASIZE;i++) for(j=0;j<ASIZE;j++) for(k=0;k<ASIZE+1;k++) dr_dangle_dg[i][j][k] = 0;

  dr_dangle_dg[C][G][A] = -110 ;
  dr_dangle_dg[C][G][C] =  -40 ;
  dr_dangle_dg[C][G][G] = -130 ;
  dr_dangle_dg[C][G][U] =  -60 ;

  dr_dangle_dg[G][C][A] = -170 ;
  dr_dangle_dg[G][C][C] =  -80 ;
  dr_dangle_dg[G][C][G] = -170 ;
  dr_dangle_dg[G][C][U] = -120 ;

  dr_dangle_dg[G][U][A] =  -70 ;
  dr_dangle_dg[G][U][C] =  -10 ;
  dr_dangle_dg[G][U][G] =  -70 ;
  dr_dangle_dg[G][U][U] =  -10 ;

  dr_dangle_dg[U][G][A] =  -80 ;
  dr_dangle_dg[U][G][C] =  -50 ;
  dr_dangle_dg[U][G][G] =  -80 ;
  dr_dangle_dg[U][G][U] =  -60 ;

  dr_dangle_dg[A][U][A] =  -70 ;
  dr_dangle_dg[A][U][C] =  -10 ;
  dr_dangle_dg[A][U][G] =  -70 ;
  dr_dangle_dg[A][U][U] =  -10 ;

  dr_dangle_dg[U][A][A] =  -80 ;
  dr_dangle_dg[U][A][C] =  -50 ;
  dr_dangle_dg[U][A][G] =  -80 ;
  dr_dangle_dg[U][A][U] =  -60 ;
}

#define dli_energy(I,J) dr_dangle_dg[inp((J))][inp((I))][inp((I)+1)]

/* dangle left                    */
/* ------------------------------ */

static void init_dl_dangle_dg()
{
  int i,j,k;
  /* report errors by unrealistic values: */
  for(i=0;i<ASIZE+1;i++) for(j=0;j<ASIZE;j++) for(k=0;k<ASIZE;k++) dl_dangle_dg[i][j][k] = 0;

  dl_dangle_dg[A][C][G] =  -50 ;
  dl_dangle_dg[C][C][G] =  -30 ;
  dl_dangle_dg[G][C][G] =  -20 ;
  dl_dangle_dg[U][C][G] =  -10 ;

  dl_dangle_dg[A][G][C] =  -20 ;
  dl_dangle_dg[C][G][C] =  -30 ;
  dl_dangle_dg[G][G][C] =    0 ;
  dl_dangle_dg[U][G][C] =    0 ;

  dl_dangle_dg[A][G][U] =  -30 ;
  dl_dangle_dg[C][G][U] =  -30 ;
  dl_dangle_dg[G][G][U] =  -40 ;
  dl_dangle_dg[U][G][U] =  -20 ;

  dl_dangle_dg[A][U][G] =  -30 ;
  dl_dangle_dg[C][U][G] =  -10 ;
  dl_dangle_dg[G][U][G] =  -20 ;
  dl_dangle_dg[U][U][G] =  -20 ;

  dl_dangle_dg[A][A][U] =  -30 ;
  dl_dangle_dg[C][A][U] =  -30 ;
  dl_dangle_dg[G][A][U] =  -40 ;
  dl_dangle_dg[U][A][U] =  -20 ;

  dl_dangle_dg[A][U][A] =  -30 ;
  dl_dangle_dg[C][U][A] =  -10 ;
  dl_dangle_dg[G][U][A] =  -20 ;
  dl_dangle_dg[U][U][A] =  -20 ;
}

#define dri_energy(I,J) dl_dangle_dg[inp((J)-1)][inp((J))][inp((I))]


#define ss_energy(I,J) 0


/* ---------------------------------------------------------------------------------------------------- */
/* special pseudoknot energies                                                                          */
/* ---------------------------------------------------------------------------------------------------- */

/* This are the dangling energies for the bases bridging the stacks */

#define dangles(i,j,i2,j2,k,l,k2,l2) ((dli_energy(j,k+1) + dri_energy(j2,k2+1)))
#define sspenalty(a) (npp * (a))

/* ---------------------------------------------------------------------------------------------------- */
/* Terminal AU penalty                                                                                  */
/* ---------------------------------------------------------------------------------------------------- */

static void init_termaupenalty_ar()
{
  int i,j;
  for(i=0;i<ASIZE;i++) for(j=0;j<ASIZE;j++) termaupenalty_ar[i][j] = 0;

  termaupenalty_ar[A][U] = 50 ;
  termaupenalty_ar[U][A] = 50 ;
  termaupenalty_ar[G][U] = 50 ;
  termaupenalty_ar[U][G] = 50 ;
}


/* ---------------------------------------------------------------------------------------------------- */
/* Scale                                                                                                */
/* ---------------------------------------------------------------------------------------------------- */

static void init_scale_ar()
{
  int i;
  scale_ar=(double *) mcalloc(n+2, sizeof(double));
  scale_ar[0] = 1.0;
  for (i = 1; i<= n; i++) scale_ar[i] = scale_ar[i-1] / mean_scale;
}

/* ---------------------------------------------------------------------------------------------------- */
/* Initialize rna input and energy tables                                                                         */
/* ---------------------------------------------------------------------------------------------------- */

void rnalib_init(toptions *opts, tsequence *seq)
{
  /* initialize input and pairing tables */
  z    = seq->seq - 1;
  n    = seq->length;

  convert_input(1, z, n);
  init_canPair();
  init_canStackPair();

  /* initialize energies */
  init_stack_dg();
  init_hl_ent_ar();
  init_tstackh_dg();
  init_hl_tetra();
  init_bl_ent_ar();
  init_il_ent_ar();
  init_tstacki_dg();
  init_dr_dangle_dg();
  init_dl_dangle_dg();
  init_termaupenalty_ar();

  init_intloop11();
  init_intloop21();
  init_intloop22();

  init_scale_ar();


}

void rnalib_free()
{
  free(hl_ent_ar);
  free(bl_ent_ar);
  free(il_ent_ar);
  free(scale_ar);
}
