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

#include <config.h>
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
PRIVATE int     Fc, FcH, FcI, FcM;  /* parts of the exterior loop energies */
PRIVATE sect    sector[MAXSECTORS]; /* stack of partial structures for backtracking */
PRIVATE char    *ptype = NULL;      /* precomputed array of pair types */
PRIVATE short   *S = NULL, *S1 = NULL;
PRIVATE paramT  *P          = NULL;
PRIVATE int     init_length = -1;
PRIVATE int     *BP = NULL; /* contains the structure constrainsts: BP[i]
                        -1: | = base must be paired
                        -2: < = base must be paired with j<i
                        -3: > = base must be paired with j>i
                        -4: x = base must not pair
                        positive int: base is paired with int      */
PRIVATE short   *pair_table         = NULL; /* needed by energy of struct */
PRIVATE bondT   *base_pair2         = NULL;
PRIVATE int     circular            = 0;
PRIVATE int     struct_constrained  = 0;

/*
#################################
# PRIVATE FUNCTION DECLARATIONS #
#################################
*/
PRIVATE void  get_arrays(unsigned int size);
PRIVATE int   stack_energy(int i, const char *string, int verbostiy_level);
PRIVATE int   energy_of_extLoop_pt(int i, short *pair_table);
PRIVATE int   energy_of_ml_pt(int i, short *pt);
PRIVATE void  make_ptypes(const short *S, const char *structure);
PRIVATE void  backtrack(const char *sequence, int s);
PRIVATE int   fill_arrays(const char *sequence);
PRIVATE void  fill_arrays_circ(const char *string, int *bt);
PRIVATE void  init_fold(int length, paramT *parameters);
/* needed by cofold/eval */
PRIVATE int   cut_in_loop(int i);

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
  /* extra array(s) for circfold() */
  if(circular) fM2 =  (int *) space(sizeof(int)*(size+2));
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

PUBLIC void export_fold_arrays( int **f5_p,
                                int **c_p,
                                int **fML_p,
                                int **fM1_p,
                                int **indx_p,
                                char **ptype_p){
  /* make the DP arrays available to routines such as subopt() */
  *f5_p     = f5;
  *c_p      = c;
  *fML_p    = fML;
  *fM1_p    = fM1;
  *indx_p   = indx;
  *ptype_p  = ptype;
}

PUBLIC void export_fold_arrays_par( int **f5_p,
                                    int **c_p,
                                    int **fML_p,
                                    int **fM1_p,
                                    int **indx_p,
                                    char **ptype_p,
                                    paramT **P_p){
  export_fold_arrays(f5_p, c_p, fML_p, fM1_p, indx_p,ptype_p);
  *P_p = P;
}

PUBLIC void export_circfold_arrays( int *Fc_p,
                                    int *FcH_p,
                                    int *FcI_p,
                                    int *FcM_p,
                                    int **fM2_p,
                                    int **f5_p,
                                    int **c_p,
                                    int **fML_p,
                                    int **fM1_p,
                                    int **indx_p,
                                    char **ptype_p){
  /* make the DP arrays available to routines such as subopt() */
  *f5_p     = f5;
  *c_p      = c;
  *fML_p    = fML;
  *fM1_p    = fM1;
  *fM2_p    = fM2;
  *Fc_p     = Fc;
  *FcH_p    = FcH;
  *FcI_p    = FcI;
  *FcM_p    = FcM;
  *indx_p   = indx;
  *ptype_p  = ptype;
}

PUBLIC void export_circfold_arrays_par( int *Fc_p,
                                    int *FcH_p,
                                    int *FcI_p,
                                    int *FcM_p,
                                    int **fM2_p,
                                    int **f5_p,
                                    int **c_p,
                                    int **fML_p,
                                    int **fM1_p,
                                    int **indx_p,
                                    char **ptype_p,
                                    paramT **P_p){
  export_circfold_arrays(Fc_p, FcH_p, FcI_p, FcM_p, fM2_p, f5_p, c_p, fML_p, fM1_p, indx_p, ptype_p);
  *P_p = P;
}
/*--------------------------------------------------------------------------*/


PUBLIC float fold(const char *string, char *structure){
  return fold_par(string, structure, NULL, fold_constrained, 0);
}

PUBLIC float circfold(const char *string, char *structure){
  return fold_par(string, structure, NULL, fold_constrained, 1);
}

