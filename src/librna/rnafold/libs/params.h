#ifndef __VIENNA_RNA_PACKAGE_PARAMS_H__
#define __VIENNA_RNA_PACKAGE_PARAMS_H__

#include "energy_const.h"
#include "data_structures.h"

/**
 *  \file params.h
 *  \brief Several functions to obtain (pre)scaled energy parameter data containers
 */

paramT *get_parameter_copy(paramT *par);

/**
 *  \brief Get precomputed Boltzmann factors of the loop type
 *  dependent energy contributions with independent thermodynamic
 *  temperature
 *
 *  This function returns a data structure that contains
 *  all necessary precalculated Boltzmann factors for each
 *  loop type contribution.<br>
 *  In contrast to get_scaled_pf_parameters(), this function
 *  enables setting of independent temperatures for both, the
 *  individual energy contributions as well as the thermodynamic
 *  temperature used in
 *  \f$ exp(-\Delta G / kT) \f$
 *
 *  \see get_scaled_pf_parameters(), get_boltzmann_factor_copy()
 *
 *  \param  dangle_model  The dangle model to be used (possible values: 0 or 2)
 *  \param  temperature   The temperature in degC used for (re-)scaling the energy contributions
 *  \param  alpha         A scaling value that is used as a multiplication factor for the absolute
 *                        temperature of the system
 *  \return               A set of precomputed Boltzmann factors
 */
pf_paramT *get_boltzmann_factors( double temperature,
                                  double betaScale,
                                  model_detailsT md,
                                  double pf_scale);

/**
 *  \brief Get a copy of already precomputed Boltzmann factors
 *
 *  \see get_boltzmann_factors(), get_scaled_pf_parameters()
 *
 *  \param  parameters  The input data structure that shall be copied
 *  \return             A copy of the provided Boltzmann factor dataset
 */
pf_paramT *get_boltzmann_factor_copy(pf_paramT *parameters);

#endif
