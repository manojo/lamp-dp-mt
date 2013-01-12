/* Interface for MFE and Partition function folding of single linear RNA molecules. */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <unistd.h>
#include <string.h>
#include "fold.h"

#define VRNA_INPUT_ERROR                  1U
#define VRNA_INPUT_QUIT                   2U
#define VRNA_INPUT_MISC                   4U
#define VRNA_INPUT_FASTA_HEADER           8U
#define VRNA_INPUT_SEQUENCE               16U
#define VRNA_INPUT_NO_REST                512U
#define VRNA_INPUT_BLANK_LINE             4096U

#define space(S) calloc(1,(S))

void  *xrealloc(void *p, unsigned size);
void nrerror(const char message[]);
unsigned int read_record( char **header, char **sequence, char ***rest);
void  str_uppercase(char *sequence);
int   *get_indx(unsigned int length);
void set_model_details(model_detailsT *md);

#define PRIVATE static
#define PUBLIC

PRIVATE char  *inbuf = NULL;
PRIVATE char  *inbuf2 = NULL;
PRIVATE unsigned int typebuf2 = 0;

/*-------------------------------------------------------------------------*/

void *xrealloc (void *p, unsigned size) {
  if (p == 0) return space(size);
  p = (void *) realloc(p, size);
  if (p == NULL) {
    fprintf(stderr,"xrealloc: requested size: %d\n", size);
    nrerror("xrealloc allocation failure -> no memory");
  }
  return p;
}

/*------------------------------------------------------------------------*/

PUBLIC void nrerror(const char message[]) {      /* output message upon error */
  fprintf(stderr, "ERROR: %s\n", message); exit(EXIT_FAILURE);
}

/*------------------------------------------------------------------------*/

PRIVATE char *get_line(FILE *fp) { /* reads lines of arbitrary length from fp */
  char s[512], *line, *cp;
  int len=0, size=0, l;
  line=NULL;
  do {
    if (fgets(s, 512, fp)==NULL) break;
    cp = strchr(s, '\n');
    if (cp != NULL) *cp = '\0';
    l = len + (int)strlen(s);
    if (l+1>size) {
      size = (int)((l+1)*1.2);
      line = (char *) xrealloc(line, size*sizeof(char));
    }
    strcat(line+len, s);
    len=l;
  } while(cp==NULL);

  return line;
}

PRIVATE  unsigned int get_multi_input_line(char **string, unsigned int option) {
  char  *line;
  int   i, l;
  int   state = 0;
  int   str_length = 0;

  line = (inbuf) ? inbuf : get_line(stdin);
  inbuf = NULL;
  do {
    /* read lines until informative data appears or report an error if anything goes wrong */
    if(!line) return VRNA_INPUT_ERROR;
    l = (int)strlen(line);

    /* eliminate whitespaces at the end of the line read */
    for(i = l-1; i >= 0; i--){
      if      (line[i] == ' ')  continue;
      else if (line[i] == '\t') continue;
      else                      break;
    }
    line[(i >= 0) ? (i+1) : 0] = '\0';

    l           = (int)strlen(line);
    str_length  = (*string) ? (int) strlen(*string) : 0;

    switch(*line) {
      case  '@':    /* user abort */
                    if(state) inbuf = line;
                    else      free(line);
                    return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_QUIT;
      case  '\0': break; /* empty line */
      case  '#': case  '%': case  ';': case  '/': case  '*': case ' ': break; /* comments */
      case  '>':    /* fasta header */
                    if(state) inbuf   = line;
                    else      *string = line;
                    return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_FASTA_HEADER;
      case  '<': case  '.': case  '|': case  '(': case ')': case '[': case ']': case '{': case '}': case ',':
                    /* seems to be a structure or a constraint */
                    /* either we concatenate this line to one that we read previously */
                    if(option & VRNA_INPUT_FASTA_HEADER){
                      if(state == 1) { inbuf = line; return VRNA_INPUT_SEQUENCE; }
                      else {
                        *string = (char *)xrealloc(*string, sizeof(char) * (str_length + l + 1));
                        strcpy(*string + str_length, line);
                        state = 2;
                      }
                    }
      default:      if(option & VRNA_INPUT_FASTA_HEADER) {
                      /* are we already in sequence mode? */
                        *string = (char *)xrealloc(*string, sizeof(char) * (str_length + l + 1));
                        strcpy(*string + str_length, line);
                        state = 1;
                    } else {
                      *string = line;
                      return VRNA_INPUT_SEQUENCE;
                    }
    }
    free(line);
    line = get_line(stdin);
  } while(line);
  return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_ERROR;
}