PUBLIC float fold_par(const char *string,
                      char *structure,
                      paramT *parameters,
                      int is_constrained,
                      int is_circular){

  int i, length, energy, bonus, bonus_cnt, s;

  bonus               = 0;
  bonus_cnt           = 0;
  s                   = 0;
  circular            = is_circular;
  struct_constrained  = is_constrained;
  length              = (int) strlen(string);

  if (parameters) init_fold(length, parameters);
  else if (length>init_length) init_fold(length, parameters);
  else if (fabs(P->temperature - temperature)>1e-6) update_fold_params();

  S   = encode_sequence(string, 0);
  S1  = encode_sequence(string, 1);

  BP  = (int *)space(sizeof(int)*(length+2));
  make_ptypes(S, structure);

  energy = fill_arrays(string);

  if(circular){
    fill_arrays_circ(string, &s);
    energy = Fc;
  }
  backtrack(string, s);

#ifdef PAREN
  parenthesis_structure(structure, base_pair2, length);
#else
  letter_structure(structure, base_pair2, length);
#endif
  /* check constraints */
  for(i=1;i<=length;i++) {
    if((BP[i]<0)&&(BP[i]>-4)) {
      bonus_cnt++;
      if((BP[i]==-3)&&(structure[i-1]==')')) bonus++;
      if((BP[i]==-2)&&(structure[i-1]=='(')) bonus++;
      if((BP[i]==-1)&&(structure[i-1]!='.')) bonus++;
    }

    if(BP[i]>i) {
      int l;
      bonus_cnt++;
      for(l=1; l<=base_pair2[0].i; l++)
        if((i==base_pair2[l].i)&&(BP[i]==base_pair2[l].j)) bonus++;
    }
  }

  if (bonus_cnt>bonus) fprintf(stderr,"\ncould not enforce all constraints\n");
  bonus*=BONUS;

  free(S); free(S1); free(BP);

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
#ifdef SPECIAL_DANGLES
  int   decomp_a, decomp_o;
#endif
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

#ifdef SPECIAL_DANGLES
  if(dangle_model == 5){
    for (j=1; j<=length; j++) {
      DMLi_a[j]=DMLi_o[j]=DMLi1_a[j]=DMLi1_o[j]=DMLi2_a[j]=DMLi2_o[j]=INF;
    }
  }
#endif

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
      /* enforcing structure constraints */
      if ((BP[i]==j)||(BP[i]==-1)||(BP[i]==-2)) bonus -= BONUS;
      if ((BP[j]==-1)||(BP[j]==-3)) bonus -= BONUS;
      if ((BP[i]==-4)||(BP[j]==-4)) type=0;

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

#ifdef SPECIAL_DANGLES
            /* normal dangles as ronny would think of them ;) */
            case 5:   /* no dangles */
                      decomp = INF;
                      if(DMLi1_o[j-1] != (DMLi2_o[j-1] + P->MLbase))
                        decomp = DMLi1_o[j-1] + E_MLstem(tt, -1, -1, P);

                      /* 3' dangle ? */
                      decomp = MIN2(decomp, DMLi2_o[j-1] + E_MLstem(tt, -1, S1[i+1], P) + P->MLbase);

                      /* 5' dangle ? */
                      decomp = MIN2(decomp, DMLi1_a[j-1] + E_MLstem(tt, S1[j-1], -1, P));

                      /* mismatch */
                      decomp = MIN2(decomp, DMLi2_a[j-1] + E_MLstem(tt, S1[j-1], S1[i+1], P) + P->MLbase);

                      break;
#endif
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
#ifdef SPECIAL_DANGLES
        /* normal dangles as ronny would think of them ;) */
        case 5:   /* modular decomposition */
                  for(decomp = INF, k = j-TURN-2; k > i+TURN+1; k--){
                    tt = ptype[indx[j]+k];
                    if(tt){
                      en = c[indx[j]+k];
                      if(Fmi[k-1] != Fmi[k-2] + P->MLbase)
                        decomp = MIN2(decomp, Fmi[k-1] + en + E_MLstem(tt, -1, -1, P));
                      decomp = MIN2(decomp, Fmi[k-2] + en + E_MLstem(tt, S1[k-1], -1, P) + P->MLbase);
                    }
                    tt = ptype[indx[j-1]+k];
                    if(tt){
                      en = c[indx[j-1]+k];
                      if(Fmi[k-1] != Fmi[k-2] + P->MLbase)
                        decomp = MIN2(decomp, Fmi[k-1] + en + E_MLstem(tt, -1, S1[j], P) + P->MLbase);
                      decomp = MIN2(decomp, Fmi[k-2] + en + E_MLstem(tt, S1[k-1], S1[j], P) + 2*P->MLbase);
                    }
                  }
                  DMLi_o[j] = decomp;
                  DMLi_a[j] = MIN2(DMLi_a[j-1] + P->MLbase, DMLi_o[j-1] + P->MLbase);
                  new_fML = MIN2(decomp , DMLi_a[j]);
                  new_fML = MIN2(new_fML, Fmi[j-1]  + P->MLbase);
                  new_fML = MIN2(new_fML, fML[ij+1] + P->MLbase);
                  /* all variants of having only 1 stem in [i,j] */
                  /* (i,j) */
                  if(type)  new_fML = MIN2(new_fML, c[ij] + E_MLstem(type, -1, -1, P));
                  /* (i+1,j) */
                  tt = ptype[ij+1];
                  if(tt)  new_fML = MIN2(new_fML, c[ij+1] + E_MLstem(tt, S1[i], -1, P) + P->MLbase) ;
                  /* (i,j-1) */
                  tt = ptype[indx[j-1]+i];
                  if(tt)  new_fML = MIN2(new_fML, c[indx[j-1]+i] + E_MLstem(tt, -1, S1[j], P) + P->MLbase);
                  /* (i+1,j-1) */
                  tt = ptype[indx[j-1]+i+1];
                  if(tt)  new_fML = MIN2(new_fML, c[indx[j-1]+i+1] + E_MLstem(tt, S1[i], S1[j], P) + 2*P->MLbase);
                  break;
#endif
        /* normal dangles, aka dangle_model = 1 || 3 */
        default:  mm5 = ((i>1) || circular) ? S1[i] : -1;
                  mm3 = ((j<length) || circular) ? S1[j] : -1;
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
#ifdef SPECIAL_DANGLES
      if(dangle_model != 5){
#endif
        for (decomp = INF, k = i + 1 + TURN; k <= j - 2 - TURN; k++)
          decomp = MIN2(decomp, Fmi[k]+fML[indx[j]+k+1]);
        DMLi[j] = decomp;               /* store for use in ML decompositon */
        new_fML = MIN2(new_fML,decomp);
#ifdef SPECIAL_DANGLES
      }
#endif
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
#ifdef SPECIAL_DANGLES
      if(dangle_model == 5){
        FF = DMLi2_a; DMLi2_a = DMLi1_a; DMLi1_a = DMLi_a; DMLi_a = FF;
        FF = DMLi2_o; DMLi2_o = DMLi1_o; DMLi1_o = DMLi_o; DMLi_o = FF;
        for (j=1; j<=length; j++) {DMLi_a[j]=DMLi_o[j]=INF; }
      }
#endif
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

#ifdef SPECIAL_DANGLES
    /* normal dangles as ronny would think of them ;) */
    case 5:   for(j=TURN+2; j<length; j++){
                f5[j] = f5[j-1];
                for (i=j-TURN-1; i>1; i--) {
                  char sw = (f5[i-1] != f5[i-2]);
                  type = ptype[indx[j]+i];
                  if(type){
                    en = c[indx[j]+i];
                    f5[j] = MIN2(f5[j], f5[i-2] + en + E_ExtLoop(type, S1[i-1], -1, P));
                    if(sw)
                      f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, -1, -1, P));
                  }
                  type = ptype[indx[j-1]+i];
                  if(type){
                    en = c[indx[j-1]+i];
                    f5[j] = MIN2(f5[j], f5[i-2] + en + E_ExtLoop(type, S1[i-1], S1[j], P));
                    if(sw)
                      f5[j] = MIN2(f5[j], f5[i-1] + en + E_ExtLoop(type, -1, S1[j], P));
                  }
                }
                type=ptype[indx[j]+1];
                if(type){
                  en = c[indx[j]+1];
                  f5[j] = MIN2(f5[j], en + E_ExtLoop(type, -1, -1, P));
                }
                type=ptype[indx[j-1]+1];
                if(type){
                  en = c[indx[j-1]+1];
                  f5[j]  = MIN2(f5[j], en + E_ExtLoop(type, -1, S1[j], P));
                }
              }
              f5[length] = f5[length-1];
              for (i=length-TURN-1; i>1; i--) {
                char sw = (f5[i-1] != f5[i-2]);
                type = ptype[indx[length]+i];
                if(type){
                  en = c[indx[length]+i];
                  f5[length] = MIN2(f5[length], f5[i-2] + en + E_ExtLoop(type, S1[i-1], -1, P));
                  if(sw)
                    f5[length] = MIN2(f5[length], f5[i-1] + en + E_ExtLoop(type, -1, -1, P));
                }
                type = ptype[indx[length-1]+i];
                if(type){
                  en = c[indx[length-1]+i];
                  f5[length] = MIN2(f5[length], f5[i-2] + en + E_ExtLoop(type, S1[i-1], S1[length], P));
                  if(sw)
                    f5[length] = MIN2(f5[length], f5[i-1] + en + E_ExtLoop(type, -1, S1[length], P));
                }
              }
              type=ptype[indx[length]+1];
              if(type){
                en = c[indx[length]+1];
                f5[length] = MIN2(f5[length], en + E_ExtLoop(type, -1, -1, P));
              }
              type=ptype[indx[length-1]+1];
              if(type){
                en = c[indx[length-1]+1];
                f5[length]  = MIN2(f5[length], en + E_ExtLoop(type, -1, S1[length], P));
              }
              break;
