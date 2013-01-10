#ifndef __VIENNA_RNA_PACKAGE_DATA_STRUCTURES_H__
#define __VIENNA_RNA_PACKAGE_DATA_STRUCTURES_H__

#include "vienna.h"
#include "energy_const.h"

/**
 *  \file data_structures.h
 *  \brief All datastructures and typedefs shared among the Vienna RNA Package can be found here
 */

/* to use floats instead of doubles in pf_fold() comment next line */
#define LARGE_PF
#ifdef  LARGE_PF
#define FLT_OR_DBL double
#else
#define FLT_OR_DBL float
#endif

#ifndef MAXALPHA
/**
 *  \brief Maximal length of alphabet
 */
#define MAXALPHA              20
#endif

/**
 *  \brief Maximum density of states discretization for subopt
 */
#define MAXDOS                1000

/*
* ############################################################
* Here are the type definitions of various datastructures
* shared among the Vienna RNA Package
* ############################################################
*/

/**
 *  \brief this datastructure is used as input parameter in functions of PS_dot.h and others
 */
typedef struct plist {
  int i;
  int j;
  float p;
} plist;

/**
 *  \brief this datastructure is used as input parameter in functions of PS_dot.c
 */
typedef struct cpair {
  int i,j,mfe;
  float p, hue, sat;
} cpair;

/**
 *  stack of partial structures for backtracking
 */
typedef struct sect {
  int  i;
  int  j;
  int ml;
} sect;

/**
 *  base pair
 */
typedef struct bondT {
   unsigned int i;
   unsigned int j;
} bondT;

/**
 *  The datastructure that contains temperature scaled Boltzmann weights of the energy parameters.
 */
typedef struct{
  int     id;
  double  expstack[NBPAIRS+1][NBPAIRS+1];
  double  exphairpin[31];
  double  expbulge[MAXLOOP+1];
  double  expinternal[MAXLOOP+1];
  double  expmismatchExt[NBPAIRS+1][5][5];
  double  expmismatchI[NBPAIRS+1][5][5];
  double  expmismatch23I[NBPAIRS+1][5][5];
  double  expmismatch1nI[NBPAIRS+1][5][5];
  double  expmismatchH[NBPAIRS+1][5][5];
  double  expmismatchM[NBPAIRS+1][5][5];
  double  expdangle5[NBPAIRS+1][5];
  double  expdangle3[NBPAIRS+1][5];
  double  expint11[NBPAIRS+1][NBPAIRS+1][5][5];
  double  expint21[NBPAIRS+1][NBPAIRS+1][5][5][5];
  double  expint22[NBPAIRS+1][NBPAIRS+1][5][5][5][5];
  double  expninio[5][MAXLOOP+1];
  double  lxc;
  double  expMLbase;
  double  expMLintern[NBPAIRS+1];
  double  expMLclosing;
  double  expTermAU;
  double  expDuplexInit;
  double  exptetra[40];
  double  exptri[40];
  double  exphex[40];
  char    Tetraloops[1401];
  double  expTriloop[40];
  char    Triloops[241];
  char    Hexaloops[1801];
  double  expTripleC;
  double  expMultipleCA;
  double  expMultipleCB;

  double  kT;
  double  pf_scale;

  double  temperature;  /*  temperature used for loop contribution scaling */
  double  alpha;        /*  used for scaling the thermodynamic temperature in Boltzmann factors
                            independently from the energy contributions */

  model_detailsT model_details;

}  pf_paramT;

#endif
