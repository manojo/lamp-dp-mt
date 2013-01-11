/* Last changed Time-stamp: <2007-12-05 14:05:51 ivo> */
/** \file **/

/*
                  minimum free energy
                  RNA secondary structure prediction

                  c Ivo Hofacker, Chrisoph Flamm
                  original implementation by
                  Walter Fontana

                  Vienna RNA package
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <limits.h>

#include "utils.h"
#include "energy_par.h"
#include "fold_vars.h"
#include "pair_mat.h"
#include "params.h"
#include "loop_energies.h"
#include "fold.h"
#include "data_structures.h"

#define PAREN
#define STACK_BULGE1      1       /* stacking energies for bulges of size 1 */
#define NEW_NINIO         1       /* new asymetry penalty */
#define MAXSECTORS        500     /* dimension for a backtrack array */
#define LOCALITY          0.      /* locality parameter for base-pairs */

#define SAME_STRAND(I,J)  (((I)>=cut_point)||((J)<cut_point))

/*
#################################
# GLOBAL VARIABLES              #
#################################
*/
PUBLIC  int logML     = 0;  /* if nonzero use logarithmic ML energy in energy_of_struct */
PUBLIC  int uniq_ML   = 0;  /* do ML decomposition uniquely (for subopt) */
PUBLIC  int cut_point = -1; /* set to first pos of second seq for cofolding */
PUBLIC  int eos_debug = 0;  /* verbose info from energy_of_struct */

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
PRIVATE int     *f53      = NULL; /* energy of 5' end with 3' nucleotide not available for mismatches */
PRIVATE int     *fML      = NULL; /* multi-loop auxiliary energy array */
PRIVATE int     *fM1      = NULL; /* second ML array, only for subopt */
PRIVATE int     *fM2      = NULL; /* fM2 = multiloop region with exactly two stems, extending to 3' end        */
PRIVATE int     *Fmi      = NULL; /* holds row i of fML (avoids jumps in memory) */
PRIVATE int     *DMLi     = NULL; /* DMLi[j] holds MIN(fML[i,k]+fML[k+1,j])  */
PRIVATE int     *DMLi1    = NULL; /*             MIN(fML[i+1,k]+fML[k+1,j])  */
PRIVATE int     *DMLi2    = NULL; /*             MIN(fML[i+2,k]+fML[k+1,j])  */
PRIVATE int     *DMLi_a   = NULL; /* DMLi_a[j] holds min energy for at least two multiloop stems in [i,j], where j is available for dangling onto a surrounding stem */
PRIVATE int     *DMLi_o   = NULL; /* DMLi_o[j] holds min energy for at least two multiloop stems in [i,j], where j is unavailable for dangling onto a surrounding stem */
PRIVATE int     *DMLi1_a  = NULL;
PRIVATE int     *DMLi1_o  = NULL;
PRIVATE int     *DMLi2_a  = NULL;
PRIVATE int     *DMLi2_o  = NULL;
PRIVATE sect    sector[MAXSECTORS]; /* stack of partial structures for backtracking */
PRIVATE char    *ptype = NULL;      /* precomputed array of pair types */
PRIVATE short   *S = NULL, *S1 = NULL;
PRIVATE paramT  *P          = NULL;
PRIVATE int     init_length = -1;
PRIVATE bondT   *base_pair2         = NULL;

/*
#################################
# PRIVATE FUNCTION DECLARATIONS #
#################################
*/
PRIVATE void  get_arrays(unsigned int size);
PRIVATE void  make_ptypes(const short *S, const char *structure);
PRIVATE void  backtrack(const char *sequence, int s);
PRIVATE int   fill_arrays(const char *sequence);
PRIVATE void  init_fold(int length, paramT *parameters);

/*
#################################
# BEGIN OF FUNCTION DEFINITIONS #
#################################
*/

/* allocate memory for folding process */
PRIVATE void init_fold(int length, paramT *parameters){

  if (length<1) nrerror("initialize_fold: argument must be greater 0");
  free_arrays();
  get_arrays((unsigned) length);
  init_length=length;

  indx = get_indx((unsigned)length);

  update_fold_params_par(parameters);
}

/*--------------------------------------------------------------------------*/

