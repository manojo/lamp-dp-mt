/* Last changed Time-stamp: <2007-12-05 13:55:42 ronny> */
/*
                  Ineractive Access to folding Routines

                  c Ivo L Hofacker
                  Vienna RNA package
*/

/** \file
*** \brief RNAfold program source code
***
*** This code provides an interface for MFE and Partition function folding
*** of single linear RNA molecules.
**/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <unistd.h>
#include <string.h>
#include "fold.h"
#include "fold_vars.h"
#include "utils.h"

/*--------------------------------------------------------------------------*/

int main(int argc, char *argv[]){
  char          *buf, *rec_sequence, *rec_id, **rec_rest, *structure, *cstruc, *orig_sequence;
  char          fname[FILENAME_MAX_LENGTH], ffname[FILENAME_MAX_LENGTH], *ParamFile;
  char          *ns_bases, *c;
  int           i, length, l, cl, sym;
  unsigned int  rec_type, read_opt;
  double        min_en, sfact;
  double        bppmThreshold, betaScale;
  model_detailsT  md;

  rec_type      = read_opt = 0;
  rec_id        = buf = rec_sequence = structure = cstruc = orig_sequence = NULL;
  rec_rest      = NULL;
  ParamFile     = NULL;
  ns_bases      = NULL;
  do_backtrack  = 1;
  sfact         = 1.07;
  cl            = l = length = 0;
  dangles       = 2;
  bppmThreshold = 1e-5;
  betaScale     = 1.;

  set_model_details(&md);

  /*
  #############################################
  # begin initializing
  #############################################
  */
  if (argc>1) ParamFile=argv[1];
  if (ParamFile != NULL) read_parameter_file(ParamFile);
  // printf("%s\n",option_string());

  if (ns_bases != NULL) {
    nonstandards = space(33);
    c=ns_bases;
    i=sym=0;
    if (*c=='-') {
      sym=1; c++;
    }
    while (*c!='\0') {
      if (*c!=',') {
        nonstandards[i++]=*c++;
        nonstandards[i++]=*c;
        if ((sym)&&(*c!=*(c-1))) {
          nonstandards[i++]=*c;
          nonstandards[i++]=*(c-1);
        }
      }
      c++;
    }
  }

  /* set options we wanna pass to read_record */
  read_opt |= VRNA_INPUT_NO_REST;

  /*
  #############################################
  # main loop: continue until end of file
  #############################################
  */
  while(
    !((rec_type = read_record(&rec_id, &rec_sequence, &rec_rest, read_opt))
        & (VRNA_INPUT_ERROR | VRNA_INPUT_QUIT))){

    /*
    ########################################################
    # init everything according to the data we've read
    ########################################################
    */
    if(rec_id){
      printf("%s\n", rec_id);
      sscanf(rec_id, ">%" XSTR(FILENAME_ID_LENGTH) "s", fname);
    }
    else fname[0] = '\0';

    length  = (int)strlen(rec_sequence);
    structure = (char *)space(sizeof(char) *(length+1));

    /* store case-unmodified sequence */
    orig_sequence = strdup(rec_sequence);
    /* convert sequence to uppercase letters only */
    str_uppercase(rec_sequence);

    /*
    ########################################################
    # begin actual computations
    ########################################################
    */
    min_en = fold(rec_sequence, structure);

    printf("%s\n%s", orig_sequence, structure);
    printf(" (%6.2f)\n", min_en);
    (void) fflush(stdout);

      if(fname[0] != '\0'){
        strcpy(ffname, fname);
        strcat(ffname, "_ss.ps");
      } else strcpy(ffname, "rna.ps");

    if (length>2000) free_arrays();
    (void) fflush(stdout);

    /* clean up */
    if(cstruc) free(cstruc);
    if(rec_id) free(rec_id);
    free(rec_sequence);
    free(orig_sequence);
    free(structure);
    /* free the rest of current dataset */
    if(rec_rest){
      for(i=0;rec_rest[i];i++) free(rec_rest[i]);
      free(rec_rest);
    }
    rec_id = rec_sequence = structure = cstruc = NULL;
    rec_rest = NULL;
  }
  return EXIT_SUCCESS;
}
