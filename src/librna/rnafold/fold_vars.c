#include <string.h>
#include <stdio.h>
#include "fold_vars.h"

int         noGU = 0;             /* GU not allowed at all */

int         no_closingGU = 0;     /* GU allowed only inside stacks */

int         tetra_loop = 1;       /* Fold with specially stable 4-loops */

int         energy_set = 0;       /* 0 = BP; 1=any with GC; 2=any with AU parameters */

int         dangles = 2;          /* use dangling end energies */

int         noLonelyPairs = 1;    /* avoid helices of length 1 */

char        backtrack_type = 'F'; /* 'C' require (1,N) to be bonded;
                                    'M' seq is part of s multi loop */

PUBLIC char * option_string(void){
  static char options[100];
  *options = '\0';
  if (noGU) strcat(options, "-noGU ");
  if (no_closingGU) strcat(options, "-noCloseGU ");
  if (!tetra_loop) strcat(options, "-4 ");
  if (noLonelyPairs) strcat(options, "-noLP ");
  if (dangles!=1) sprintf(options+strlen(options), "-d%d ", dangles);
  if (temperature!=37.0)
    sprintf(options+strlen(options), "-T %f ", temperature);
  return options;
}

PUBLIC void set_model_details(model_detailsT *md){
  if(md){
    md->dangles     = dangles;
    md->special_hp  = tetra_loop;
    md->noLP        = noLonelyPairs;
    md->noGU        = noGU;
    md->noGUclosure = no_closingGU;
    md->logML       = logML;
  }
}
