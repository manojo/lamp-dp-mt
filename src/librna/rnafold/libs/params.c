/*

                  c Ivo Hofacker

                  Vienna RNA package
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "energy_par.h"
#include "fold_vars.h"
#include "utils.h"
#include "params.h"
/**
*** \file params.c
*** <P>
*** This file provides functions that return temperature scaled energy parameters and
*** Boltzmann weights packed in datastructures
*** </P>
***/

/*@unused@*/
//static char rcsid[] UNUSED = "$Id: params.c,v 1.9 2008/07/04 14:29:14 ivo Exp $";

/*------------------------------------------------------------------------*/
#define SCALE 10
/**
*** dangling ends should never be destabilizing, i.e. expdangle>=1<BR>
*** specific heat needs smooth function (2nd derivative)<BR>
*** we use a*(sin(x+b)+1)^2, with a=2/(3*sqrt(3)), b=Pi/6-sqrt(3)/2,
*** in the interval b<x<sqrt(3)/2
*/
#define SMOOTH(X) ((X)/SCALE<-1.2283697)?0:(((X)/SCALE>0.8660254)?(X):\
          SCALE*0.38490018*(sin((X)/SCALE-0.34242663)+1)*(sin((X)/SCALE-0.34242663)+1))

/* #define SMOOTH(X) ((X)<0 ? 0 : (X)) */


