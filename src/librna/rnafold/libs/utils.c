/*
                               utils.c

                 c  Ivo L Hofacker and Walter Fontana
                          Vienna RNA package
*/
/* Last changed Time-stamp: <2008-11-25 16:34:36 ivo> */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>
#include <string.h>
#include "utils.h"

#ifdef WITH_DMALLOC
#include "dmalloc.h"
#endif

#define PRIVATE  static
#define PUBLIC

/*@notnull@ @only@*/
PUBLIC unsigned short xsubi[3];

PRIVATE char  scale1[] = "....,....1....,....2....,....3....,....4";
PRIVATE char  scale2[] = "....,....5....,....6....,....7....,....8";
PRIVATE char  *inbuf = NULL;

PRIVATE char  *inbuf2 = NULL;
PRIVATE unsigned int typebuf2 = 0;

/*-------------------------------------------------------------------------*/

PUBLIC void *space(unsigned size) {
  void *pointer;

  if ( (pointer = (void *) calloc(1, (size_t) size)) == NULL) {
#ifdef EINVAL
    if (errno==EINVAL) {
      fprintf(stderr,"SPACE: requested size: %d\n", size);
      nrerror("SPACE allocation failure -> EINVAL");
    }
    if (errno==ENOMEM)
#endif
      nrerror("SPACE allocation failure -> no memory");
  }
  return  pointer;
}

#ifdef WITH_DMALLOC
#define space(S) calloc(1,(S))
#endif

#undef xrealloc
/* dmalloc.h #define's xrealloc */
void *xrealloc (void *p, unsigned size) {
  if (p == 0)
    return space(size);
  p = (void *) realloc(p, size);
  if (p == NULL) {
#ifdef EINVAL
    if (errno==EINVAL) {
      fprintf(stderr,"xrealloc: requested size: %d\n", size);
      nrerror("xrealloc allocation failure -> EINVAL");
    }
    if (errno==ENOMEM)
#endif
      nrerror("xrealloc allocation failure -> no memory");
  }
  return p;
}

/*------------------------------------------------------------------------*/

PUBLIC void nrerror(const char message[])       /* output message upon error */
{
  fprintf(stderr, "ERROR: %s\n", message);
  exit(EXIT_FAILURE);
}

PUBLIC void warn_user(const char message[]){
  fprintf(stderr, "WARNING: %s\n", message);
}

/*------------------------------------------------------------------------*/
PUBLIC void init_rand(void)
{
  time_t t;
  (void) time(&t);
  xsubi[0] = xsubi[1] = xsubi[2] = (unsigned short) t;  /* lower 16 bit */
  xsubi[1] += (unsigned short) ((unsigned)t >> 6);
  xsubi[2] += (unsigned short) ((unsigned)t >> 12);
  // srand((unsigned int) t);
}

/*------------------------------------------------------------------------*/

PUBLIC double urn(void)
     /* uniform random number generator; urn() is in [0,1] */
     /* uses a linear congruential library routine */
     /* 48 bit arithmetic */
{
  extern double erand48(unsigned short[]);
  return erand48(xsubi);
  // return ((double) rand())/RAND_MAX;
}

/*------------------------------------------------------------------------*/

