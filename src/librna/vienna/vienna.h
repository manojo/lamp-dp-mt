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
extern int  MAX_NINIO;

/** The data structure that contains the complete model details used throughout the calculations */
typedef struct{
  int     dangles;      /*  dangle model (0,1,2 or 3) */
  int     special_hp;   /*  include special hairpin contributions for tri, tetra and hexaloops */
  int     noLP;         /*  only consider canonical structures, i.e. no 'lonely' base pairs */
  int     noGU;         /*  do not allow GU pairs */
  int     noGUclosure;  /*  do not allow loops to be closed by GU pair */
  int     logML;        /*  use logarithmic scaling for multi loops */
} model_detailsT;

/** The datastructure that contains temperature scaled energy parameters. */
typedef struct {
  int id;
  int stack[NBPAIRS+1][NBPAIRS+1];
  int hairpin[31];
  int bulge[MAXLOOP+1];
  int internal_loop[MAXLOOP+1];
  int mismatchExt[NBPAIRS+1][5][5];
  int mismatchI[NBPAIRS+1][5][5];
  int mismatch1nI[NBPAIRS+1][5][5];
  int mismatch23I[NBPAIRS+1][5][5];
  int mismatchH[NBPAIRS+1][5][5];
  int mismatchM[NBPAIRS+1][5][5];
  int dangle5[NBPAIRS+1][5];
  int dangle3[NBPAIRS+1][5];
  int int11[NBPAIRS+1][NBPAIRS+1][5][5];
  int int21[NBPAIRS+1][NBPAIRS+1][5][5][5];
  int int22[NBPAIRS+1][NBPAIRS+1][5][5][5][5];
  int ninio[2]; // ViennaRNA(ninio[2], MAX_NINIO) ==> (ninio[0], ninio[1])
  double  lxc;
  int     MLbase;
  int     MLintern[NBPAIRS+1];
  int     MLclosing;
  int     TerminalAU;
  int     DuplexInit;
  int     Tetraloop_E[200];
  char    Tetraloops[1401];
  int     Triloop_E[40];
  char    Triloops[241];
  int     Hexaloop_E[40];
  char    Hexaloops[1801];
  int     TripleC;
  int     MultipleCA;
  int     MultipleCB;
  double  temperature;  /*  temperature used for loop contribution scaling */
  model_detailsT model_details;
} paramT;

void read_parameter_file(const char *filename);
paramT *get_scaled_parameters();

#endif