PUBLIC pf_paramT *get_boltzmann_factors(double temperature,
                                        double betaScale,
                                        model_detailsT md,
                                        double pf_scale){

  unsigned  int i, j, k, l;
  double        kT, TT;
  double        GT;
  pf_paramT     *pf;

  pf                = (pf_paramT *)space(sizeof(pf_paramT));
  pf->model_details = md;
  pf->temperature   = temperature;
  pf->alpha         = betaScale;
  pf->kT = kT       = betaScale*(temperature+K0)*GASCONST;   /* kT in cal/mol  */
  pf->pf_scale      = pf_scale;
  TT                = (temperature+K0)/(Tmeasure);

   /* loop energies: hairpins, bulges, interior, mulit-loops */
  for (i=0; i<31; i++){
    GT  = hairpindH[i] - (hairpindH[i] - hairpin37[i])*TT;
    pf->exphairpin[i] = exp( -GT*10./kT);
  }

  for (i=0; i<=MIN2(30, MAXLOOP); i++) {
    GT =  bulgedH[i]- (bulgedH[i] - bulge37[i])*TT;
    pf->expbulge[i] = exp( -GT*10./kT);
    GT =  internal_loopdH[i] - (internal_loopdH[i] - internal_loop37[i])*TT;
    pf->expinternal[i] = exp( -GT*10./kT);
  }
  /* special case of size 2 interior loops (single mismatch) */
  if (james_rule) pf->expinternal[2] = exp ( -80*10./kT);

  pf->lxc = lxc37*TT;

  GT =  DuplexInitdH - (DuplexInitdH - DuplexInit37)*TT;
  pf->expDuplexInit = exp( -GT*10./kT);

  for (i=31; i<=MAXLOOP; i++) {
    GT = bulge37[30]*TT + (pf->lxc*log( i/30.));
    pf->expbulge[i] = exp( -GT*10./kT);
    GT = internal_loop37[30]*TT + (pf->lxc*log( i/30.));
    pf->expinternal[i] = exp( -GT*10./kT);
  }

  GT = niniodH - (niniodH - ninio37)*TT;
  for (j=0; j<=MAXLOOP; j++)
      pf->expninio[2][j]=exp(-MIN2(MAX_NINIO,j*GT)*10./kT);

  for (i=0; (i*7)<strlen(Tetraloops); i++) {
    GT = TetraloopdH[i] - (TetraloopdH[i]-Tetraloop37[i])*TT;
    pf->exptetra[i] = exp( -GT*10./kT);
  }
  for (i=0; (i*5)<strlen(Triloops); i++) {
    GT = TriloopdH[i] - (TriloopdH[i]-Triloop37[i])*TT;
    pf->exptri[i] = exp( -GT*10./kT);
  }
  for (i=0; (i*9)<strlen(Hexaloops); i++) {
    GT = HexaloopdH[i] - (HexaloopdH[i]-Hexaloop37[i])*TT;
    pf->exphex[i] = exp( -GT*10./kT);
  }
  GT =  ML_closingdH - (ML_closingdH - ML_closing37)*TT;
  pf->expMLclosing = exp( -GT*10./kT);

  for (i=0; i<=NBPAIRS; i++) { /* includes AU penalty */
    GT =  ML_interndH - (ML_interndH - ML_intern37)*TT;
    /* if (i>2) GT += TerminalAU; */
    pf->expMLintern[i] = exp( -GT*10./kT);
  }
  GT = TerminalAUdH - (TerminalAUdH - TerminalAU37)*TT;
  pf->expTermAU = exp(-GT*10./kT);

  GT = ML_BASEdH - (ML_BASEdH - ML_BASE37)*TT;

  pf->expMLbase=exp(-10.*GT/kT);


  /* if dangles==0 just set their energy to 0,
     don't let dangle energies become > 0 (at large temps),
     but make sure go smoothly to 0                        */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<=4; j++) {
      if (md.dangles) {
        GT = dangle5_dH[i][j] - (dangle5_dH[i][j] - dangle5_37[i][j])*TT;
        pf->expdangle5[i][j] = exp(SMOOTH(-GT)*10./kT);
        GT = dangle3_dH[i][j] - (dangle3_dH[i][j] - dangle3_37[i][j])*TT;
        pf->expdangle3[i][j] =  exp(SMOOTH(-GT)*10./kT);
      } else
        pf->expdangle3[i][j] = pf->expdangle5[i][j] = 1;
    }

  /* stacking energies */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<=NBPAIRS; j++) {
      GT =  stackdH[i][j] - (stackdH[i][j] - stack37[i][j])*TT;
      pf->expstack[i][j] = exp( -GT*10./kT);
    }

  /* mismatch energies */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<5; j++)
      for (k=0; k<5; k++) {
        GT =  mismatchIdH[i][j][k] - ( mismatchIdH[i][j][k] - mismatchI37[i][j][k])*TT;
        pf->expmismatchI[i][j][k] = exp(-GT*10.0/kT);
        GT = mismatch1nIdH[i][j][k] - (mismatch1nIdH[i][j][k] - mismatch1nI37[i][j][k])*TT;
        pf->expmismatch1nI[i][j][k] = exp(-GT*10.0/kT);
        GT = mismatchHdH[i][j][k] - (mismatchHdH[i][j][k] - mismatchH37[i][j][k])*TT;
        pf->expmismatchH[i][j][k] = exp(-GT*10.0/kT);
        if (md.dangles) {
          GT = mismatchMdH[i][j][k] - (mismatchMdH[i][j][k] - mismatchM37[i][j][k])*TT;
          pf->expmismatchM[i][j][k] = exp(SMOOTH(-GT)*10.0/kT);
          GT = mismatchExtdH[i][j][k] - (mismatchExtdH[i][j][k] - mismatchExt37[i][j][k])*TT;
          pf->expmismatchExt[i][j][k] = exp(SMOOTH(-GT)*10.0/kT);
        }
        else{
          pf->expmismatchM[i][j][k] = pf->expmismatchExt[i][j][k] = 1.;
        }
        GT = mismatch23IdH[i][j][k] - (mismatch23IdH[i][j][k] - mismatch23I37[i][j][k])*TT;
        pf->expmismatch23I[i][j][k] = exp(-GT*10.0/kT);
      }

  /* interior lops of length 2 */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<=NBPAIRS; j++)
      for (k=0; k<5; k++)
        for (l=0; l<5; l++) {
          GT = int11_dH[i][j][k][l] -
            (int11_dH[i][j][k][l] - int11_37[i][j][k][l])*TT;
          pf->expint11[i][j][k][l] = exp(-GT*10./kT);
        }
  /* interior 2x1 loops */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<=NBPAIRS; j++)
      for (k=0; k<5; k++)
        for (l=0; l<5; l++) {
          int m;
          for (m=0; m<5; m++) {
            GT = int21_dH[i][j][k][l][m] -
              (int21_dH[i][j][k][l][m] - int21_37[i][j][k][l][m])*TT;
            pf->expint21[i][j][k][l][m] = exp(-GT*10./kT);
          }
        }

  /* interior 2x2 loops */
  for (i=0; i<=NBPAIRS; i++)
    for (j=0; j<=NBPAIRS; j++)
      for (k=0; k<5; k++)
        for (l=0; l<5; l++) {
          int m,n;
          for (m=0; m<5; m++)
            for (n=0; n<5; n++) {
              GT = int22_dH[i][j][k][l][m][n] -
                (int22_dH[i][j][k][l][m][n]-int22_37[i][j][k][l][m][n])*TT;
              pf->expint22[i][j][k][l][m][n] = exp(-GT*10./kT);
            }
        }

  strncpy(pf->Tetraloops, Tetraloops, 281);
  strncpy(pf->Triloops, Triloops, 241);
  strncpy(pf->Hexaloops, Hexaloops, 361);

  return pf;
}

PUBLIC pf_paramT *get_boltzmann_factor_copy(pf_paramT *par){
  pf_paramT *copy = NULL;
  if(par){
    copy = (pf_paramT *) space(sizeof(pf_paramT));
    memcpy(copy, par, sizeof(pf_paramT));
  }
  return copy;
}

PUBLIC paramT *get_parameter_copy(paramT *par){
  paramT *copy = NULL;
  if(par){
    copy = (paramT *) space(sizeof(paramT));
    memcpy(copy, par, sizeof(paramT));
  }
  return copy;
}
