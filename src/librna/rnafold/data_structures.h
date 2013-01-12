#ifndef __VIENNA_RNA_PACKAGE_DATA_STRUCTURES_H__
#define __VIENNA_RNA_PACKAGE_DATA_STRUCTURES_H__

#include "vienna.h"
#include "energy_const.h"

/** Maximal length of alphabet */
#define MAXALPHA              20

/** Maximum density of states discretization for subopt */
#define MAXDOS                1000

/** stack of partial structures for backtracking */
typedef struct sect { int i,j,ml; } sect;

/** base pair */
typedef struct bondT { unsigned int i,j; } bondT;

#endif
