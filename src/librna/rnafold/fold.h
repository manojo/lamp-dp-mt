#ifndef __VIENNA_RNA_PACKAGE_FOLD_H__
#define __VIENNA_RNA_PACKAGE_FOLD_H__

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
 *  If the third parameter is NULL, global model detail settings are assumed for the folding
 *  recursions. Otherwise, the provided parameters are used.
 *
 *  After a successful call of fold_par(), a backtracked secondary structure (in dot-bracket notation)
 *  that exhibits the minimum of free energy will be written to the memory \a structure is pointing to.
 *  The function returns the minimum of free energy for any fold of the sequence given.
 *
 *  \param sequence       RNA sequence
 *  \param structure      A pointer to the character array where the
 *                        secondary structure in dot-bracket notation will be written to
 *  \param parameters     A data structure containing the prescaled energy contributions
 *                        and the model details. (NULL may be passed, see OpenMP notes above)
 *  \return the minimum free energy (MFE) in kcal/mol
 */
float fold_par( const char *sequence, char *structure, paramT *parameters);

/** Free arrays for mfe folding */
void  free_arrays(void);

/** Create a dot-backet/parenthesis structure from backtracking stack */
void  parenthesis_structure(char *structure, bondT *bp, int length);

/** Recalculate energy parameters */
void update_fold_params_par(paramT *parameters);

#endif