PUBLIC  unsigned int read_record(char **header, char **sequence, char ***rest){
  unsigned int  input_type, return_type, tmp_type;
  int           rest_count;
  char          *input_string;

  unsigned int options = VRNA_INPUT_NO_REST;

  rest_count    = 0;
  return_type   = tmp_type = 0;
  input_string  = *header = *sequence = NULL;
  *rest         = (char **)space(sizeof(char *));

  /* read first input or last buffered input */
  if(typebuf2){
    input_type    = typebuf2;
    input_string  = inbuf2;
    typebuf2      = 0;
    inbuf2        = NULL;
  }
  else input_type  = get_multi_input_line(&input_string, options);

  if(input_type & (VRNA_INPUT_QUIT | VRNA_INPUT_ERROR)) return input_type;

  /* skip everything until we read either a fasta header or a sequence */
  while(input_type & (VRNA_INPUT_MISC | VRNA_INPUT_BLANK_LINE)){
    free(input_string); input_string = NULL;
    input_type    = get_multi_input_line(&input_string, options);
    if(input_type & (VRNA_INPUT_QUIT | VRNA_INPUT_ERROR)) return input_type;
  }

  if(input_type & VRNA_INPUT_FASTA_HEADER){
    return_type  |= VRNA_INPUT_FASTA_HEADER; /* remember that we've read a fasta header */
    *header       = input_string;
    input_string  = NULL;
    /* get next data-block with fasta support if not explicitely forbidden by VRNA_INPUT_NO_SPAN */
    input_type  = get_multi_input_line(
                    &input_string, VRNA_INPUT_FASTA_HEADER | options);
    if(input_type & (VRNA_INPUT_QUIT | VRNA_INPUT_ERROR)) return (return_type | input_type);
  }

  if(input_type & VRNA_INPUT_SEQUENCE){
    return_type  |= VRNA_INPUT_SEQUENCE; /* remember that we've read a sequence */
    *sequence     = input_string;
    input_string  = NULL;
  } else nrerror("sequence input missing");

  /* read the rest until we find user abort, EOF, new sequence or new fasta header */
  (*rest)[rest_count] = NULL;
  return (return_type);
}

/*---------------------------------------------------------------------------*/

PUBLIC void str_uppercase(char *sequence) {
  unsigned int l, i;
  if(sequence) {
    l = strlen(sequence);
    for(i=0;i<l;i++) sequence[i] = toupper(sequence[i]);
  }
}

PUBLIC int *get_indx(unsigned int length) {
  unsigned int i;
  int *idx = (int *)space(sizeof(int) * (length+1));
  for (i = 1; i <= length; i++)
    idx[i] = (i*(i-1)) >> 1;        /* i(i-1)/2 */
  return idx;
}

/*--------------------------------------------------------------------------*/

int main(int argc, char *argv[]){
  char          *buf, *rec_sequence, *rec_id, **rec_rest, *structure, *cstruc, *orig_sequence;
  char          *ParamFile;
  int           i, length, l, cl;
  unsigned int  rec_type, read_opt;
  double        min_en, sfact;
  double        bppmThreshold, betaScale;
  model_detailsT  md;

  rec_type      = read_opt = 0;
  rec_id        = buf = rec_sequence = structure = cstruc = orig_sequence = NULL;
  rec_rest      = NULL;
  ParamFile     = NULL;
  sfact         = 1.07;
  cl            = l = length = 0;
  bppmThreshold = 1e-5;
  betaScale     = 1.;

  set_model_details(&md);

  /* begin initializing */
  if (argc>1) ParamFile=argv[1];
  if (ParamFile != NULL) read_parameter_file(ParamFile);
  // printf("%s\n",option_string());

  /* main loop: continue until end of file */
  while(!((rec_type = read_record(&rec_id, &rec_sequence, &rec_rest))
            & (VRNA_INPUT_ERROR | VRNA_INPUT_QUIT))){

    /* init everything according to the data we've read */
    length  = (int)strlen(rec_sequence);
    structure = (char *)space(sizeof(char) *(length+1));

    /* store case-unmodified sequence */
    orig_sequence = strdup(rec_sequence);
    /* convert sequence to uppercase letters only */
    str_uppercase(rec_sequence);
    /* begin actual computations */
    min_en = fold_par(rec_sequence, structure, NULL);

    printf("%s\n%s", orig_sequence, structure);
    printf(" (%6.2f)\n", min_en);
    (void) fflush(stdout);

    if (length>2000) free_arrays();
    fflush(stdout);

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