PRIVATE void get_arrays(unsigned int size){
  if(size >= (unsigned int)sqrt((double)INT_MAX))
    nrerror("get_arrays@fold.c: sequence length exceeds addressable range");

  c     = (int *) space(sizeof(int)*((size*(size+1))/2+2));
  fML   = (int *) space(sizeof(int)*((size*(size+1))/2+2));
  if (uniq_ML)
    fM1 = (int *) space(sizeof(int)*((size*(size+1))/2+2));

  ptype = (char *)space(sizeof(char)*((size*(size+1))/2+2));
  f5    = (int *) space(sizeof(int)*(size+2));
  f53   = (int *) space(sizeof(int)*(size+2));
  cc    = (int *) space(sizeof(int)*(size+2));
  cc1   = (int *) space(sizeof(int)*(size+2));
  Fmi   = (int *) space(sizeof(int)*(size+1));
  DMLi  = (int *) space(sizeof(int)*(size+1));
  DMLi1 = (int *) space(sizeof(int)*(size+1));
  DMLi2 = (int *) space(sizeof(int)*(size+1));

  DMLi_a  = (int *) space(sizeof(int)*(size+1));
  DMLi_o  = (int *) space(sizeof(int)*(size+1));
  DMLi1_a = (int *) space(sizeof(int)*(size+1));
  DMLi1_o = (int *) space(sizeof(int)*(size+1));
  DMLi2_a = (int *) space(sizeof(int)*(size+1));
  DMLi2_o = (int *) space(sizeof(int)*(size+1));

  base_pair2 = (bondT *) space(sizeof(bondT)*(1+size/2));
}

/*--------------------------------------------------------------------------*/

PUBLIC void free_arrays(void){
  if(indx)      free(indx);
  if(c)         free(c);
  if(fML)       free(fML);
  if(f5)        free(f5);
  if(f53)       free(f53);
  if(cc)        free(cc);
  if(cc1)       free(cc1);
  if(ptype)     free(ptype);
  if(fM1)       free(fM1);
  if(fM2)       free(fM2);
  if(base_pair2) free(base_pair2);
  if(Fmi)       free(Fmi);
  if(DMLi)      free(DMLi);
  if(DMLi1)     free(DMLi1);
  if(DMLi2)     free(DMLi2);
  if(DMLi_a)    free(DMLi_a);
  if(DMLi_o)    free(DMLi_o);
  if(DMLi1_a)   free(DMLi1_a);
  if(DMLi1_o)   free(DMLi1_o);
  if(DMLi2_a)   free(DMLi2_a);
  if(DMLi2_o)   free(DMLi2_o);
  if(P)         free(P);
  indx = c = fML = f5 = f53 = cc = cc1 = fM1 = fM2 = Fmi = DMLi = DMLi1 = DMLi2 = NULL;
  DMLi_a = DMLi_o = DMLi1_a = DMLi1_o = DMLi2_a = DMLi2_o = NULL;
  ptype       = NULL;
  base_pair2  = NULL;
  P           = NULL;
  init_length = 0;
}

/*--------------------------------------------------------------------------*/


PUBLIC float fold(const char *string, char *structure){
  return fold_par(string, structure, NULL, 0, 0);
}

PUBLIC float fold_par(const char *string,
                      char *structure,
                      paramT *parameters,
                      int is_constrained,
                      int is_circular){

  int length, energy, bonus, bonus_cnt, s;

  bonus               = 0;
  bonus_cnt           = 0;
  s                   = 0;
  length              = (int) strlen(string);

  if (parameters) init_fold(length, parameters);
  else if (length>init_length) init_fold(length, parameters);
  else if (fabs(P->temperature - temperature)>1e-6) update_fold_params();

  S   = encode_sequence(string, 0);
  S1  = encode_sequence(string, 1);

  make_ptypes(S, structure);

  energy = fill_arrays(string);

  backtrack(string, s);

  parenthesis_structure(structure, base_pair2, length);
  /* check constraints */

  if (bonus_cnt>bonus) fprintf(stderr,"\ncould not enforce all constraints\n");
  bonus*=BONUS;

  free(S); free(S1);

  energy += bonus;      /*remove bonus energies from result */

  if (backtrack_type=='C')
    return (float) c[indx[length]+1]/100.;
  else if (backtrack_type=='M')
    return (float) fML[indx[length]+1]/100.;
  else
    return (float) energy/100.;
}

