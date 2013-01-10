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
*** of single linear or circular RNA molecules.
**/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <unistd.h>
#include <string.h>
#include "fold.h"
#include "part_func.h"
#include "fold_vars.h"
#include "utils.h"
#include "params.h"

/*--------------------------------------------------------------------------*/

int main(int argc, char *argv[]){
  char          *buf, *rec_sequence, *rec_id, **rec_rest, *structure, *cstruc, *orig_sequence;
  char          fname[FILENAME_MAX_LENGTH], ffname[FILENAME_MAX_LENGTH], *ParamFile;
  char          *ns_bases, *c;
  int           i, length, l, cl, sym, istty, pf, noPS, noconv, fasta;
  unsigned int  rec_type, read_opt;
  double        energy, min_en, kT, sfact;
  int           circular, lucky;
  double        bppmThreshold, betaScale;
  pf_paramT       *pf_parameters;
  model_detailsT  md;

  rec_type      = read_opt = 0;
  rec_id        = buf = rec_sequence = structure = cstruc = orig_sequence = NULL;
  rec_rest      = NULL;
  ParamFile     = NULL;
  ns_bases      = NULL;
  pf_parameters = NULL;
  do_backtrack  = 1;
  pf            = 0;
  sfact         = 1.07;
  noPS          = 0;
  noconv        = 0;
  circular      = 0;
  fasta         = 0;
  cl            = l = length = 0;
  dangles       = 2;
  bppmThreshold = 1e-5;
  lucky         = 0;
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

  if (circular && noLonelyPairs)
    warn_user("depending on the origin of the circular sequence, some structures may be missed when using -noLP\nTry rotating your sequence a few times");

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

  istty = isatty(fileno(stdout))&&isatty(fileno(stdin));

  /* print user help if we get input from tty */
  if(istty){
    if(fold_constrained){
      print_tty_constraint_full();
      print_tty_input_seq_str("Input sequence (upper or lower case) followed by structure constraint");
    }
    else print_tty_input_seq();
  }

  /* set options we wanna pass to read_record */
  if(istty)             read_opt |= VRNA_INPUT_NOSKIP_BLANK_LINES;
  if(!fold_constrained) read_opt |= VRNA_INPUT_NO_REST;

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
      if(!istty) printf("%s\n", rec_id);
      (void) sscanf(rec_id, ">%" XSTR(FILENAME_ID_LENGTH) "s", fname);
    }
    else fname[0] = '\0';

    length  = (int)strlen(rec_sequence);
    structure = (char *)space(sizeof(char) *(length+1));

    /* parse the rest of the current dataset to obtain a structure constraint */
    if(fold_constrained){
      cstruc = NULL;
      unsigned int coptions = (rec_id) ? VRNA_CONSTRAINT_MULTILINE : 0;
      coptions |= VRNA_CONSTRAINT_ALL;
      getConstraint(&cstruc, (const char **)rec_rest, coptions);
      cl = (cstruc) ? (int)strlen(cstruc) : 0;

      if(cl == 0)           warn_user("structure constraint is missing");
      else if(cl < length)  warn_user("structure constraint is shorter than sequence");
      else if(cl > length)  nrerror("structure constraint is too long");
      if(cstruc) strncpy(structure, cstruc, sizeof(char)*(cl+1));
    }

    /* convert DNA alphabet to RNA if not explicitely switched off */
    if(!noconv) str_DNA2RNA(rec_sequence);
    /* store case-unmodified sequence */
    orig_sequence = strdup(rec_sequence);
    /* convert sequence to uppercase letters only */
    str_uppercase(rec_sequence);

    if(istty) printf("length = %d\n", length);

    /*
    ########################################################
    # begin actual computations
    ########################################################
    */
    min_en = (circular) ? circfold(rec_sequence, structure) : fold(rec_sequence, structure);

    if(!lucky){
      printf("%s\n%s", orig_sequence, structure);
      if (istty)
        printf("\n minimum free energy = %6.2f kcal/mol\n", min_en);
      else
        printf(" (%6.2f)\n", min_en);
      (void) fflush(stdout);

      if(fname[0] != '\0'){
        strcpy(ffname, fname);
        strcat(ffname, "_ss.ps");
      } else strcpy(ffname, "rna.ps");

    }
    if (length>2000) free_arrays();
    if (pf) {
      char *pf_struc = (char *) space((unsigned) length+1);
      if (md.dangles==1) {
          md.dangles=2;   /* recompute with dangles as in pf_fold() */
          min_en = (circular) ? energy_of_circ_structure(rec_sequence, structure, 0) : energy_of_structure(rec_sequence, structure, 0);
          md.dangles=1;
      }

      /* */

      kT = (betaScale*((temperature+K0)*GASCONST))/1000.; /* in Kcal */
      pf_scale = exp(-(sfact*min_en)/kT/length);
      if (length>2000) fprintf(stderr, "scaling factor %f\n", pf_scale);

      if (cstruc!=NULL) strncpy(pf_struc, cstruc, length+1);

      pf_parameters = get_boltzmann_factors(temperature, betaScale, md, pf_scale);
      energy = pf_fold_par(rec_sequence, pf_struc, pf_parameters, do_backtrack, fold_constrained, circular);

      if(lucky){
        init_rand();
        char *s = (circular) ? pbacktrack_circ(rec_sequence) : pbacktrack(rec_sequence);
        min_en = (circular) ? energy_of_circ_structure(rec_sequence, s, 0) : energy_of_structure(rec_sequence, s, 0);
        printf("%s\n%s", orig_sequence, s);
        if (istty)
          printf("\n free energy = %6.2f kcal/mol\n", min_en);
        else
          printf(" (%6.2f)\n", min_en);
        (void) fflush(stdout);
        if(fname[0] != '\0'){
          strcpy(ffname, fname);
          strcat(ffname, "_ss.ps");
        } else strcpy(ffname, "rna.ps");

        free(s);
      }
      else{

        if (do_backtrack) {
          printf("%s", pf_struc);
          if (!istty) printf(" [%6.2f]\n", energy);
          else printf("\n");
        }
        if ((istty)||(!do_backtrack))
          printf(" free energy of ensemble = %6.2f kcal/mol\n", energy);


        if (do_backtrack) {
          plist *pl1,*pl2;
          char *cent;
          double dist, cent_en;
          FLT_OR_DBL *probs = export_bppm();
          assign_plist_from_pr(&pl1, probs, length, bppmThreshold);
          assign_plist_from_db(&pl2, structure, 0.95*0.95);
          /* cent = centroid(length, &dist); <- NOT THREADSAFE */
          cent = get_centroid_struct_pr(length, &dist, probs);
          cent_en = (circular) ? energy_of_circ_structure(rec_sequence, cent, 0) :energy_of_structure(rec_sequence, cent, 0);
          printf("%s {%6.2f d=%.2f}\n", cent, cent_en, dist);
          free(cent);
          if (fname[0]!='\0') {
            strcpy(ffname, fname);
            strcat(ffname, "_dp.ps");
          } else strcpy(ffname, "dot.ps");
          free(pl2);
          if (do_backtrack==2) {
            pl2 = stackProb(1e-5);
            if (fname[0]!='\0') {
              strcpy(ffname, fname);
              strcat(ffname, "_dp2.ps");
            } else strcpy(ffname, "dot2.ps");
            free(pl2);
          }
          free(pl1);
          free(pf_struc);
        }
        printf(" frequency of mfe structure in ensemble %g; ", exp((energy-min_en)/kT));
        if (do_backtrack)
          printf("ensemble diversity %-6.2f", mean_bp_distance(length));
        printf("\n");
      }
      free_pf_arrays();
      free(pf_parameters);
    }
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

    /* print user help for the next round if we get input from tty */
    if(istty){
      if(fold_constrained){
        print_tty_constraint_full();
        print_tty_input_seq_str("Input sequence (upper or lower case) followed by structure constraint");
      }
      else print_tty_input_seq();
    }
  }
  return EXIT_SUCCESS;
}
