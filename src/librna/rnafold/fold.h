#ifndef __VIENNA_RNA_PACKAGE_FOLD_H__
#define __VIENNA_RNA_PACKAGE_FOLD_H__

#include "data_structures.h"

/**
 *  \file fold.h
 *  \brief MFE calculations and energy evaluations for single RNA sequences
 *
 *  This file includes (almost) all function declarations within the RNAlib that are related to
 *  MFE folding...
 */

/** \brief if nonzero use logarithmic ML energy in energy_of_struct  */
extern  int logML;

/** \brief do ML decomposition uniquely (for subopt)  */
extern  int uniq_ML;

/** brief verbose info from energy_of_struct  */
extern  int eos_debug;

/**
 *  \brief Compute minimum free energy and an appropriate secondary
 *  structure of an RNA sequence
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
 *  The fourth parameter indicates whether a secondary structure constraint in enhanced dot-bracket
 *  notation is passed through the structure parameter or not. If so, the characters " | x < > " are
 *  recognized to mark bases that are paired, unpaired, paired upstream, or downstream, respectively.
 *  Matching brackets " ( ) " denote base pairs, dots "." are used for unconstrained bases.
 *
 *  To indicate that the RNA sequence is circular and thus has to be post-processed, set the last
 *  parameter to non-zero
 *
 *  After a successful call of fold_par(), a backtracked secondary structure (in dot-bracket notation)
 *  that exhibits the minimum of free energy will be written to the memory \a structure is pointing to.
 *  The function returns the minimum of free energy for any fold of the sequence given.
 *
 *  \note OpenMP: Passing NULL to the 'parameters' argument involves access to several global model
 *        detail variables and thus is not to be considered threadsafe
 *
 *  \see fold(), #model_detailsT, set_energy_model(), get_scaled_parameters()
 *
 *  \param sequence       RNA sequence
 *  \param structure      A pointer to the character array where the
 *                        secondary structure in dot-bracket notation will be written to
 *  \param parameters     A data structure containing the prescaled energy contributions
 *                        and the model details. (NULL may be passed, see OpenMP notes above)
 *  \return the minimum free energy (MFE) in kcal/mol
 */
float fold_par( const char *sequence,
                char *structure,
                paramT *parameters);

/**
 *  \brief Calculate the free energy of an already folded RNA using global model detail settings
 *
 *  If verbosity level is set to a value >0, energies of structure elements are printed to stdout
 *
 *  \note OpenMP: This function relies on several global model settings variables and thus is
 *        not to be considered threadsafe. See energy_of_struct_par() for a completely threadsafe
 *        implementation.
 *
 *  \see energy_of_struct_par()
 *
 *  \param string     RNA sequence
 *  \param structure  secondary structure in dot-bracket notation
 *  \param verbosity_level a flag to turn verbose output on/off
 *  \return          the free energy of the input structure given the input sequence in kcal/mol
 */
float energy_of_structure(const char *string,
                          const char *structure,
                          int verbosity_level);

/**
 *  \brief Calculate the free energy of an already folded RNA
 *
 *  If verbosity level is set to a value >0, energies of structure elements are printed to stdout
 *
 *  \see energy_of_structure_pt(), get_scaled_parameters()
 *
 *  \param string           RNA sequence in uppercase letters
 *  \param structure        Secondary structure in dot-bracket notation
 *  \param parameters       A data structure containing the prescaled energy contributions and the model details.
 *  \param verbosity_level  A flag to turn verbose output on/off
 *  \return                The free energy of the input structure given the input sequence in kcal/mol
 */
float energy_of_struct_par( const char *string,
                            const char *structure,
                            paramT *parameters,
                            int verbosity_level);

/**
 *  \brief Free arrays for mfe folding
 */
void  free_arrays(void);


/**
 *  \brief Create a dot-backet/parenthesis structure from backtracking stack
 *
 *  \note This function is threadsafe
 */
void  parenthesis_structure(char *structure,
                            bondT *bp,
                            int length);

/**
 *  \brief Recalculate energy parameters
 */
void update_fold_params_par(paramT *parameters);

#endif