#endif
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

#include "circfold.inc"

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

#ifdef SPECIAL_DANGLES
        case 5:   for(k=j-TURN-1,traced=0; k>1; k--){
                    type = ptype[indx[j]+k];
                    en = c[indx[j]+k];
                    if(type){
                      if(fij == f5[k-1] + en + E_ExtLoop(type, -1, -1, P)){
                        traced = j; jj = k-1; ml=0; jj = k-1; break;
                      }
                      if(fij == f5[k-2] + en + E_ExtLoop(type, S1[k-1], -1, P)){
                        traced = j; jj = k-2; ml=0; jj = k-1; break;
                      }
                    }
                    type = ptype[indx[j-1]+k];
                    if(type){
                      en = c[indx[j-1]+k];
                      if(fij == f5[k-1] + en + E_ExtLoop(type, -1, S1[j], P)){
                        traced = j-1; jj=k-1; ml=0; break;
                      }
                      if(fij == f5[k-2] + en + E_ExtLoop(type, S1[k-1], S1[j], P)){
                        traced = j-1; jj=k-2; ml = 0; break;
                      }
                    }
                  }
                  if(!traced){
                    type = ptype[indx[j]+1];
                    en = c[indx[j]+1];
                    if(type){
                      if(fij == en + E_ExtLoop(type, -1, -1, P)){
                        traced = j; ml = 0; jj = 0; break;
                      }
                    }
                    type = ptype[indx[j-1]+1];
                    if(type){
                      en = c[indx[j-1]+1];
                      if(fij == en + E_ExtLoop(type, -1, S1[j], P)){
                        traced = j-1; ml = 0; jj = 0; break;
                      }
                    }
                  }
                  break;
#endif
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