/**
*** fill "c", "fML" and "f5" arrays and return  optimal energy
**/
PRIVATE int fill_arrays(const char *string) {

  int   i, j, k, length, energy, en, mm5, mm3;
  int   decomp, new_fML, max_separation;
  int   no_close, type, type_2, tt;
  int   bonus=0;

  int   dangle_model, noGUclosure;

  dangle_model  = P->model_details.dangles;
  noGUclosure   = P->model_details.noGUclosure;

  length = (int) strlen(string);

  max_separation = (int) ((1.-LOCALITY)*(double)(length-2)); /* not in use */

  for (j=1; j<=length; j++) {
    Fmi[j]=DMLi[j]=DMLi1[j]=DMLi2[j]=INF;
  }

  for (j = 1; j<=length; j++)
    for (i=(j>TURN?(j-TURN):1); i<j; i++) {
      c[indx[j]+i] = fML[indx[j]+i] = INF;
      if (uniq_ML) fM1[indx[j]+i] = INF;
    }

  if (length <= TURN) return 0;

  for (i = length-TURN-1; i >= 1; i--) { /* i,j in [1..length] */

    for (j = i+TURN+1; j <= length; j++) {
      int p, q, ij;
      ij = indx[j]+i;
      bonus = 0;
      type = ptype[ij];
      energy = INF;

      no_close = (((type==3)||(type==4))&&noGUclosure&&(bonus==0));

      if (j-i-1 > max_separation) type = 0;  /* forces locality degree */

      if (type) {   /* we have a pair */
        int new_c=0, stackEnergy=INF;
        /* hairpin ----------------------------------------------*/

        new_c = (no_close) ? FORBIDDEN : E_Hairpin(j-i-1, type, S1[i+1], S1[j-1], string+i-1, P);

        /*--------------------------------------------------------
          check for elementary structures involving more than one
          closing pair.
          --------------------------------------------------------*/

        for (p = i+1; p <= MIN2(j-2-TURN,i+MAXLOOP+1) ; p++) {
          int minq = j-i+p-MAXLOOP-2;
          if (minq<p+1+TURN) minq = p+1+TURN;
          for (q = minq; q < j; q++) {
            type_2 = ptype[indx[q]+p];

            if (type_2==0) continue;
            type_2 = rtype[type_2];

            if (noGUclosure)
              if (no_close||(type_2==3)||(type_2==4))
                if ((p>i+1)||(q<j-1)) continue;  /* continue unless stack */

            energy = E_IntLoop(p-i-1, j-q-1, type, type_2,
                                S1[i+1], S1[j-1], S1[p-1], S1[q+1], P);

            new_c = MIN2(energy+c[indx[q]+p], new_c);
            if ((p==i+1)&&(j==q+1)) stackEnergy = energy; /* remember stack energy */

          } /* end q-loop */
        } /* end p-loop */
        /* multi-loop decomposition ------------------------*/


        if (!no_close) {
          int MLenergy;
          decomp = DMLi1[j-1];
          tt = rtype[type];
          switch(dangle_model){
            /* no dangles */
            case 0:   decomp += E_MLstem(tt, -1, -1, P);
                      break;

            /* double dangles */
            case 2:   decomp += E_MLstem(tt, S1[j-1], S1[i+1], P);
                      break;

            /* normal dangles, aka dangles = 1 || 3 */
            default:  decomp += E_MLstem(tt, -1, -1, P);
                      decomp = MIN2(decomp, DMLi2[j-1] + E_MLstem(tt, -1, S1[i+1], P) + P->MLbase);
                      decomp = MIN2(decomp, DMLi2[j-2] + E_MLstem(tt, S1[j-1], S1[i+1], P) + 2*P->MLbase);
                      decomp = MIN2(decomp, DMLi1[j-2] + E_MLstem(tt, S1[j-1], -1, P) + P->MLbase);
                      break;
          }
          MLenergy = decomp + P->MLclosing;
          new_c = MIN2(new_c, MLenergy);
        }

        /* coaxial stacking of (i.j) with (i+1.k) or (k+1.j-1) */

        if (dangle_model==3) {
          decomp = INF;
          for (k = i+2+TURN; k < j-2-TURN; k++) {
            type_2 = rtype[(unsigned char)ptype[indx[k]+i+1]];
            if (type_2)
              decomp = MIN2(decomp, c[indx[k]+i+1]+P->stack[type][type_2]+fML[indx[j-1]+k+1]);
            type_2 = rtype[(unsigned char)ptype[indx[j-1]+k+1]];
            if (type_2)
              decomp = MIN2(decomp, c[indx[j-1]+k+1]+P->stack[type][type_2]+fML[indx[k]+i+1]);
          }
          /* no TermAU penalty if coax stack */
          decomp += 2*P->MLintern[1] + P->MLclosing;
          new_c = MIN2(new_c, decomp);
        }

        new_c = MIN2(new_c, cc1[j-1]+stackEnergy);
        cc[j] = new_c + bonus;
        if (noLonelyPairs)
          c[ij] = cc1[j-1]+stackEnergy+bonus;
        else
          c[ij] = cc[j];

      } /* end >> if (pair) << */

      else c[ij] = INF;

      /* done with c[i,j], now compute fML[i,j] and fM1[i,j] */

      /* (i,j) + MLstem ? */
      new_fML = INF;
      if(type){
        new_fML = c[ij];
        switch(dangle_model){
          case 2:   new_fML += E_MLstem(type, (i==1) ? S1[length] : S1[i-1], S1[j+1], P);
                    break;
          default:  new_fML += E_MLstem(type, -1, -1, P);
                    break;
        }
      }


      if (uniq_ML){
        fM1[ij] = MIN2(fM1[indx[j-1]+i] + P->MLbase, new_fML);
      }

      /* free ends ? -----------------------------------------*/
      /*  we must not just extend 3'/5' end by unpaired nucleotides if
      *   dangle_model == 1, this could lead to d5+d3 contributions were
      *   mismatch must be taken!
      */
      switch(dangle_model){
        /* no dangles */
        case 0:   new_fML = MIN2(new_fML, fML[ij+1]+P->MLbase);
                  new_fML = MIN2(fML[indx[j-1]+i]+P->MLbase, new_fML);
                  break;
        /* double dangles */
        case 2:   new_fML = MIN2(new_fML, fML[ij+1]+P->MLbase);
                  new_fML = MIN2(fML[indx[j-1]+i]+P->MLbase, new_fML);
                  break;
        /* normal dangles, aka dangle_model = 1 || 3 */
        default:  mm5 = ((i>1)) ? S1[i] : -1;
                  mm3 = ((j<length)) ? S1[j] : -1;
                  new_fML = MIN2(new_fML, fML[ij+1] + P->MLbase);
                  new_fML = MIN2(new_fML, fML[indx[j-1]+i] + P->MLbase);
                  tt = ptype[ij+1];
                  if(tt) new_fML = MIN2(new_fML, c[ij+1] + E_MLstem(tt, mm5, -1, P) + P->MLbase);
                  tt = ptype[indx[j-1]+i];
                  if(tt) new_fML = MIN2(new_fML, c[indx[j-1]+i] + E_MLstem(tt, -1, mm3, P) + P->MLbase);
                  tt = ptype[indx[j-1]+i+1];
                  if(tt) new_fML = MIN2(new_fML, c[indx[j-1]+i+1] + E_MLstem(tt, mm5, mm3, P) + 2*P->MLbase);
                  break;
      }

      /* modular decomposition -------------------------------*/
        for (decomp = INF, k = i + 1 + TURN; k <= j - 2 - TURN; k++)
          decomp = MIN2(decomp, Fmi[k]+fML[indx[j]+k+1]);
        DMLi[j] = decomp;               /* store for use in ML decompositon */
        new_fML = MIN2(new_fML,decomp);
      /* coaxial stacking */
      if (dangle_model==3) {
        /* additional ML decomposition as two coaxially stacked helices */
        for (decomp = INF, k = i+1+TURN; k <= j-2-TURN; k++) {
          type = ptype[indx[k]+i]; type = rtype[type];
          type_2 = ptype[indx[j]+k+1]; type_2 = rtype[type_2];
          if (type && type_2)
            decomp = MIN2(decomp,
                          c[indx[k]+i]+c[indx[j]+k+1]+P->stack[type][type_2]);
        }

        decomp += 2*P->MLintern[1];        /* no TermAU penalty if coax stack */
        new_fML = MIN2(new_fML, decomp);
      }
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
  switch(dangle_model){
    /* dont use dangling end and mismatch contributions at all */
    case 0:   for(j=TURN+2; j<=length; j++){
                f5[j] = f5[j-1];
                for (i=j-TURN-1; i>1; i--){
                  type = ptype[indx[j]+i];
                  if(!type) continue;
                  en = c[indx[j]+i];
                  f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, -1, -1, P));
                }
                type=ptype[indx[j]+1];
                if(!type) continue;
                en = c[indx[j]+1];
                f5[j] = MIN2(f5[j], en + E_ExtLoop(type, -1, -1, P));
              }
              break;

    /* always use dangles on both sides */
    case 2:   for(j=TURN+2; j<length; j++){
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
              if(!type) break;
              en = c[indx[length]+1];
              f5[length] = MIN2(f5[length], en + E_ExtLoop(type, -1, -1, P));
              break;

    /* normal dangles, aka dangle_model = 1 || 3 */
    default:  for(j=TURN+2; j<=length; j++){
                f5[j] = f5[j-1];
                for (i=j-TURN-1; i>1; i--){
                  type = ptype[indx[j]+i];
                  if(type){
                    en = c[indx[j]+i];
                    f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, -1, -1, P));
                    f5[j] = MIN2(f5[j], f5[i-2] + en + E_ExtLoop(type, S1[i-1], -1, P));
                  }
                  type = ptype[indx[j-1]+i];
                  if(type){
                    en = c[indx[j-1]+i];
                    f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, -1, S1[j], P));
                    f5[j] = MIN2(f5[j], f5[i-2] + en + E_ExtLoop(type, S1[i-1], S1[j], P));
                  }
                }
                type = ptype[indx[j]+1];
                if(type) f5[j] = MIN2(f5[j], c[indx[j]+1] + E_ExtLoop(type, -1, -1, P));
                type = ptype[indx[j-1]+1];
                if(type) f5[j] = MIN2(f5[j], c[indx[j-1]+1] + E_ExtLoop(type, -1, S1[j], P));
              }
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
PRIVATE void backtrack(const char *string, int s) {
  int   i, j, ij, k, mm3, length, energy, en, new;
  int   no_close, type, type_2, tt;
  int   bonus;
  int   b=0;
  int   dangle_model = P->model_details.dangles;

  length = strlen(string);
  if (s==0) {
    sector[++s].i = 1;
    sector[s].j = length;
    sector[s].ml = (backtrack_type=='M') ? 1 : ((backtrack_type=='C')? 2: 0);
  }
  while (s>0) {
    int ml, fij, fi, cij, traced, i1, j1, p, q, jj=0;
    int canonical = 1;     /* (i,j) closes a canonical structure */
    i  = sector[s].i;
    j  = sector[s].j;
    ml = sector[s--].ml;   /* ml is a flag indicating if backtracking is to
                              occur in the fML- (1) or in the f-array (0) */
    if (ml==2) {
      base_pair2[++b].i = i;
      base_pair2[b].j   = j;
      goto repeat1;
    }

    if (j < i+TURN+1) continue; /* no more pairs in this interval */

    fij = (ml == 1)? fML[indx[j]+i] : f5[j];
    fi  = (ml == 1)?(fML[indx[j-1]+i]+P->MLbase): f5[j-1];

    if (fij == fi) {  /* 3' end is unpaired */
      sector[++s].i = i;
      sector[s].j   = j-1;
      sector[s].ml  = ml;
      continue;
    }

    if (ml == 0) { /* backtrack in f5 */
      switch(dangle_model){
        case 0:   /* j is paired. Find pairing partner */
                  for(k=j-TURN-1,traced=0; k>=1; k--){
                    type = ptype[indx[j]+k];
                    if(type)
                      if(fij == E_ExtLoop(type, -1, -1, P) + c[indx[j]+k] + f5[k-1]){
                        traced=j; jj = k-1;
                        break;
                      }
                  }
                  break;

        case 2:   mm3 = (j<length) ? S1[j+1] : -1;
                  for(k=j-TURN-1,traced=0; k>=1; k--){
                    type = ptype[indx[j]+k];
                    if(type)
                      if(fij == E_ExtLoop(type, (k>1) ? S1[k-1] : -1, mm3, P) + c[indx[j]+k] + f5[k-1]){
                        traced=j; jj = k-1;
                        break;
                      }
                  }
                  break;
        default:  for(traced = 0, k=j-TURN-1; k>1; k--){
                    type = ptype[indx[j] + k];
                    if(type){
                      en = c[indx[j] + k];
                      if(fij == f5[k-1] + en + E_ExtLoop(type, -1, -1, P)){
                        traced = j;
                        jj = k-1;
                        break;
                      }
                      if(fij == f5[k-2] + en + E_ExtLoop(type, S1[k-1], -1, P)){
                        traced = j;
                        jj = k-2;
                        break;
                      }
                    }
                    type = ptype[indx[j-1] + k];
                    if(type){
                      en = c[indx[j-1] + k];
                      if(fij == f5[k-1] + en + E_ExtLoop(type, -1, S1[j], P)){
                        traced = j-1;
                        jj = k-1;
                        break;
                      }
                      if(fij == f5[k-2] + en + E_ExtLoop(type, S1[k-1], S1[j], P)){
                        traced = j-1;
                        jj = k-2;
                        break;
                      }
                    }
                  }
                  if(!traced){
                    type = ptype[indx[j]+1];
                    if(type){
                      if(fij == c[indx[j]+1] + E_ExtLoop(type, -1, -1, P)){
                        traced = j;
                        jj = 0;
                        break;
                      }
                    }
                    type = ptype[indx[j-1]+1];
                    if(type){
                      if(fij == c[indx[j-1]+1] + E_ExtLoop(type, -1, S1[j], P)){
                        traced = j-1;
                        jj = 0;
                        break;
                      }
                    }
                  }
                  break;
      }

      if (!traced){
        fprintf(stderr, "%s\n", string);
        nrerror("backtrack failed in f5");
      }
      sector[++s].i = 1;
      sector[s].j   = jj;
      sector[s].ml  = ml;

      i=k; j=traced;
      base_pair2[++b].i = i;
      base_pair2[b].j   = j;
      goto repeat1;
    }
    else { /* trace back in fML array */
      if (fML[indx[j]+i+1]+P->MLbase == fij) { /* 5' end is unpaired */
        sector[++s].i = i+1;
        sector[s].j   = j;
        sector[s].ml  = ml;
        continue;
      }

      ij  = indx[j]+i;
      tt  = ptype[ij];
      en  = c[ij];
      switch(dangle_model){
        case 0:   if(fij == en + E_MLstem(tt, -1, -1, P)){
                    base_pair2[++b].i = i;
                    base_pair2[b].j   = j;
                    goto repeat1;
                  }
                  break;

        case 2:   if(fij == en + E_MLstem(tt, S1[i-1], S1[j+1], P)){
                    base_pair2[++b].i = i;
                    base_pair2[b].j   = j;
                    goto repeat1;
                  }
                  break;
        default:  if(fij == en + E_MLstem(tt, -1, -1, P)){
                    base_pair2[++b].i = i;
                    base_pair2[b].j   = j;
                    goto repeat1;
                  }
                  tt = ptype[ij+1];
                  if(fij == c[ij+1] + E_MLstem(tt, S1[i], -1, P) + P->MLbase){
                    base_pair2[++b].i = ++i;
                    base_pair2[b].j   = j;
                    goto repeat1;
                  }
                  tt = ptype[indx[j-1]+i];
                  if(fij == c[indx[j-1]+i] + E_MLstem(tt, -1, S1[j], P) + P->MLbase){
                    base_pair2[++b].i = i;
                    base_pair2[b].j   = --j;
                    goto repeat1;
                  }
                  tt = ptype[indx[j-1]+i+1];
                  if(fij == c[indx[j-1]+i+1] + E_MLstem(tt, S1[i], S1[j], P) + 2*P->MLbase){
                    base_pair2[++b].i = ++i;
                    base_pair2[b].j   = --j;
                    goto repeat1;
                  }
                  break;
      }

      for(k = i + 1 + TURN; k <= j - 2 - TURN; k++)
        if(fij == (fML[indx[k]+i]+fML[indx[j]+k+1]))
          break;

      if ((dangle_model==3)&&(k > j - 2 - TURN)) { /* must be coax stack */
        ml = 2;
        for (k = i+1+TURN; k <= j - 2 - TURN; k++) {
          type    = rtype[(unsigned char)ptype[indx[k]+i]];
          type_2  = rtype[(unsigned char)ptype[indx[j]+k+1]];
          if (type && type_2)
            if (fij == c[indx[k]+i]+c[indx[j]+k+1]+P->stack[type][type_2]+
                       2*P->MLintern[1])
              break;
        }
      }
      sector[++s].i = i;
      sector[s].j   = k;
      sector[s].ml  = ml;
      sector[++s].i = k+1;
      sector[s].j   = j;
      sector[s].ml  = ml;

      if (k>j-2-TURN) nrerror("backtrack failed in fML");
      continue;
    }

  repeat1:

    /*----- begin of "repeat:" -----*/
    ij = indx[j]+i;
    if (canonical)  cij = c[ij];

    type = ptype[ij];

    bonus = 0;
    if (noLonelyPairs)
      if (cij == c[ij]){
        /* (i.j) closes canonical structures, thus
           (i+1.j-1) must be a pair                */
        type_2 = ptype[indx[j-1]+i+1]; type_2 = rtype[type_2];
        cij -= P->stack[type][type_2] + bonus;
        base_pair2[++b].i = i+1;
        base_pair2[b].j   = j-1;
        i++; j--;
        canonical=0;
        goto repeat1;
      }
    canonical = 1;


    no_close = (((type==3)||(type==4))&&no_closingGU&&(bonus==0));
    if (no_close) {
      if (cij == FORBIDDEN) continue;
    } else
      if (cij == E_Hairpin(j-i-1, type, S1[i+1], S1[j-1],string+i-1, P)+bonus)
        continue;

    for (p = i+1; p <= MIN2(j-2-TURN,i+MAXLOOP+1); p++) {
      int minq;
      minq = j-i+p-MAXLOOP-2;
      if (minq<p+1+TURN) minq = p+1+TURN;
      for (q = j-1; q >= minq; q--) {

        type_2 = ptype[indx[q]+p];
        if (type_2==0) continue;
        type_2 = rtype[type_2];
        if (no_closingGU)
          if (no_close||(type_2==3)||(type_2==4))
            if ((p>i+1)||(q<j-1)) continue;  /* continue unless stack */

        /* energy = oldLoopEnergy(i, j, p, q, type, type_2); */
        energy = E_IntLoop(p-i-1, j-q-1, type, type_2,
                            S1[i+1], S1[j-1], S1[p-1], S1[q+1], P);

        new = energy+c[indx[q]+p]+bonus;
        traced = (cij == new);
        if (traced) {
          base_pair2[++b].i = p;
          base_pair2[b].j   = q;
          i = p, j = q;
          goto repeat1;
        }
      }
    }

    /* end of repeat: --------------------------------------------------*/

    /* (i.j) must close a multi-loop */
    tt = rtype[type];
    i1 = i+1; j1 = j-1;
    sector[s+1].ml  = sector[s+2].ml = 1;

    switch(dangle_model){
      case 0:   en = cij - E_MLstem(tt, -1, -1, P) - P->MLclosing - bonus;
                for(k = i+2+TURN; k < j-2-TURN; k++){
                  if(en == fML[indx[k]+i+1] + fML[indx[j-1]+k+1])
                    break;
                }
                break;

      case 2:   en = cij - E_MLstem(tt, S1[j-1], S1[i+1], P) - P->MLclosing - bonus;
                for(k = i+2+TURN; k < j-2-TURN; k++){
                    if(en == fML[indx[k]+i+1] + fML[indx[j-1]+k+1])
                      break;
                }
                break;

      default:  for(k = i+2+TURN; k < j-2-TURN; k++){
                  en = cij - P->MLclosing - bonus;
                  if(en == fML[indx[k]+i+1] + fML[indx[j-1]+k+1] + E_MLstem(tt, -1, -1, P)){
                    break;
                  }
                  else if(en == fML[indx[k]+i+2] + fML[indx[j-1]+k+1] + E_MLstem(tt, -1, S1[i+1], P) + P->MLbase){
                    i1 = i+2;
                    break;
                  }
                  else if(en == fML[indx[k]+i+1] + fML[indx[j-2]+k+1] + E_MLstem(tt, S1[j-1], -1, P) + P->MLbase){
                    j1 = j-2;
                    break;
                  }
                  else if(en == fML[indx[k]+i+2] + fML[indx[j-2]+k+1] + E_MLstem(tt, S1[j-1], S1[i+1], P) + 2*P->MLbase){
                    i1 = i+2;
                    j1 = j-2;
                    break;
                  }
                  /* coaxial stacking of (i.j) with (i+1.k) or (k.j-1) */
                  /* use MLintern[1] since coax stacked pairs don't get TerminalAU */
                  if(dangle_model == 3){
                    type_2 = rtype[(unsigned char)ptype[indx[k]+i+1]];
                    if (type_2) {
                      en = c[indx[k]+i+1]+P->stack[type][type_2]+fML[indx[j-1]+k+1];
                      if (cij == en+2*P->MLintern[1]+P->MLclosing) {
                        ml = 2;
                        sector[s+1].ml  = 2;
                        traced = 1;
                        break;
                      }
                    }
                    type_2 = rtype[(unsigned char)ptype[indx[j-1]+k+1]];
                    if (type_2) {
                      en = c[indx[j-1]+k+1]+P->stack[type][type_2]+fML[indx[k]+i+1];
                      if (cij == en+2*P->MLintern[1]+P->MLclosing) {
                        sector[s+2].ml = 2;
                        traced = 1;
                        break;
                      }
                    }
                  }
                }
                break;
    }

    if (k<=j-3-TURN) { /* found the decomposition */
      sector[++s].i = i1;
      sector[s].j   = k;
      sector[++s].i = k+1;
      sector[s].j   = j1;
    } else {
        fprintf(stderr, "%s\n", string);
        nrerror("backtracking failed in repeat");
    }

  }

  base_pair2[0].i = b;    /* save the total number of base pairs */
}

