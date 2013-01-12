#ifndef __VIENNA_RNA_PACKAGE_FOLD_VARS_H__
#define __VIENNA_RNA_PACKAGE_FOLD_VARS_H__

#include "data_structures.h"

#define PUBLIC
#define PRIVATE static

/**
 *  \brief Global switch to avoid/allow helices of length 1
 *
 *  Disallow all pairs which can only occur as lonely pairs (i.e. as helix
 *  of length 1). This avoids lonely base pairs in the predicted structures in
 *  most cases.
 */
extern int    noLonelyPairs;

/**
 *  \brief Switch the energy model for dangling end contributions (0, 1, 2, 3)
 *  If #dangles is set to 2, all folding routines will follow this convention.
 *  This treatment of dangling ends gives more favorable energies to helices
 *  directly adjacent to one another, which can be beneficial since such
 *  helices often do engage in stabilizing interactions through co-axial
 *  stacking.
 *
 *  Default is 2 in most algorithms, partition function algorithms can only handle 0 and 2
 */
extern int  dangles;

/**
 *  \brief Global switch to forbid/allow GU base pairs at all
 */
extern int  noGU;

/**
 *  \brief GU allowed only inside stacks if set to 1
 */
extern int  no_closingGU;

/**
 *  \brief Include special stabilizing energies for some tri-, tetra- and hexa-loops;
 *
 *  default is 1.
 */
extern int  tetra_loop;

/**
 *  \brief 0 = BP; 1=any mit GC; 2=any mit AU-parameter
 *
 *  If set to 1 or 2: fold sequences from an artificial alphabet ABCD..., where A
 *  pairs B, C pairs D, etc. using either GC (1) or AU parameters (2);
 *  default is 0, you probably don't want to change it.
 */
extern int  energy_set;

/**
 *  \brief Rescale energy parameters to a temperature in degC.
 *
 *  Default is 37C. You have to call the update_..._params() functions after
 *  changing this parameter.
 */
extern double temperature;

/**
 *  use logarithmic multiloop energy function
 */
extern int  logML;

/**
 *  \brief do backtracking, i.e. compute secondary structures or base pair probabilities
 *
 *  If 0, do not calculate pair probabilities in pf_fold(); this is about
 *  twice as fast. Default is 1.
 */
extern int    do_backtrack;

/**
 *  \brief A backtrack array marker for inverse_fold()
 *
 *  If set to 'C': force (1,N) to be paired,
 *  'M' fold as if the sequence were inside a multi-loop. Otherwise ('F') the
 *  usual mfe structure is computed.
 */
extern char backtrack_type;

char * option_string(void);

/** Set default model details */
void set_model_details(model_detailsT *md);

#endif