PRIVATE char *get_line(FILE *fp) /* reads lines of arbitrary length from fp */
{
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

PRIVATE  unsigned int get_multi_input_line(char **string, unsigned int option){
  char  *line;
  int   i, l;
  int   state = 0;
  int   str_length = 0;

  line = (inbuf) ? inbuf : get_line(stdin);
  inbuf = NULL;
  do{

    /*
    * read lines until informative data appears or
    * report an error if anything goes wrong
    */
    if(!line) return VRNA_INPUT_ERROR;

    l = (int)strlen(line);

    /* eliminate whitespaces at the end of the line read */
    if(!(option & VRNA_INPUT_NO_TRUNCATION)){
      for(i = l-1; i >= 0; i--){
        if      (line[i] == ' ')  continue;
        else if (line[i] == '\t') continue;
        else                      break;
      }
      line[(i >= 0) ? (i+1) : 0] = '\0';
    }

    l           = (int)strlen(line);
    str_length  = (*string) ? (int) strlen(*string) : 0;

    switch(*line){
      case  '@':    /* user abort */
                    if(state) inbuf = line;
                    else      free(line);
                    return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_QUIT;

      case  '\0':   /* empty line */
                    if(option & VRNA_INPUT_NOSKIP_BLANK_LINES){
                      if(state) inbuf = line;
                      else      free(line);
                      return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_BLANK_LINE;
                    }
                    break;

      case  '#': case  '%': case  ';': case  '/': case  '*': case ' ':
                    /* comments */
                    if(option & VRNA_INPUT_NOSKIP_COMMENTS){
                      if(state) inbuf   = line;
                      else      *string = line;
                      return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_COMMENT;
                    }
                    break;

      case  '>':    /* fasta header */
                    if(state) inbuf   = line;
                    else      *string = line;
                    return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_FASTA_HEADER;

      case  '<': case  '.': case  '|': case  '(': case ')': case '[': case ']': case '{': case '}': case ',':
                    /* seems to be a structure or a constraint */
                    /* either we concatenate this line to one that we read previously */
                    if(option & VRNA_INPUT_FASTA_HEADER){
                      if(state == 1){
                        inbuf = line;
                        return VRNA_INPUT_SEQUENCE;
                      }
                      else{
                        *string = (char *)xrealloc(*string, sizeof(char) * (str_length + l + 1));
                        strcpy(*string + str_length, line);
                        state = 2;
                      }
                    }
      default:      if(option & VRNA_INPUT_FASTA_HEADER){
                      /* are we already in sequence mode? */
                        *string = (char *)xrealloc(*string, sizeof(char) * (str_length + l + 1));
                        strcpy(*string + str_length, line);
                        state = 1;
                    }
                    /* otherwise return line read */
                    else{
                      *string = line;
                      return VRNA_INPUT_SEQUENCE;
                    }
    }
    free(line);
    line = get_line(stdin);
  }while(line);

  return (state==1) ? VRNA_INPUT_SEQUENCE : VRNA_INPUT_ERROR;
}

PUBLIC  unsigned int read_record(char **header, char **sequence, char ***rest, unsigned int options){
  unsigned int  input_type, return_type, tmp_type;
  int           rest_count;
  char          *input_string;

  rest_count    = 0;
  return_type   = tmp_type = 0;
  input_string  = *header = *sequence = NULL;
  *rest         = (char **)space(sizeof(char *));

  /* remove unnecessary option flags from options variable... */
  options &= ~VRNA_INPUT_FASTA_HEADER;

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
                    &input_string,
                    ((options & VRNA_INPUT_NO_SPAN) ? 0 : VRNA_INPUT_FASTA_HEADER) | options
                  );
    if(input_type & (VRNA_INPUT_QUIT | VRNA_INPUT_ERROR)) return (return_type | input_type);
  }

  if(input_type & VRNA_INPUT_SEQUENCE){
    return_type  |= VRNA_INPUT_SEQUENCE; /* remember that we've read a sequence */
    *sequence     = input_string;
    input_string  = NULL;
  } else nrerror("sequence input missing");

  /* read the rest until we find user abort, EOF, new sequence or new fasta header */
  if(!(options & VRNA_INPUT_NO_REST)){
    options |= VRNA_INPUT_NOSKIP_COMMENTS; /* allow commetns to appear in rest output */
    tmp_type = VRNA_INPUT_QUIT | VRNA_INPUT_ERROR | VRNA_INPUT_SEQUENCE | VRNA_INPUT_FASTA_HEADER;
    if(options & VRNA_INPUT_NOSKIP_BLANK_LINES) tmp_type |= VRNA_INPUT_BLANK_LINE;
    while(!((input_type = get_multi_input_line(&input_string, options)) & tmp_type)){
      *rest = xrealloc(*rest, sizeof(char **)*(++rest_count + 1));
      (*rest)[rest_count-1] = input_string;
      input_string = NULL;
    }
    /*  finished reading everything...
    *   we now put the last line into the buffer if necessary
    *   since it should belong to the next record
    */
    inbuf2 = input_string;
    typebuf2 = input_type;
  }
  (*rest)[rest_count] = NULL;
  return (return_type);
}

/*--------------------------------------------------------------------------*/

PUBLIC short *make_pair_table(const char *structure)
{
    /* returns array representation of structure.
       table[i] is 0 if unpaired or j if (i.j) pair.  */
   short i,j,hx;
   short length;
   short *stack;
   short *table;

   length = (short) strlen(structure);
   stack = (short *) space(sizeof(short)*(length+1));
   table = (short *) space(sizeof(short)*(length+2));
   table[0] = length;

   for (hx=0, i=1; i<=length; i++) {
      switch (structure[i-1]) {
       case '(':
         stack[hx++]=i;
         break;
       case ')':
         j = stack[--hx];
         if (hx<0) {
            fprintf(stderr, "%s\n", structure);
            nrerror("unbalanced brackets in make_pair_table");
         }
         table[i]=j;
         table[j]=i;
         break;
       default:   /* unpaired base, usually '.' */
         table[i]= 0;
         break;
      }
   }
   if (hx!=0) {
      fprintf(stderr, "%s\n", structure);
      nrerror("unbalanced brackets in make_pair_table");
   }
   free(stack);
   return(table);
}

PUBLIC short *copy_pair_table(const short *pt){
  short *table = (short *)space(sizeof(short) * (pt[0]+2));
  memcpy(table, pt, sizeof(short)*(pt[0]+2));
  return table;
}

/*---------------------------------------------------------------------------*/

PUBLIC  void  print_tty_input_seq(void){
  print_tty_input_seq_str("Input string (upper or lower case)");
}

PUBLIC  void  print_tty_input_seq_str(const char *s){
  printf("\n%s; @ to quit\n", s);
  printf("%s%s\n", scale1, scale2);
  (void) fflush(stdout);
}

PUBLIC  void  str_DNA2RNA(char *sequence){
  unsigned int l, i;
  if(sequence != NULL){
    l = strlen(sequence);
    for(i = 0; i < l; i++){
      if(sequence[i] == 'T') sequence[i] = 'U';
      if(sequence[i] == 't') sequence[i] = 'u';
    }
  }
}

PUBLIC void str_uppercase(char *sequence){
  unsigned int l, i;
  if(sequence){
    l = strlen(sequence);
    for(i=0;i<l;i++)
      sequence[i] = toupper(sequence[i]);
  }
}

PUBLIC int *get_iindx(unsigned int length){
  int i;
  int *idx = (int *)space(sizeof(int) * (length+1));
  for (i=1; i <= length; i++)
    idx[i] = (((length + 1 - i) * (length - i))>>1) + length + 1;
  return idx;
}

PUBLIC int *get_indx(unsigned int length){
  unsigned int i;
  int *idx = (int *)space(sizeof(int) * (length+1));
  for (i = 1; i <= length; i++)
    idx[i] = (i*(i-1)) >> 1;        /* i(i-1)/2 */
  return idx;
}