PUBLIC char *backtrack_fold_from_pair(char *sequence, int i, int j) {
  char *structure;
  sector[1].i  = i;
  sector[1].j  = j;
  sector[1].ml = 2;
  base_pair2[0].i=0;
  S   = encode_sequence(sequence, 0);
  S1  = encode_sequence(sequence, 1);
  backtrack(sequence, 1);
  structure = (char *) space((strlen(sequence)+1)*sizeof(char));
  parenthesis_structure(structure, base_pair2, strlen(sequence));
  free(S);free(S1);
  return structure;
}

/*---------------------------------------------------------------------------*/

PUBLIC void parenthesis_structure(char *structure, bondT *bp, int length){
  int n, k;

  for (n = 0; n < length; structure[n++] = '.');
  structure[length] = '\0';

  for (k = 1; k <= bp[0].i; k++){
    structure[bp[k].i-1] = '(';
    structure[bp[k].j-1] = ')';
  }
}

/*---------------------------------------------------------------------------*/

PUBLIC void update_fold_params(void){
  update_fold_params_par(NULL);
}

PUBLIC void update_fold_params_par(paramT *parameters){
  if(P) free(P);
  if(parameters){
    P = get_parameter_copy(parameters);
  } else {
    P = get_scaled_parameters();
  }
  make_pair_matrix();
  if (init_length < 0) init_length=0;
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
        if (noLonelyPairs && (!otype) && (!ntype))
          type = 0; /* i.j can only form isolated pairs */
        ptype[indx[j]+i] = (char) type;
        otype =  type;
        type  = ntype;
        i--; j++;
      }
    }
}
