#ifndef __VIENNA_H__
#define __VIENNA_H__

/*
Disclaimer and Copyright

The programs, library and source code of the Vienna RNA Package are free
software. They are distributed in the hope that they will be useful
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Permission is granted for research, educational, and commercial use
and modification so long as 1) the package and any derived works are not
redistributed for any fee, other than media costs, 2) proper credit is
given to the authors and the Institute for Theoretical Chemistry of the
University of Vienna.

If you want to include this software in a commercial product, please contact
the authors.
*/

#include "energy_const.h"

#ifndef NBASES
#define NBASES 8
#endif

extern double temperature;

/** The data structure that contains the complete model details used throughout the calculations */
typedef struct{
  char dangles;      /*  dangle model (0,1,2 or 3) */
  char special_hp;   /*  include special hairpin contributions for tri, tetra and hexaloops */
  char noLP;         /*  only consider canonical structures, i.e. no 'lonely' base pairs */
  char noGU;         /*  do not allow GU pairs */
  char noGUclosure;  /*  do not allow loops to be closed by GU pair */
  char logML;        /*  use logarithmic scaling for multi loops */
} model_detailsT;

/** The datastructure that contains temperature scaled energy parameters. */
typedef struct {
  int id;
  short stack[NBPAIRS+1][NBPAIRS+1];
  short hairpin[31];
  short bulge[MAXLOOP+1];
  short internal_loop[MAXLOOP+1];
  short mismatchExt[NBPAIRS+1][5][5];
  short mismatchI[NBPAIRS+1][5][5];
  short mismatch1nI[NBPAIRS+1][5][5];
  short mismatch23I[NBPAIRS+1][5][5];
  short mismatchH[NBPAIRS+1][5][5];
  short mismatchM[NBPAIRS+1][5][5];
  short dangle5[NBPAIRS+1][5];
  short dangle3[NBPAIRS+1][5];
  short int11[NBPAIRS+1][NBPAIRS+1][5][5];
  short int21[NBPAIRS+1][NBPAIRS+1][5][5][5];
  short int22[NBPAIRS+1][NBPAIRS+1][5][5][5][5];
  int ninio[2]; // ViennaRNA(ninio[2], MAX_NINIO) ==> (ninio[0], ninio[1])
  double  lxc;
  short   MLbase;
  short   MLintern[NBPAIRS+1];
  short   MLclosing;
  short   TerminalAU;
  short   DuplexInit;
  short   Tetraloop_E[200];
  char    Tetraloops[1401];
  short   TetraloopsLen; // added
  short   Triloop_E[40];
  char    Triloops[241];
  short   TriloopsLen; // added
  short   Hexaloop_E[40];
  char    Hexaloops[1801];
  short   HexaloopsLen; // added
  short   TripleC;
  short   MultipleCA;
  short   MultipleCB;
  double  temperature;  /*  temperature used for loop contribution scaling */
  model_detailsT model_details;
} paramT;

void read_parameter_file(const char *filename);
paramT *get_scaled_parameters();

#endif