#ifdef SPECIAL_DANGLES
        case 5:   if(fij == en + E_MLstem(tt, -1, -1, P)){
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
#endif
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
    if (fold_constrained) {
      if ((BP[i]==j)||(BP[i]==-1)||(BP[i]==-2)) bonus -= BONUS;
      if ((BP[j]==-1)||(BP[j]==-3)) bonus -= BONUS;
    }
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

#ifdef SPECIAL_DANGLES
      case 5:   for(k = i+2+TURN; k < j-2-TURN; k++){
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
                }
                break;
#endif
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

PUBLIC void letter_structure(char *structure, bondT *bp, int length){
  int   n, k, x, y;
  char  alpha[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

  for (n = 0; n < length; structure[n++] = ' ');
  structure[length] = '\0';

  for (n = 0, k = 1; k <= bp[0].i; k++) {
    y = bp[k].j;
    x = bp[k].i;
    if (x-1 > 0 && y+1 <= length) {
      if (structure[x-2] != ' ' && structure[y] == structure[x-2]) {
        structure[x-1] = structure[x-2];
        structure[y-1] = structure[x-1];
        continue;
      }
    }
    if (structure[x] != ' ' && structure[y-2] == structure[x]) {
      structure[x-1] = structure[x];
      structure[y-1] = structure[x-1];
      continue;
    }
    n++;
    structure[x-1] = alpha[n-1];
    structure[y-1] = alpha[n-1];
  }
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

PUBLIC void parenthesis_zuker(char *structure, bondT *bp, int length){
  int k, i, j, temp;

  for (k = 0; k < length; structure[k++] = '.');
  structure[length] = '\0';

  for (k = 1; k <= bp[0].i; k++) {
    i=bp[k].i;
    j=bp[k].j;
    if (i>length) i-=length;
    if (j>length) j-=length;
    if (i>j) {
      temp=i; i=j; j=temp;
    }
    structure[i-1] = '(';
    structure[j-1] = ')';
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
    model_detailsT md;
    set_model_details(&md);
    P = get_scaled_parameters(temperature, md);
  }
  make_pair_matrix();
  if (init_length < 0) init_length=0;
}

/*---------------------------------------------------------------------------*/
PRIVATE int stack_energy(int i, const char *string, int verbosity_level)
{
  /* calculate energy of substructure enclosed by (i,j) */
  int ee, energy = 0;
  int j, p, q, type;

  j=pair_table[i];
  type = pair[S[i]][S[j]];
  if (type==0) {
    type=7;
    if (verbosity_level>=0)
      fprintf(stderr,"WARNING: bases %d and %d (%c%c) can't pair!\n", i, j,
              string[i-1],string[j-1]);
  }

  p=i; q=j;
  while (p<q) { /* process all stacks and interior loops */
    int type_2;
    while (pair_table[++p]==0);
    while (pair_table[--q]==0);
    if ((pair_table[q]!=(short)p)||(p>q)) break;
    type_2 = pair[S[q]][S[p]];
    if (type_2==0) {
      type_2=7;
      if (verbosity_level>=0)
        fprintf(stderr,"WARNING: bases %d and %d (%c%c) can't pair!\n", p, q,
                string[p-1],string[q-1]);
    }
    /* energy += LoopEnergy(i, j, p, q, type, type_2); */
    if ( SAME_STRAND(i,p) && SAME_STRAND(q,j) )
      ee = E_IntLoop(p-i-1, j-q-1, type, type_2, S1[i+1], S1[j-1], S1[p-1], S1[q+1],P);
    else
      ee = energy_of_extLoop_pt(cut_in_loop(i), pair_table);
    if (verbosity_level>0)
      printf("Interior loop (%3d,%3d) %c%c; (%3d,%3d) %c%c: %5d\n",
             i,j,string[i-1],string[j-1],p,q,string[p-1],string[q-1], ee);
    energy += ee;
    i=p; j=q; type = rtype[type_2];
  } /* end while */

  /* p,q don't pair must have found hairpin or multiloop */

  if (p>q) {                       /* hair pin */
    if (SAME_STRAND(i,j))
      ee = E_Hairpin(j-i-1, type, S1[i+1], S1[j-1], string+i-1, P);
    else
      ee = energy_of_extLoop_pt(cut_in_loop(i), pair_table);
    energy += ee;
    if (verbosity_level>0)
      printf("Hairpin  loop (%3d,%3d) %c%c              : %5d\n",
             i, j, string[i-1],string[j-1], ee);

    return energy;
  }

  /* (i,j) is exterior pair of multiloop */
  while (p<j) {
    /* add up the contributions of the substructures of the ML */
    energy += stack_energy(p, string, verbosity_level);
    p = pair_table[p];
    /* search for next base pair in multiloop */
    while (pair_table[++p]==0);
  }
  {
    int ii;
    ii = cut_in_loop(i);
    ee = (ii==0) ? energy_of_ml_pt(i, pair_table) : energy_of_extLoop_pt(ii, pair_table);
  }
  energy += ee;
  if (verbosity_level>0)
    printf("Multi    loop (%3d,%3d) %c%c              : %5d\n",
           i,j,string[i-1],string[j-1],ee);

  return energy;
}

/*---------------------------------------------------------------------------*/



/**
*** Calculate the energy contribution of
*** stabilizing dangling-ends/mismatches
*** for all stems branching off the exterior
*** loop
**/
PRIVATE int energy_of_extLoop_pt(int i, short *pair_table) {
  int energy, mm5, mm3;
  int p, q, q_prev;
  int length = (int)pair_table[0];

  /* helper variables for dangles == 1 case */
  int E3_available;  /* energy of 5' part where 5' mismatch is available for current stem */
  int E3_occupied;   /* energy of 5' part where 5' mismatch is unavailable for current stem */

  int dangle_model = P->model_details.dangles;

  /* initialize vars */
  energy      = 0;
  p           = (i==0) ? 1 : i;
  q_prev      = -1;

  if(dangle_model%2 == 1){
    E3_available = INF;
    E3_occupied  = 0;
  }

  /* seek to opening base of first stem */
  while(p <= length && !pair_table[p]) p++;

  while(p < length){
    int tt;
    /* p must have a pairing partner */
    q  = (int)pair_table[p];
    /* get type of base pair (p,q) */
    tt = pair[S[p]][S[q]];
    if(tt==0) tt=7;

    switch(dangle_model){
      /* no dangles */
      case 0:   energy += E_ExtLoop(tt, -1, -1, P);
                break;
      /* the beloved double dangles */
      case 2:   mm5 = ((SAME_STRAND(p-1,p)) && (p>1))       ? S1[p-1] : -1;
                mm3 = ((SAME_STRAND(q,q+1)) && (q<length))  ? S1[q+1] : -1;
                energy += E_ExtLoop(tt, mm5, mm3, P);
                break;

#ifdef SPECIAL_DANGLES
      case 5:  {
                  int tmp;
                  if(q_prev + 2 < p){
                    E3_available = E3_occupied;
                    E3_occupied  = INF;
                  }
                  mm5 = ((SAME_STRAND(p-1,p)) && (p>1) && !pair_table[p-1])       ? S1[p-1] : -1;
                  mm3 = ((SAME_STRAND(q,q+1)) && (q<length) && !pair_table[q+1])  ? S1[q+1] : -1;
                  tmp = (mm3 < 0) ? INF :  MIN2(
                                                E3_occupied  + E_ExtLoop(tt, -1, mm3, P),
                                                E3_available + E_ExtLoop(tt, mm5, mm3, P)
                                              );
                  E3_available =       MIN2(
                                                E3_occupied  + E_ExtLoop(tt, -1, -1, P),
                                                E3_available + E_ExtLoop(tt, mm5, -1, P)
                                              );
                  E3_occupied = tmp;
                }
                break;
#endif
      default:  {
                  int tmp;
                  if(q_prev + 2 < p){
                    E3_available = MIN2(E3_available, E3_occupied);
                    E3_occupied  = E3_available;
                  }
                  mm5 = ((SAME_STRAND(p-1,p)) && (p>1) && !pair_table[p-1])       ? S1[p-1] : -1;
                  mm3 = ((SAME_STRAND(q,q+1)) && (q<length) && !pair_table[q+1])  ? S1[q+1] : -1;
                  tmp = MIN2(
                                                E3_occupied  + E_ExtLoop(tt, -1, mm3, P),
                                                E3_available + E_ExtLoop(tt, mm5, mm3, P)
                                              );
                  E3_available =       MIN2(
                                                E3_occupied  + E_ExtLoop(tt, -1, -1, P),
                                                E3_available + E_ExtLoop(tt, mm5, -1, P)
                                              );
                  E3_occupied = tmp;
                }
                break;

    } /* end switch dangle_model */
    /* seek to the next stem */
    p = q + 1;
    q_prev = q;
    while (p <= length && !pair_table[p]) p++;
    if(p==i) break; /* cut was in loop */
  }

  if(dangle_model%2 == 1)
    energy = MIN2(E3_occupied, E3_available);

  return energy;
}

/**
*** i is the 5'-base of the closing pair
***
*** since each helix can coaxially stack with at most one of its
*** neighbors we need an auxiliarry variable  cx_energy
*** which contains the best energy given that the last two pairs stack.
*** energy  holds the best energy given the previous two pairs do not
*** stack (i.e. the two current helices may stack)
*** We don't allow the last helix to stack with the first, thus we have to
*** walk around the Loop twice with two starting points and take the minimum
***/
PRIVATE int energy_of_ml_pt(int i, short *pt){

  int energy, cx_energy, tmp, tmp2, best_energy=INF;
  int i1, j, p, q, q_prev, q_prev2, u, x, type, count, mm5, mm3, tt, ld5, new_cx, dang5, dang3, dang;
  int mlintern[NBPAIRS+1], mlclosing, mlbase;

  /* helper variables for dangles == 1|5 case */
  int E_mm5_available;  /* energy of 5' part where 5' mismatch of current stem is available */
  int E_mm5_occupied;   /* energy of 5' part where 5' mismatch of current stem is unavailable */
  int E2_mm5_available; /* energy of 5' part where 5' mismatch of current stem is available with possible 3' dangle for enclosing pair (i,j) */
  int E2_mm5_occupied;  /* energy of 5' part where 5' mismatch of current stem is unavailable with possible 3' dangle for enclosing pair (i,j) */
  int dangle_model = P->model_details.dangles;

  if(i >= pt[i])
    nrerror("energy_of_ml_pt: i is not 5' base of a closing pair!");

  j = (int)pt[i];

  /* init the variables */
  energy      = 0;
  p           = i+1;
  q_prev      = i-1;
  q_prev2     = i;

  for (x = 0; x <= NBPAIRS; x++) mlintern[x] = P->MLintern[x];
  mlclosing = P->MLclosing; mlbase = P->MLbase;

  /* seek to opening base of first stem */
  while(p <= j && !pair_table[p]) p++;
  u = p - i - 1;

  switch(dangle_model){
    case 0:   while(p < j){
                /* p must have a pairing partner */
                q  = (int)pair_table[p];
                /* get type of base pair (p,q) */
                tt = pair[S[p]][S[q]];
                if(tt==0) tt=7;
                energy += E_MLstem(tt, -1, -1, P);
                /* seek to the next stem */
                p = q + 1;
                q_prev = q_prev2 = q;
                while (p <= j && !pair_table[p]) p++;
                u += p - q - 1; /* add unpaired nucleotides */
              }
              /* now lets get the energy of the enclosing stem */
              type = pair[S[j]][S[i]]; if (type==0) type=7;
              energy += E_MLstem(type, -1, -1, P);
              break;

    case 2:   while(p < j){
                /* p must have a pairing partner */
                q  = (int)pair_table[p];
                /* get type of base pair (p,q) */
                tt = pair[S[p]][S[q]];
                if(tt==0) tt=7;
                mm5 = (SAME_STRAND(p-1,p))  ? S1[p-1] : -1;
                mm3 = (SAME_STRAND(q,q+1))  ? S1[q+1] : -1;
                energy += E_MLstem(tt, mm5, mm3, P);
                /* seek to the next stem */
                p = q + 1;
                q_prev = q_prev2 = q;
                while (p <= j && !pair_table[p]) p++;
                u += p - q - 1; /* add unpaired nucleotides */
              }
              type = pair[S[j]][S[i]]; if (type==0) type=7;
              mm5 = ((SAME_STRAND(j-1,j)) && !pair_table[j-1])  ? S1[j-1] : -1;
              mm3 = ((SAME_STRAND(i,i+1)) && !pair_table[i+1])  ? S1[i+1] : -1;
              energy += E_MLstem(type, S1[j-1], S1[i+1], P);
              break;

    case 3:   /* we treat helix stacking different */
              for (count=0; count<2; count++) { /* do it twice */
                ld5 = 0; /* 5' dangle energy on prev pair (type) */
                if ( i==0 ) {
                  j = (unsigned int)pair_table[0]+1;
                  type = 0;  /* no pair */
                }
                else {
                  j = (unsigned int)pair_table[i];
                  type = pair[S[j]][S[i]]; if (type==0) type=7;
                  /* prime the ld5 variable */
                  if (SAME_STRAND(j-1,j)) {
                    ld5 = P->dangle5[type][S1[j-1]];
                    if ((p=(unsigned int)pair_table[j-2]) && SAME_STRAND(j-2, j-1))
                    if (P->dangle3[pair[S[p]][S[j-2]]][S1[j-1]]<ld5) ld5 = 0;
                  }
                }
                i1=i; p = i+1; u=0;
                energy = 0; cx_energy=INF;
                do { /* walk around the multi-loop */
                  new_cx = INF;

                  /* hop over unpaired positions */
                  while (p <= (unsigned int)pair_table[0] && pair_table[p]==0) p++;

                  /* memorize number of unpaired positions */
                  u += p-i1-1;
                  /* get position of pairing partner */
                  if ( p == (unsigned int)pair_table[0]+1 ){
                    q = 0;tt = 0; /* virtual root pair */
                  } else {
                    q  = (unsigned int)pair_table[p];
                    /* get type of base pair P->q */
                    tt = pair[S[p]][S[q]]; if (tt==0) tt=7;
                  }

                  energy += mlintern[tt];
                  cx_energy += mlintern[tt];

                  dang5=dang3=0;
                  if ((SAME_STRAND(p-1,p))&&(p>1))
                    dang5=P->dangle5[tt][S1[p-1]];      /* 5'dangle of pq pair */
                  if ((SAME_STRAND(i1,i1+1))&&(i1<(unsigned int)S[0]))
                    dang3 = P->dangle3[type][S1[i1+1]]; /* 3'dangle of previous pair */

                  switch (p-i1-1) {
                    case 0:   /* adjacent helices */
                              if (i1!=0){
                                if (SAME_STRAND(i1,p)) {
                                  new_cx = energy + P->stack[rtype[type]][rtype[tt]];
                                  /* subtract 5'dangle and TerminalAU penalty */
                                  new_cx += -ld5 - mlintern[tt]-mlintern[type]+2*mlintern[1];
                                }
                                ld5=0;
                                energy = MIN2(energy, cx_energy);
                              }
                              break;
                    case 1:   /* 1 unpaired base between helices */
                              dang = MIN2(dang3, dang5);
                              energy = energy +dang; ld5 = dang - dang3;
                              /* may be problem here: Suppose
                                cx_energy>energy, cx_energy+dang5<energy
                                and the following helices are also stacked (i.e.
                                we'll subtract the dang5 again */
                              if (cx_energy+dang5 < energy) {
                                energy = cx_energy+dang5;
                                ld5 = dang5;
                              }
                              new_cx = INF;  /* no coax stacking with mismatch for now */
                              break;
                    default:  /* many unpaired base between helices */
                              energy += dang5 +dang3;
                              energy = MIN2(energy, cx_energy + dang5);
                              new_cx = INF;  /* no coax stacking possible */
                              ld5 = dang5;
                              break;
                  }
                  type = tt;
                  cx_energy = new_cx;
                  i1 = q; p=q+1;
                } while (q!=i);
                best_energy = MIN2(energy, best_energy); /* don't use cx_energy here */
                /* fprintf(stderr, "%6.2d\t", energy); */
                /* skip a helix and start again */
                while (pair_table[p]==0) p++;
                if (i == (unsigned int)pair_table[p]) break;
                i = (unsigned int)pair_table[p];
              } /* end doing it twice */
              energy = best_energy;
              break;

#ifdef SPECIAL_DANGLES
    case 5:   E_mm5_available = E2_mm5_available  = INF;
              E_mm5_occupied  = E2_mm5_occupied   = 0;
              while(p < j){
                /* p must have a pairing partner */
                q  = (int)pair_table[p];
                /* get type of base pair (p,q) */
                tt = pair[S[p]][S[q]];
                if(tt==0) tt=7;
                if(q_prev + 2 < p){
                  E_mm5_available = E_mm5_occupied;
                  E_mm5_occupied  = INF;
                }
                if(q_prev2 + 2 < p){
                  E2_mm5_available = E2_mm5_occupied;
                  E2_mm5_occupied = INF;
                }
                mm5 = ((SAME_STRAND(p-1,p)) && !pair_table[p-1])  ? S1[p-1] : -1;
                mm3 = ((SAME_STRAND(q,q+1)) && !pair_table[q+1])  ? S1[q+1] : -1;
                tmp = (mm3 < 0) ? INF :  MIN2(
                                              E_mm5_occupied  + E_MLstem(tt, -1, mm3, P),
                                              E_mm5_available + E_MLstem(tt, mm5, mm3, P)
                                            );
                E_mm5_available =       MIN2(
                                              E_mm5_occupied  + E_MLstem(tt, -1, -1, P),
                                              E_mm5_available + E_MLstem(tt, mm5, -1, P)
                                            );
                E_mm5_occupied = tmp;
                tmp2 = (mm3 < 0) ? INF :  MIN2(
                                              E2_mm5_occupied  + E_MLstem(tt, -1, mm3, P),
                                              E2_mm5_available + E_MLstem(tt, mm5, mm3, P)
                                            );
                E2_mm5_available =       MIN2(
                                              E2_mm5_occupied  + E_MLstem(tt, -1, -1, P),
                                              E2_mm5_available + E_MLstem(tt, mm5, -1, P)
                                            );
                E2_mm5_occupied = tmp2;
                /* seek to the next stem */
                p = q + 1;
                q_prev = q_prev2 = q;
                while (p <= j && !pair_table[p]) p++;
                u += p - q - 1; /* add unpaired nucleotides */
              }
              /* now lets see how we get the minimum including the enclosing stem */
              type = pair[S[j]][S[i]]; if (type==0) type=7;
              mm5 = ((SAME_STRAND(j-1,j)) && !pair_table[j-1])  ? S1[j-1] : -1;
              mm3 = ((SAME_STRAND(i,i+1)) && !pair_table[i+1])  ? S1[i+1] : -1;
              energy = INF;
              if(q_prev + 2 < j){
                energy = MIN2(energy, E_mm5_occupied + E_MLstem(type, mm5, -1, P));
                energy = MIN2(energy, E2_mm5_occupied + E_MLstem(type, mm5, mm3, P));
              }
              else{
                energy = MIN2(energy, E_mm5_occupied + E_MLstem(type, -1, -1, P));
                energy = MIN2(energy, E2_mm5_occupied + E_MLstem(type, -1, mm3, P));
              }
              energy = MIN2(energy, E_mm5_available + E_MLstem(type, mm5, -1, P));
              energy = MIN2(energy, E2_mm5_available + E_MLstem(type, mm5, mm3, P));
              break;

#endif
    default:  E_mm5_available = E2_mm5_available  = INF;
              E_mm5_occupied  = E2_mm5_occupied   = 0;
              while(p < j){
                /* p must have a pairing partner */
                q  = (int)pair_table[p];
                /* get type of base pair (p,q) */
                tt = pair[S[p]][S[q]];
                if(tt==0) tt=7;
                if(q_prev + 2 < p){
                  E_mm5_available = MIN2(E_mm5_available, E_mm5_occupied);
                  E_mm5_occupied  = E_mm5_available;
                }
                if(q_prev2 + 2 < p){
                  E2_mm5_available  = MIN2(E2_mm5_available, E2_mm5_occupied);
                  E2_mm5_occupied   = E2_mm5_available;
                }
                mm5 = ((SAME_STRAND(p-1,p)) && !pair_table[p-1])  ? S1[p-1] : -1;
                mm3 = ((SAME_STRAND(q,q+1)) && !pair_table[q+1])  ? S1[q+1] : -1;
                tmp =                   MIN2(
                                              E_mm5_occupied  + E_MLstem(tt, -1, mm3, P),
                                              E_mm5_available + E_MLstem(tt, mm5, mm3, P)
                                            );
                tmp   =                 MIN2(tmp, E_mm5_available + E_MLstem(tt, -1, mm3, P));
                tmp2  =                 MIN2(
                                              E_mm5_occupied  + E_MLstem(tt, -1, -1, P),
                                              E_mm5_available + E_MLstem(tt, mm5, -1, P)
                                            );
                E_mm5_available =       MIN2(tmp2, E_mm5_available  + E_MLstem(tt, -1, -1, P));
                E_mm5_occupied  = tmp;

                tmp =                  MIN2(
                                              E2_mm5_occupied  + E_MLstem(tt, -1, mm3, P),
                                              E2_mm5_available + E_MLstem(tt, mm5, mm3, P)
                                            );
                tmp =                   MIN2(tmp, E2_mm5_available + E_MLstem(tt, -1, mm3, P));
                tmp2 =                  MIN2(
                                              E2_mm5_occupied  + E_MLstem(tt, -1, -1, P),
                                              E2_mm5_available + E_MLstem(tt, mm5, -1, P)
                                            );
                E2_mm5_available =      MIN2(tmp2, E2_mm5_available + E_MLstem(tt, -1, -1, P));
                E2_mm5_occupied = tmp;
                //printf("(%d,%d): \n E_o = %d, E_a = %d, E2_o = %d, E2_a = %d\n", p, q, E_mm5_occupied,E_mm5_available,E2_mm5_occupied,E2_mm5_available);
                /* seek to the next stem */
                p = q + 1;
                q_prev = q_prev2 = q;
                while (p <= j && !pair_table[p]) p++;
                u += p - q - 1; /* add unpaired nucleotides */
              }
              /* now lets see how we get the minimum including the enclosing stem */
              type = pair[S[j]][S[i]]; if (type==0) type=7;
              mm5 = ((SAME_STRAND(j-1,j)) && !pair_table[j-1])  ? S1[j-1] : -1;
              mm3 = ((SAME_STRAND(i,i+1)) && !pair_table[i+1])  ? S1[i+1] : -1;
              if(q_prev + 2 < p){
                E_mm5_available = MIN2(E_mm5_available, E_mm5_occupied);
                E_mm5_occupied  = E_mm5_available;
              }
              if(q_prev2 + 2 < p){
                E2_mm5_available  = MIN2(E2_mm5_available, E2_mm5_occupied);
                E2_mm5_occupied   = E2_mm5_available;
              }
              energy = MIN2(E_mm5_occupied  + E_MLstem(type, -1, -1, P),
                            E_mm5_available + E_MLstem(type, mm5, -1, P)
                          );
              energy = MIN2(energy, E_mm5_available   + E_MLstem(type, -1, -1, P));
              energy = MIN2(energy, E2_mm5_occupied   + E_MLstem(type, -1, mm3, P));
              energy = MIN2(energy, E2_mm5_occupied   + E_MLstem(type, -1, -1, P));
              energy = MIN2(energy, E2_mm5_available  + E_MLstem(type, mm5, mm3, P));
              energy = MIN2(energy, E2_mm5_available  + E_MLstem(type, -1, mm3, P));
              energy = MIN2(energy, E2_mm5_available  + E_MLstem(type, mm5, -1, P));
              energy = MIN2(energy, E2_mm5_available  + E_MLstem(type, -1, -1, P));
              break;
  }/* end switch dangle_model */

  energy += P->MLclosing;
  /* logarithmic ML loop energy if logML */
  if(logML && (u>6))
    energy += 6*P->MLbase+(int)(P->lxc*log((double)u/6.));
  else
    energy += (u*P->MLbase);

  return energy;
}

/*---------------------------------------------------------------------------*/

PUBLIC int loop_energy(short * ptable, short *s, short *s1, int i) {
  /* compute energy of a single loop closed by base pair (i,j) */
  int j, type, p,q, energy;
  short *Sold, *S1old, *ptold;

  ptold=pair_table;   Sold = S;   S1old = S1;
  pair_table = ptable;   S = s;   S1 = s1;

  if (i==0) { /* evaluate exterior loop */
    energy = energy_of_extLoop_pt(0,pair_table);
    pair_table=ptold; S=Sold; S1=S1old;
    return energy;
  }
  j = pair_table[i];
  if (j<i) nrerror("i is unpaired in loop_energy()");
  type = pair[S[i]][S[j]];
  if (type==0) {
    type=7;
    if (eos_debug>=0)
      fprintf(stderr,"WARNING: bases %d and %d (%c%c) can't pair!\n", i, j,
              Law_and_Order[S[i]],Law_and_Order[S[j]]);
  }
  p=i; q=j;


  while (pair_table[++p]==0);
  while (pair_table[--q]==0);
  if (p>q) { /* Hairpin */
    char loopseq[8] = "";
    if (SAME_STRAND(i,j)) {
      if (j-i-1<7) {
        int u;
        for (u=0; i+u<=j; u++) loopseq[u] = Law_and_Order[S[i+u]];
        loopseq[u] = '\0';
      }
      energy = E_Hairpin(j-i-1, type, S1[i+1], S1[j-1], loopseq, P);
    } else {
      energy = energy_of_extLoop_pt(cut_in_loop(i), pair_table);
    }
  }
  else if (pair_table[q]!=(short)p) { /* multi-loop */
    int ii;
    ii = cut_in_loop(i);
    energy = (ii==0) ? energy_of_ml_pt(i, pair_table) : energy_of_extLoop_pt(ii, pair_table);
  }
  else { /* found interior loop */
    int type_2;
    type_2 = pair[S[q]][S[p]];
    if (type_2==0) {
      type_2=7;
      if (eos_debug>=0)
        fprintf(stderr,"WARNING: bases %d and %d (%c%c) can't pair!\n", p, q,
                Law_and_Order[S[p]],Law_and_Order[S[q]]);
    }
    /* energy += LoopEnergy(i, j, p, q, type, type_2); */
    if ( SAME_STRAND(i,p) && SAME_STRAND(q,j) )
      energy = E_IntLoop(p-i-1, j-q-1, type, type_2,
                          S1[i+1], S1[j-1], S1[p-1], S1[q+1], P);
    else
      energy = energy_of_extLoop_pt(cut_in_loop(i), pair_table);
  }

  pair_table=ptold; S=Sold; S1=S1old;
  return energy;
}

/*---------------------------------------------------------------------------*/

PRIVATE int cut_in_loop(int i) {
  /* walk around the loop;  return j pos of pair after cut if
     cut_point in loop else 0 */
  int  p, j;
  p = j = pair_table[i];
  do {
    i  = pair_table[p];  p = i+1;
    while ( pair_table[p]==0 ) p++;
  } while (p!=j && SAME_STRAND(i,p));
  return SAME_STRAND(i,p) ? 0 : j;
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

  if (fold_constrained && (structure != NULL))
    constrain_ptypes(structure, (unsigned int)n, ptype, BP, TURN, 0);
}

PUBLIC void assign_plist_from_db(plist **pl, const char *struc, float pr){
  /* convert bracket string to plist */
  short *pt;
  int i, k = 0;
  pt  = make_pair_table(struc);
  *pl = (plist *)space((strlen(struc)/2+1)*sizeof(plist));
  for(i = 1; i < strlen(struc); i++){
    if(pt[i]>i){
      (*pl)[k].i    = i;
      (*pl)[k].j    = pt[i];
      (*pl)[k++].p  = pr;
    }
  }
  (*pl)[k].i    = 0;
  (*pl)[k].j    = 0;
  (*pl)[k++].p  = 0.;
  free(pt);
  *pl = (plist *)xrealloc(*pl, k * sizeof(plist));
}
