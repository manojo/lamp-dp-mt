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

#endif
