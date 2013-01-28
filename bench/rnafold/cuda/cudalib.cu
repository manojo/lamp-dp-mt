
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <errno.h>

#include "config.h"
#include "options.h"


#include <cutil.h>

#define is_suboptimal(a, b, c) abs(a - b) <= c

FILE *energyFile;

#define ENERGYFILE "energies.dat"

// #define DIFF3
// #define SHARED_Z // 2000

// #define SHARED_ENERGY // 8000
// #define SHARED_OFFSET  // 8000

// #define SPARSE_CLOSED
// #define MAX_DIFF 200

#define SHMEM 1000

/* Always needed
  ====================================================================== */

#define min(A, B) ((A) < (B) ? (A) : (B))
#define max(A, B) ((A) > (B) ? (A) : (B))

/* Input handling
  ====================================================================== */

void convert_input(int start, char *z, int n);


/* Correct incomplete phases in adpc
  ====================================================================== */

#define decode(X) ((X)-'0')


/* Memory handling
  ====================================================================== */


/* wrappers for standard C functions
   ------------------------------------------- */

void memerr_exit(char *f);
void *mcalloc(size_t nobj, size_t size);
void *mmalloc(size_t size);
void *mrealloc(void *q, size_t size);


/* Memory management
   ------------------------------------------- */

typedef struct {
  char **address;
  int currentBlock;
  int currentPos;
  int blockSize;
  int numberOfBlocks;
} tmemory;

tmemory *adp_statmem;
tmemory *adp_dynmem;

void      set_adplib_debug(int debug);

void     *myalloc(tmemory *mem, int size);

tmemory  *memory_new();
void      memory_clear(tmemory *mem);
void      memory_free(tmemory *mem);

/* Preprocessing tools
  ====================================================================== */

char arr_iupac_base[128][5];
#define iupac_base(A,B) arr_iupac_base[A][B]
char *calc_contains_region(char *z, int n, int *offset, char *pat1);

/* String tools
  ====================================================================== */

char *mkstr(char *s);

#define dots(i,j) libPP_repeat(i,j,'.')

char *libPP_repeat(int i, int j, char c);

/* File input
  ====================================================================== */

/* A single sequence
   ------------------------------------------- */

typedef struct {
  char success;
  char *descr;
  char *seq;
  int  length;
  char *original_seq;  /* backup for window mode */
  int   original_length;
} tsequence;


tsequence *sequence_new();
tsequence *sequence_free(tsequence *ts);

/* A complete file
   ------------------------------------------- */

#define READSEQ_FILE    1
#define READSEQ_STDIN   2
#define READSEQ_STRING  3

typedef struct {
  char *filename;
  char *start;
  int  current;
  char first_input_read;
  char first_descr_read;
  char *temp;
} treadseq;


treadseq    *readseq_open(char mode, char *filename);
treadseq    *readseq_free(treadseq *rs);

/* reader for different input formats
   ------------------------------------------- */

tsequence *readseq_next_line(treadseq *rs);
tsequence *readseq_next_fasta(treadseq *rs);

/* Functions for results output
  ====================================================================== */

void simple_output_optimal     (toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);
void simple_output_subopt_start(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);
void simple_output_subopt      (toptions *opts, tsequence *seq, char *algebra, int score, char *result_prettyprint);
void simple_output_subopt_end  (toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);

void rna_output_optimal     (toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);
void rna_output_subopt_start(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);
void rna_output_subopt      (toptions *opts, tsequence *seq, char *algebra, int score, char *result_prettyprint);
void rna_output_subopt_end  (toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end);

/* Tokenizer for interactive command shell
  ====================================================================== */

typedef struct {
  char **token;
  int count;
} ttokenizer;


ttokenizer *tokenizer_new();
ttokenizer *tokenizer_free(ttokenizer *t);
void tokenizer_exec(ttokenizer *t, char *name, char *s);

/* wrappers for readline
  ====================================================================== */

void rl_init();
char *rl_gets ();

/* colored output
  ====================================================================== */

#define COLOR_DEFAULT     "\x1b[0m"
#define COLOR_BOLD        "\x1b[1m"
#define COLOR_BLACK       "\x1b[0;30m"
#define COLOR_BLUE        "\x1b[0;34m"
#define COLOR_GREEN       "\x1b[0;32m"
#define COLOR_CYAN        "\x1b[0;36m"
#define COLOR_RED         "\x1b[0;31m"
#define COLOR_PURPLE      "\x1b[0;35m"
#define COLOR_BROWN       "\x1b[0;33m"
#define COLOR_GRAY        "\x1b[0;37m"
#define COLOR_DARKGRAY    "\x1b[1;30m"
#define COLOR_LIGHTBLUE   "\x1b[1;34m"
#define COLOR_LIGHTGREEN  "\x1b[1;32m"
#define COLOR_LIGHTCYAN   "\x1b[1;36m"
#define COLOR_LIGHTRED    "\x1b[1;31m"
#define COLOR_LIGHTPURPLE "\x1b[1;35m"
#define COLOR_YELLOW      "\x1b[1;33m"
#define COLOR_WHITE       "\x1b[1;37m"
#define pcolor(colored,col) if (colored) printf(col)


/* Output format string handling
  ====================================================================== */

/* calculate the number of leading spaces for sequence output */
void fs_init_leading_space(char energy, char shrepProb, char dbString, char shapeString, char prob, char rank);

/* free the leading spaces temp mem. */
void fs_free_leading_space();

/* initialize a new format string */
void format_string_init(char *s);

/* set predefined output modes */
void setOutputMode(int outputMode);

/* main entry function for sequence output */
void print_sequence(toptions *opts, tsequence *seq, int pos, int size);

/* used in window-mode to shift the input sequence */
void shift_input(toptions *opts, tsequence *seq, char output);

/* main entry function for rna result output */
void output_result
  (toptions *opts, tsequence *seq,
   int nres, int *energy, double *shrepProb, char *dbString, char *shapeString, double prob, int rank);

typedef struct format_string{
  char type;
  char *string;
  struct format_string *next;
} tformat_string;



/* Initialize all stuff from adplib
  ====================================================================== */

void adplib_init(toptions *opts, tsequence *seq, char **z, int *n);
void adplib_free(toptions *opts, tsequence *seq);



/* Input handling
  ====================================================================== */

/* The alphabet */
#define A 0
#define C 1
#define G 2
#define U 3
#define N 4

void convert_input(int start, char *z, int n){
  int i;
  char c;

  for (i=start; i<=n; i++) {
    c=z[i];
    if      (c=='a') z[i]=A;
    else if (c=='c') z[i]=C;
    else if (c=='g') z[i]=G;
    else if (c=='u') z[i]=U;
    else if (c=='t') z[i]=U;  /* replace DNA with RNA */
    else if (c=='A') z[i]=A;
    else if (c=='C') z[i]=C;
    else if (c=='G') z[i]=G;
    else if (c=='U') z[i]=U;
    else if (c=='T') z[i]=U;
    else             z[i]=N;  /* all other characters are mapped to N and will not be paired */
  }
}


/* Memory handling
  ====================================================================== */

/* wrappers for standard C functions
   ------------------------------------------- */

void memerr_exit(char *f){
    fprintf(stderr, "\n%s: out of memory\n", f);
    fprintf(stderr, "possible reasons:\n");
    fprintf(stderr, "   input sequence too long\n");
    fprintf(stderr, "   energy range too large (decrease with -e or -c)\n");
    fprintf(stderr, "   shape type not abstract enough (increase with -t)\n");
    exit(1);
}

void *mcalloc(size_t nobj, size_t size){
  void *p;
  if ((p = calloc(nobj, size)) != NULL) return p;
  else memerr_exit("calloc");
  return NULL;
}

void *mmalloc(size_t size){
  void *p;
  if ((p = malloc(size)) != NULL) return p;
  else memerr_exit("malloc");
  return NULL;
}

void *mrealloc(void *q, size_t size){
  void *p;
  if ((p = realloc(q, size)) != NULL) return p;
  else memerr_exit("realloc");
  return NULL;
}

/* Memory management
   ------------------------------------------- */

#define ALIGNMENT 8
#define BLOCKSIZE 1000000

static int adplib_debug = 0;

void set_adplib_debug(int debug){
  adplib_debug = debug;
  printf("adplib_debug set to %d.\n", adplib_debug);
}


void *myalloc(tmemory *mem, int size)
{
  //  return mcalloc(size,sizeof(char));
  //}
   if (adplib_debug>1) printf("myalloc(), currentBlock = , currentPos = \n");
   if (size % ALIGNMENT) {
     size = ((size / ALIGNMENT) + 1) * ALIGNMENT;
     if (adplib_debug>1) printf("realigned: %d\n", size);
   }

   if (mem->currentPos + size >= mem->blockSize) {
      mem->currentBlock++;
      if (mem->currentBlock > mem->numberOfBlocks) {
        mem->address = (char **) mrealloc(mem->address, sizeof (char *) * mem->currentBlock);
        mem->numberOfBlocks = mem->currentBlock;
        mem->address[mem->currentBlock - 1] = (char*) mmalloc(mem->blockSize);
	//        if(adplib_debug>1) printf("address of mem->address[mem->currentBlock - 1]: %d\n", mem->address[mem->currentBlock - 1]);
      }
      mem->currentPos = 0;
      //      if (adplib_debug>1) printf("mrealloc: myalloc(%d), currentBlock = %d, currentPos = %d\n", size, mem->currentBlock, mem->currentPos);
   }
   mem->currentPos = mem->currentPos + size;
   //   if (adplib_debug>1) printf("myalloc: address: %d\n", mem->address[mem->currentBlock - 1] + (mem->currentPos - size));
   return(mem->address[mem->currentBlock - 1] + (mem->currentPos - size));
}

tmemory *memory_new()
{
  tmemory *mem        = (tmemory *) mmalloc(sizeof(tmemory));
  mem->address        = (char **) mmalloc(sizeof(char *));
  mem->address[0]     = (char *) mmalloc(BLOCKSIZE);
  mem->blockSize      = BLOCKSIZE;
  mem->currentBlock   = 1;
  mem->numberOfBlocks = 1;
  mem->currentPos     = 0;
  if (adplib_debug>1) printf("adplib.memory.new(): allocated %d bytes\n", BLOCKSIZE);
  return mem;
}

void memory_clear(tmemory *mem)
{
  mem->currentBlock = 0;
  mem->currentPos   = mem->blockSize + 1;
}

void memory_free(tmemory *mem)
{
  int i;
  if (adplib_debug) printf("freeing %d blocks, blockSize = %d => %d bytes\n",
         mem->numberOfBlocks, mem->blockSize, mem->numberOfBlocks * mem->blockSize);
  for (i=0; i<=mem->numberOfBlocks-1; i++) free(mem->address[i]);
  free(mem->address);
  free(mem);
}

/* Preprocessing tools
  ====================================================================== */


/* ---------------------------------------------------------------------------------------------------- */
/* iupac_base                                                                                           */
/* ---------------------------------------------------------------------------------------------------- */

static void init_iupac_base(){
  int i,j;

  for (i=0;i<128;i++)
    for (j=0;j<5;j++)
      arr_iupac_base[i][j]=0;

  arr_iupac_base['a'][A]=1;     arr_iupac_base['A'][A]=1;
  arr_iupac_base['c'][C]=1;	arr_iupac_base['C'][C]=1;
  arr_iupac_base['g'][G]=1;	arr_iupac_base['G'][G]=1;
  arr_iupac_base['t'][U]=1;	arr_iupac_base['T'][U]=1;
  arr_iupac_base['u'][U]=1;	arr_iupac_base['U'][U]=1;
  arr_iupac_base['r'][A]=1;	arr_iupac_base['R'][A]=1;
  arr_iupac_base['r'][G]=1;	arr_iupac_base['R'][G]=1;
  arr_iupac_base['y'][C]=1;	arr_iupac_base['Y'][C]=1;
  arr_iupac_base['y'][U]=1;	arr_iupac_base['Y'][U]=1;
  arr_iupac_base['s'][G]=1;	arr_iupac_base['S'][G]=1;
  arr_iupac_base['s'][C]=1;	arr_iupac_base['S'][C]=1;
  arr_iupac_base['w'][A]=1;	arr_iupac_base['W'][A]=1;
  arr_iupac_base['w'][U]=1;	arr_iupac_base['W'][U]=1;
  arr_iupac_base['k'][G]=1;	arr_iupac_base['K'][G]=1;
  arr_iupac_base['k'][U]=1;	arr_iupac_base['K'][U]=1;
  arr_iupac_base['m'][A]=1;	arr_iupac_base['M'][A]=1;
  arr_iupac_base['m'][C]=1;	arr_iupac_base['M'][C]=1;
  arr_iupac_base['b'][C]=1;	arr_iupac_base['B'][C]=1;
  arr_iupac_base['b'][G]=1;	arr_iupac_base['B'][G]=1;
  arr_iupac_base['b'][U]=1;	arr_iupac_base['B'][U]=1;
  arr_iupac_base['d'][A]=1;	arr_iupac_base['D'][A]=1;
  arr_iupac_base['d'][G]=1;	arr_iupac_base['D'][G]=1;
  arr_iupac_base['d'][U]=1;	arr_iupac_base['D'][U]=1;
  arr_iupac_base['h'][A]=1;	arr_iupac_base['H'][A]=1;
  arr_iupac_base['h'][C]=1;	arr_iupac_base['H'][C]=1;
  arr_iupac_base['h'][U]=1;	arr_iupac_base['H'][U]=1;
  arr_iupac_base['v'][A]=1;	arr_iupac_base['V'][A]=1;
  arr_iupac_base['v'][C]=1;	arr_iupac_base['V'][C]=1;
  arr_iupac_base['v'][G]=1;	arr_iupac_base['V'][G]=1;
  arr_iupac_base['n'][A]=1;	arr_iupac_base['N'][A]=1;
  arr_iupac_base['n'][C]=1;	arr_iupac_base['N'][C]=1;
  arr_iupac_base['n'][G]=1;	arr_iupac_base['N'][G]=1;
  arr_iupac_base['n'][U]=1;	arr_iupac_base['N'][U]=1;
}

/* char arr_iupac_base[ */

/* A 	Adenine
 */
/* C 	Cytosine
 */
/* G 	Guanine
 */
/* T (or U) 	Thymine (or Uracil)
 */
/* R 	A or G
 */
/* Y 	C or T
 */
/* S 	G or C
 */
/* W 	A or T
 */
/* K 	G or T
 */
/* M 	A or C
 */
/* B 	C or G or T
 */
/* D 	A or G or T
 */
/* H 	A or C or T
 */
/* V 	A or C or G
 */
/* N 	any base
 */
/* . or - 	gap */


char *calc_contains_region(char *z, int n, int *offset, char *pat)
{
  int i,j,k,l,ppos,inPattern;
  char *arr;

  if (adplib_debug>1) printf("entering...\n");
  if (adplib_debug>1) for(i=0; i<=n; i++) printf("z[%d] = %d\n", i, z[i]);
  l = strlen(pat);

  if (adplib_debug>1) for(i=0; i<=l; i++) printf("pat[%d] = %c\n", i, pat[i]);
  arr = (char *) malloc((offset[n]+n+1) * sizeof(char));

  if (adplib_debug>1) printf("calculating...\n");

  for (j=0; j<=n; j++) {
    for (i=0; i<=j; i++) {
      arr[offset[j]+i]=0;  // tab(i,j)
      ppos = 0;
      inPattern = 0;
      if (j-i >= l) {
        for (k=i+1;k<=j;k++) {
          if (inPattern){
            if (iupac_base(pat[ppos],z[k])) {
              ppos++;
            }
            else {
              inPattern = 0;
              ppos = 0;
	      break;
	    }
          }
          else {
            if (iupac_base(pat[ppos],z[k])) {
              inPattern = 1;
              ppos++;
	    }
	  }
          if (ppos==l) arr[offset[j]+i]=1;
	}
      }
    }
  }
  if (adplib_debug>1) {
    for (j=0; j<=n; j++) {
      for (i=0; i<=j; i++) {
        printf("%d ", arr[offset[j]+i]);
      }
      printf("\n");
    }
  }
  return arr;
}

/* String tools
  ====================================================================== */

char *mkstr(char *s){
  return strcpy((char *) malloc(strlen(s)+1 * sizeof(char)), s);
}

char *mkstr_stat(char *s){
  return strcpy((char *) myalloc(adp_statmem, (strlen(s)+1) * sizeof(char)), s);
}

/* ---------------------------------------------------------------------------------------------------- */
/* Dotbracket tools                                                                                     */
/* ---------------------------------------------------------------------------------------------------- */

static char *libPP_hlp;
static char *dots_hlp;

char *libPP_repeat(int i, int j, char c){
  int k;
  for (k=0; k<(j-i); k++) libPP_hlp[k]=c;
  libPP_hlp[k]=0;
  return(libPP_hlp);
}

static void libPP_init(tsequence *seq){
   libPP_hlp = (char *) myalloc(adp_statmem, (seq->length+4) * sizeof(char));
   dots_hlp = mkstr_stat(libPP_repeat(0, seq->length, '.'));
}


/* File input
  ====================================================================== */

/* A single sequence
   ------------------------------------------- */

/* typedef struct { */
/*   char success; */
/*   char *descr; */
/*   char *seq; */
/*   int  length; */
/*   char *original_seq;  /\* backup for window mode *\/ */
/*   int   original_length; */
/* } tsequence; */


tsequence *sequence_new()
{
  tsequence *ts;

  ts = (tsequence *) mmalloc(sizeof(tsequence));
  ts->success         = 0;
  ts->descr           = NULL;
  ts->seq             = NULL;
  ts->length          = 0;
  ts->original_seq    = NULL;
  ts->original_length = 0;

  return ts;
}

tsequence *sequence_free(tsequence *ts)
{
  if (ts->descr)        free(ts->descr);
  if (ts->seq)          free(ts->seq);
  if (ts->original_seq) free(ts->original_seq);
  free(ts);

  return NULL;
}

/* A complete file
   ------------------------------------------- */

#define MAXINPUT 1000000

/* typedef struct { */
/*   char *filename; */
/*   char *start; */
/*   int  current; */
/*   char first_input_read; */
/*   char first_descr_read; */
/*   char *temp; */
/* } treadseq; */

static char *readseq_readfile(FILE *inputStream)
{
  int   inpc, inpn;
  int   tinput_alloc;
  char *tinput;

  inpn = 0;
  tinput = (char *) malloc(MAXINPUT * sizeof(char));
  tinput_alloc = MAXINPUT;

  while ((inpc = getc(inputStream)) != EOF) {
    if (inpn == tinput_alloc-2) {
      tinput = (char *) realloc(tinput, sizeof (char) * (tinput_alloc * 2));
      tinput_alloc *= 2;
    }
    tinput[inpn++] = inpc;
  }
  tinput[inpn] = 0;
  return tinput;
}

treadseq *readseq_open(char mode, char *filename){
  treadseq *rs;
  FILE *inputStream;

  rs = (treadseq *) malloc(sizeof(treadseq));
  rs->current          = 0;
  rs->first_input_read = 0;
  rs->first_descr_read = 0;
  rs->temp             = (char *) malloc(MAXINPUT * sizeof(char));

  if (mode == READSEQ_STRING) {
    rs->start    = mkstr(filename);
    rs->filename = mkstr("command line");
    return rs;
  }

  if (mode == READSEQ_STDIN) {
    inputStream   = stdin;
    rs->filename  = mkstr("stdin");
  }
  if (mode == READSEQ_FILE) {
    inputStream   = fopen(filename, "r");
    rs->filename  = mkstr(filename);
  }

  if (!inputStream) {
    fprintf(stderr, "error opening file %s: %s\n", filename, strerror(errno));
    exit(errno);
  }

  rs->start = readseq_readfile(inputStream);

  if (fclose(inputStream)) {
    fprintf(stderr, "error closing file %s: %s\n", filename, strerror(errno));
    exit(errno);
  }

  return rs;
}

treadseq *readseq_free(treadseq *rs){
  if (rs) {
    free(rs->filename);
    free(rs->start);
    free(rs->temp);
    free(rs);
  }
  return NULL;
}


/* Read next line from file
   ------------------------------------------- */

tsequence *readseq_next_line(treadseq *rs){

  tsequence *ts;
  int pos;

  ts = sequence_new();
  ts->success    = 0;
  if (adplib_debug>1) printf("rs: success = 0\n");

  if (adplib_debug>1) printf("rs: %d\n", rs->start[rs->current]);

  rs->temp[0] = 0; pos = 0;
  if (rs->start[rs->current] != 0) {
    while ((rs->start[rs->current] != '\n') && (rs->start[rs->current] != 0))
       rs->temp[pos++] = rs->start[rs->current++];
    if (rs->start[rs->current]=='\n') rs->current++;

    rs->temp[pos] = 0;
    ts->seq          = mkstr(rs->temp);
    ts->original_seq = mkstr(rs->temp);

    // remove additional #13 for DOS input files:
    if ((pos >= 1) && (rs->temp[pos-1] == 13)) rs->temp[pos-1] = 0;

    // remove additional #13 for DOS input files:
    if ((pos >= 1) && (rs->temp[pos-1] == 13)) rs->temp[pos-1] = 0;

    ts->length = ts->original_length = strlen(ts->seq);
    ts->success    = 1;
    if (adplib_debug>1) printf("rs: success = 1\n");
  }

  return ts;
}


/* Read next fasta sequence from file
   ------------------------------------------- */

tsequence *readseq_next_fasta(treadseq *rs){

  tsequence *ts;
  int pos;
  char inpc,fil;

  ts = sequence_new();

  rs->temp[0] = 0; pos = 0;
  if ((rs->start[rs->current] == '>')  && (rs->start[rs->current] != 0)) {
    if (!rs->first_descr_read && rs->first_input_read) {
      fprintf(stderr, "error in input file: missing description for first sequence\n");
      exit(1);
    }
    rs->first_descr_read = 1;
    rs->current++;
    while ((rs->start[rs->current] != '\n') && (rs->start[rs->current] != 0)) rs->temp[pos++] = rs->start[rs->current++];
    if (rs->start[rs->current]) rs->current++;
  }
  rs->temp[pos] = 0;
  ts->descr = mkstr(rs->temp);

  // remove additional #13 for DOS input files:
  if ((pos >= 1) && (rs->temp[pos-1] == 13)) rs->temp[pos-1] = 0;

  rs->temp[0] = 0; pos = 0;
  fil = 1;
  while ((fil || (rs->start[rs->current] != '>')) && (rs->start[rs->current] != 0)) {
    while (((inpc = rs->start[rs->current]) != '\n') && (rs->start[rs->current] != 0))
       if (((inpc >= 65) && (inpc <= 90)) ||
           ((inpc >= 97) && (inpc <= 122))) rs->temp[pos++] = rs->start[rs->current++];
       else                                 rs->current++;
    fil = 0;
    if (rs->start[rs->current]) rs->current++;
    rs->first_input_read = 1;
  }
  rs->temp[pos] = 0;
  ts->seq           = mkstr(rs->temp);
  ts->original_seq  = mkstr(rs->temp);
  ts->length = ts->original_length = strlen(ts->seq);
  if (ts->seq[0]) ts->success    = 1;
  else            ts->success    = 0;

  return ts;
}

/* Functions for results output
  ====================================================================== */

/* Simple standard output
   ------------------------------------------- */

void simple_output_optimal(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
  printf("\nInput: ");
  pcolor(opts->colored_output,COLOR_BOLD);
  printf("%s", seq->seq);
  pcolor(opts->colored_output,COLOR_DEFAULT);
  printf("\nAlgebra: ");
  pcolor(opts->colored_output,COLOR_BOLD);
  printf("%s", algebra);
  pcolor(opts->colored_output,COLOR_DEFAULT);
  printf(", score: ");
  pcolor(opts->colored_output,COLOR_BOLD);
  printf("%d\n", result_score);
  pcolor(opts->colored_output,COLOR_DEFAULT);
}


void simple_output_subopt_start(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
  if (strcmp(algebra, "count")) {
    printf("Suboptimal range: [%d - %d]\n", range_begin, range_end);
    printf("\n");
    printf(" Score | Candidate\n");
    // pcolor(opts->colored_output,COLOR_BOLD);
    printf("-----------------------------------------------------------------\n");
    // pcolor(opts->colored_output,COLOR_DEFAULT);
  }
}

void simple_output_subopt(toptions *opts, tsequence *seq, char *algebra, int score, char *result_prettyprint)
{
  if (strcmp(algebra, "count")) {
    printf("%6d | %s\n", score, result_prettyprint);
  }
}

void simple_output_subopt_end(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
  printf("\n");
  // pcolor(opts->colored_output,COLOR_BOLD);
  printf("=================================================================\n");
  // pcolor(opts->colored_output,COLOR_DEFAULT);

}

/* RNA output
   ------------------------------------------- */

void rna_output_optimal(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
  if (!opts->window_mode) {
    printf("\n");
    pcolor(opts->colored_output,COLOR_BOLD);
    printf("%s: ", algebra);
    printf("%.2f kcal/mol", ((float) result_score) / 100);
    pcolor(opts->colored_output,COLOR_DEFAULT);
    printf("\n");
  }
}

void rna_output_subopt_start(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
  if (!opts->window_mode && (strcmp(algebra, "count"))) {
    printf("Suboptimal range: [%.2f kcal/mol - %.2f kcal/mol]\n", ((float) range_begin)/100, ((float) range_end)/100);
    printf("\n");

    if (seq->descr && seq->descr[0]) {
      pcolor(opts->colored_output,COLOR_BOLD);
      printf(">%s", seq->descr);
      pcolor(opts->colored_output,COLOR_DEFAULT);
      printf("\n");
    }
    if (!opts->split_output_mode) printf("%s\n", seq->original_seq);
  }
  // print subsequence for first window iteration
  // for later iterations, this is done in function shift_input
  if (opts->window_mode && (opts->window_pos==0) && (strcmp(algebra, "count"))) {
    print_sequence(opts, seq, opts->window_pos, opts->window_size);
  }
}

void rna_output_subopt(toptions *opts, tsequence *seq, char *algebra, int score, char *result_prettyprint)
{
  if (strcmp(algebra, "count")) {
    //    printf("%s  (%.2f)\n", result_prettyprint, ((float) score) / 100 );
    output_result(opts, seq, 1, // TODO: number of results
                  &score, NULL, result_prettyprint, NULL, -1, -1);
  }
}

void rna_output_subopt_end(toptions *opts, tsequence *seq, char *algebra, int result_score, int range_begin, int range_end)
{
/*   printf("\n"); */
/*   pcolor(opts->colored_output,COLOR_BOLD); */
/*   printf("=================================================================\n"); */
/*   pcolor(opts->colored_output,COLOR_DEFAULT); */
}

void rna_output_descr(toptions *opts, tsequence *seq)
{
  if (seq->descr && seq->descr[0]) {
    pcolor(opts->colored_output,COLOR_BOLD);
    printf(">%s", seq->descr);
    pcolor(opts->colored_output,COLOR_DEFAULT);
    printf("\n");
  }
}


/* Tokenizer for interactive command shell
  ====================================================================== */

#define MAXTOKEN 500

/* typedef struct { */
/*   char **token; */
/*   int count; */
/* } ttokenizer; */


ttokenizer *tokenizer_new(){
  ttokenizer *t;

  t = (ttokenizer *) malloc(sizeof(ttokenizer));
  t->token = (char **) malloc(MAXTOKEN * sizeof(char *));
  t->count = 0;

  return t;
}

ttokenizer *tokenizer_free(ttokenizer *t){
  int i;
  if (t) {
    for (i=0; i < t->count; i++) free(t->token[i]);
    free(t->token);
    free(t);
  }
  return NULL;
}

void tokenizer_exec(ttokenizer *t, char *name, char *s)
{
  int i;
  char in_quotes;
  char *ttoken;
  char  septoken[]  = {1,0};

  // free old token strings:
  for (i=0; i < t->count; i++) free(t->token[i]);

  // build new token array:
  t->count = 1;

  // replace whitespaces:
  in_quotes = 0;
  for (i=0; i<strlen(s); i++) {
    if (!in_quotes && (s[i] == ' ')) s[i] = 1;
    if (s[i] == 39) {
      in_quotes = 1-in_quotes;
      s[i] = 1;
    }
  }
  // build token list:
  t->token[0]     = mkstr(name);
  while((ttoken = strtok(s,septoken))) {
    t->token[t->count++] = mkstr(ttoken);
    s = NULL;
  }
  // debug output:
  /*   if (debug) { */
  /*        printf("#token: %d\n", t->count-1);  */
  /*        for (i=1;i<t->count;i++) printf("%s\n", t->token[i]);  */
}


/* wrappers for readline
  ====================================================================== */

/* wrappers for readline
  ====================================================================== */

#ifdef HAVE_LIBEDITLINE
extern int rl_insert(int count, int c);
extern int rl_bind_key(int c, int func(int, int));
extern char *readline(const char *prompt);
extern int add_history(const char *line);
#endif

static char *line_read = (char *)NULL;

void rl_init() {
#ifdef HAVE_LIBEDITLINE
  //   printf("readline activated\n");
  //   rl_bind_key('\t', rl_insert);
#else
   line_read = (char *) calloc(MAXINPUT, sizeof(char));
   line_read[0] = 0;
#endif
}

char *rl_gets (){
#ifdef HAVE_LIBEDITLINE
  if (line_read)
    {
      free (line_read);
      line_read = (char *)NULL;
    }

  line_read = readline (NULL);

  if (line_read && *line_read)
    add_history (line_read);
#else
  fgets(line_read, MAXINPUT-2, stdin);
  // remove last newline
  line_read[strlen(line_read)-1] = 0;
#endif

  return (line_read);
}


/* Output format string handling
  ====================================================================== */

/* show shrep probability */
static char shrep_prob_show;

/* PS output */
static char graphics_alloc = 0;
static char *graphics_sequence;
static char *graphics_shapeString;
static char *graphics_preString;
static char *graphics_fileName_temp;
static char *graphics_fileName;

int number_of_graphics;
char colored_db2shape;

/* typedef struct { */
/*   char type; */
/*   char *string; */
/*   struct format_string *next; */
/* } tformat_string; */


static tformat_string *format_string_struct = NULL; // current format string
static char *leading_space;                         // help strings
static char *leading_space_db;

#define FORMAT_LENGTH 1024
#define FORMAT_ENERGY 1
#define FORMAT_SHREPPROB 2
#define FORMAT_DBSTRING 3
#define FORMAT_SHAPESTRING 4
#define FORMAT_PROB 5
#define FORMAT_RANK 6
#define FORMAT_VERB 7

/* create a new format string entry */
static tformat_string *format_string_newentry(char type, char *string){
  tformat_string *f;
  f = (tformat_string *) mcalloc(1, sizeof(tformat_string));
  f->type   = type;
  f->string = mkstr(string);
  f->next   = NULL;
  return f;
}

/* free a complete format string structure */
static void format_string_free(tformat_string *l){
  tformat_string *t, *tn;
  t=l;
  while (t){
    tn = t->next;
    free(t->string);
    free(t);
    t = tn;
  }
}

/* error handling for format strings; print error and use mode -o 2 instead */
static void format_string_error(char *s, char c){
  printf(s, c);
  printf("Using default output mode instead (-o 2).\n");
  setOutputMode(2);
}

/* build a format string structure for the given string */
static tformat_string *format_string_build(char *s){
  char *t;
  char type;
  int pos, tpos;
  tformat_string *fs, *tfs, *ffs;

  if (strlen(s)>FORMAT_LENGTH) {
    format_string_error("Format string too long\n", 0);
    return(format_string_struct);
  }

  t = (char *) mcalloc(FORMAT_LENGTH+1, sizeof(char));
  tfs = NULL; ffs = NULL;

  pos = 0;  tpos = 0;

  while (s[pos]) {
    switch (s[pos++]) {
      case 'E':
        type = FORMAT_ENERGY;
        break;
      case 'R':
        type = FORMAT_SHREPPROB;
        break;
      case 'D':
        type = FORMAT_DBSTRING;
        break;
      case 'S':
        type = FORMAT_SHAPESTRING;
        break;
      case 'P':
        type = FORMAT_PROB;
        break;
      case 'C':
        type = FORMAT_RANK;
        break;
      case 'V':
        type = FORMAT_VERB;
        break;
      default:
        format_string_error("Syntax error in format string: unexpected character '%c'.\n", s[pos-1] == 1 ? ' ' : s[pos-1]);
        return(format_string_struct);
    }
    if (s[pos++] != '{') {
      format_string_error("Syntax error in format string: '{' expected.\n", 0);
      return(format_string_struct);
    }
    else {
      tpos = 0;
      while (s[pos] && (s[pos] != '}')) {
	if (s[pos] == '\\') {
          pos++;
          switch (s[pos++]) {
  	    case 'n':
              t[tpos++] = '\n';
              break;
	    case 't':
              t[tpos++] = '\t';
              break;
	    case 'e':
              t[tpos++] = '\x1b';
              break;
            default:
              format_string_error("Syntax error in format string: unexpected character '\\%c'.\n", s[pos-1]);
              return(format_string_struct);
          }
        }
        else t[tpos++] = s[pos++];
      }
      t[tpos] = 0;
      fs = format_string_newentry(type, t);

      if (!ffs) ffs=fs;
      else      tfs->next = fs;
      tfs = fs;
    }
    pos++;
  }

  free(t);
  return ffs;
}

/* remove all ansi color command from the given string;
   used to calculate the correct number of leading spaces */
static void fs_remove_color_commands(char *s){
  char *t;
  int pos, tpos, l;
  t = s;
  l = strlen(s);
  pos = 0; tpos = 0;
  while (pos < l) {
    if (t[pos] == '\x1b') { while ((pos<l) && (t[pos]!='m')) pos++; }
    else t[tpos++] = t[pos];
    pos++;
  }
  t[tpos] = 0;
}

/* calculate the number of leading spaces for sequence output; example:

   <leading spaces>gucugcaugacugacugacugacuguagcugcaugcaugcaugcacugaugca
   (-20.4)         ....(((.....))).........((((.....))))................

*/
void fs_init_leading_space(char energy, char shrepProb, char dbString, char shapeString, char prob, char rank){
  tformat_string *itr;
  int pos;
  char dbinside;
  char *t, *s;

  s = t            = (char *) myalloc(adp_statmem, (FORMAT_LENGTH+100) * sizeof(char));
  leading_space_db = (char *) myalloc(adp_statmem, 100 * sizeof(char));

  dbinside = 0;
  itr = format_string_struct;
  while (itr) {
    switch(itr->type) {
      case FORMAT_ENERGY:
        if (energy) sprintf(s, itr->string, -10.0);
        break;
      case FORMAT_SHREPPROB:
        if (shrep_prob_show && shrepProb) sprintf(s, itr->string, 0.5);
        break;
      case FORMAT_DBSTRING:
        if (dbString) sprintf(s, "{");
        if (!dbinside) {
          sprintf(leading_space_db, itr->string, "{");
          fs_remove_color_commands(leading_space_db);
          pos = 0;
          while(leading_space_db[pos]) {
            if (leading_space_db[pos]=='{') {
              leading_space_db[pos]=0;
              break;
            }
            if ((leading_space_db[pos]=='\t') || (leading_space_db[pos]=='\n')) pos++;
            else leading_space_db[pos++]=' ';
          }
        }
        dbinside = 1;
        break;
      case FORMAT_SHAPESTRING:
        if (shapeString) sprintf(s, itr->string, "[][]");
        break;
      case FORMAT_PROB:
        if (prob) sprintf(s, itr->string, 0.5);
        break;
      case FORMAT_RANK:
        if (rank) sprintf(s, itr->string, 1);
        break;
      case FORMAT_VERB:
        sprintf(s, "%s", itr->string);
        break;
    }
    s = s + strlen(s);
    itr = itr->next;
  }
  fs_remove_color_commands(t);
  s[0] = 0;
  pos=0;
  while(t[pos]) {
    if (t[pos]=='{') {
      t[pos]=0;
      break;
    }
    if ((t[pos]=='\t') || (t[pos]=='\n')) pos++;
    else t[pos++]=' ';
  }

  if (!dbString || !dbinside) t[0]=0;
  leading_space = t;
}

/* free the leading spaces temp mem. */
void fs_free_leading_space(){
  free(leading_space);
  free(leading_space_db);
}

/* initialize a new format string */
void format_string_init(char *s){
  if (format_string_struct) format_string_free(format_string_struct);
  format_string_struct = format_string_build(s);
}

/* set predefined output modes */
void setOutputMode(int outputMode){
  if        (outputMode == 1) format_string_init("D{%s  }E{(%.2f)  }R{(%.7f)  }P{%.7f  }S{%s}C{  R = %d}V{\n}");
  else   if (outputMode == 2) format_string_init("E{%-8.2f}R{(%.7f)  }D{%s  }P{%.7f  }S{%s}C{  R = %d}V{\n}");
  else   if (outputMode == 3) format_string_init("E{%.2f }R{%.7f }D{%s }P{%.7f }S{%s}C{ %d}V{\n}");
  else                        format_string_init("E{%-8.2f}R{(%.7f)  }D{\x1b[1;31m%s\x1b[0m  }P{\x1b[1;30m%.7f\x1b[0m  }S{%s}C{  R = %d}V{\n}");
}

/* Output handling for sequences
  ====================================================================== */

/* print position numbers for sequence;
   used in window- and split-output modes  */
static void print_subseq_numbers(toptions *opts, int pos, int size){
  int i;
  if (opts->split_output_mode) size = min(opts->window_pos + opts->window_size, pos + opts->split_output_size) - pos;
  pcolor(opts->colored_output, COLOR_BLUE);
  printf("%d", pos +1);
  pcolor(opts->colored_output,COLOR_DEFAULT);

  for (i=1; i<= size - (((int)log10(pos + 1))+1 + ((int)log10(pos + size))+1); i++) printf(" ");
  pcolor(opts->colored_output,COLOR_BLUE);
  printf("%d", pos + size);
  pcolor(opts->colored_output,COLOR_DEFAULT);
  printf("\n");
}

/* print the given subsequence of a sequence */
static void print_subseq(char *fs, char *s, int offset, int pos, int size){
  int i, tpos;
  char *tmp;

  tmp     = (char*) mcalloc(2*strlen(s), sizeof(char));
  tpos = 0;
  for (i=pos+1; i <= pos + size; i++)
    if (i <= strlen(s)) tmp[tpos++] = s[offset+i-1];
    else                tmp[tpos++] = ' ';
  tmp[tpos] = 0;
  printf(fs, tmp);
  free(tmp);
}

/* same as print_subseq; used in color mode */
static void print_subseq_color(char *fs, char *s, int pos, int size){
  int i,c,tpos,ls;
  char e;
  char *lastcol, *tmp, *tmp2;
  int plastcol;

  ls      = strlen(s);
  lastcol = (char*) mcalloc(20,    sizeof(char));
  tmp     = (char*) mcalloc(20*ls, sizeof(char));
  tmp2    = (char*) mcalloc(20*ls, sizeof(char));

  plastcol = -1;

  // go to character pos+1:
  c=0; i=0; e=0;
  while (c<pos+1) {
    if      (s[i] == '\x1b')     { e = 1; plastcol = 0; }
    else if ((s[i] == 'm') && e) e = 0;
    else if (e)                  lastcol[plastcol++] = s[i];
    else                         c++;
    i++;
  }
  if (plastcol != -1) lastcol[plastcol] = 0;
  tpos = 0;
  while (c<=pos+size) {
    if (c <= ls) tmp2[tpos++] = s[i-1];
    else                tmp2[tpos++] = ' ';
    if      (s[i] == '\x1b')       e = 1;
    else if ((s[i] == 'm') && e) e = 0;
    else if (e)                  ;
    else                         c++;
    i++;
  }
  tmp2[tpos] = 0;
  strcat(tmp2, "\x1b[0m");
  tmp[0]=0;
  if (plastcol != -1) sprintf(tmp, "\x1b%sm", lastcol);
  strcat(tmp, tmp2);
  printf(fs, tmp);
  free(lastcol);
  free(tmp);
  free(tmp2);
}

/* main entry function for sequence output */
void print_sequence(toptions *opts, tsequence *seq, int pos, int size){
  if (!opts->split_output_mode) {
    if (opts->window_mode) {
      printf("%s%s", leading_space, leading_space_db);
      print_subseq_numbers(opts, pos, size);
    }
    printf("%s%s", leading_space, leading_space_db);
    print_subseq("%s", seq->original_seq, pos, 0, size);
    printf("\n");
  }
}

/* used in window-mode to shift the input sequence */
void shift_input(toptions *opts, tsequence *seq, char output){
  int i;

/*   printf("window_pos:        %d\n", opts->window_pos); */
/*   printf("window_size:       %d\n", opts->window_size); */
/*   printf("seq->seq:          %s\n", seq->seq); */
/*   printf("seq->original_seq: %s\n", seq->original_seq); */

  for (i=opts->window_pos; i<=opts->window_pos + opts->window_size; i++)
    seq->seq[i-opts->window_pos] = seq->original_seq[i];
  if (number_of_graphics) {
    for (i=opts->window_pos; i<=opts->window_pos + opts->window_size; i++)
       graphics_sequence[i-opts->window_pos] = seq->original_seq[i];
    graphics_sequence[strlen(seq->seq)] = 0;
  }
  convert_input(0, seq->seq, opts->window_size);
  if (output) print_sequence(opts, seq, opts->window_pos, opts->window_size);
}

/* from db2shape-cl */
struct dbcol_result{
  char *dbstr;
  char *shapestr;
};
// TODO  struct dbcol_result *calc_db2shape_cl(char *input, int st, int _maxloop);

/* main entry function for rna result output */
void output_result
  (toptions *opts, tsequence *seq,
   int nres, int *energy, double *shrepProb, char *dbString, char *shapeString, double prob, int rank){

  int pos, size;
  tformat_string *itr;
  char colors;

  itr = format_string_struct;
  colors = colored_db2shape && dbString;
  if (colors) {
    // TODO  dbcol = calc_db2shape_cl(dbString, global_shapetype, maxloop);
    // TODO  dbString    = dbcol->dbstr;
    // TODO  shapeString = dbcol->shapestr;
  }
  while (itr) {
    switch(itr->type) {
      case FORMAT_ENERGY:
        if (energy) printf(itr->string, (float) *energy / 100);
        break;
      case FORMAT_SHREPPROB:
        if (shrep_prob_show && shrepProb) printf(itr->string, *shrepProb);
        break;
      case FORMAT_DBSTRING:
        if (dbString) {
          if (!opts->split_output_mode) printf(itr->string, dbString);
          else {
            for (pos = 0; pos < opts->window_size; pos += opts->split_output_size) {
              size = opts->split_output_size;
              if (pos) printf("%s%s", leading_space, leading_space_db);
              else     printf("%s", leading_space_db);
              print_subseq_numbers(opts, pos + opts->window_pos, size);
              printf("%s%s", leading_space, leading_space_db);
              print_subseq("%s", seq->original_seq, opts->window_pos, pos, size);
              printf("\n");
              printf("%s", leading_space);
              if (colors) print_subseq_color(itr->string, dbString, pos, size);
              else        print_subseq      (itr->string, dbString, 0, pos, size);
              if (pos + opts->split_output_size < opts->window_size) printf("\n");
            }
          }
        }
        break;
      case FORMAT_SHAPESTRING:
        if (shapeString) if (shapeString[0]==0) printf(itr->string, "_");
                  else                   printf(itr->string, shapeString);
        break;
      case FORMAT_PROB:
        if (prob >= 0) printf(itr->string, prob);
        break;
      case FORMAT_RANK:
        if (rank >= 0) printf(itr->string, rank);
        break;
      case FORMAT_VERB:
        printf("%s",itr->string);
        break;
    }
    itr = itr->next;
    // free colored strings:
    if (colors) {
      // TODO  free(dbcol->dbstr);
      // TODO  free(dbcol->shapestr);
      // TODO  free(dbcol);
    }
    // TODO if (dbString) rna_plot(nres, dbString_org, energy, prob, shapeString_org);
  }
}


/* Initialize all stuff from adplib
  ====================================================================== */

void adplib_init(toptions *opts, tsequence *seq, char **z, int *n){
  *z = (char *) seq->seq - 1;
  if (opts->window_mode) {
    *n = min(opts->window_size, seq->length);
  }
  else {
    *n = seq->length;
    opts->window_size = seq->length;
  }
  opts->window_size = min(opts->window_size, seq->length);
  adp_dynmem  = memory_new();
  adp_statmem = memory_new();
  libPP_init(seq);

  setOutputMode(1);
  init_iupac_base();
  fs_init_leading_space(1,1,1,1,1,1);
}

void adplib_free(toptions *opts, tsequence *seq){
  memory_free(adp_dynmem);
  memory_free(adp_statmem);
}

/* ---------------------------------------------------------------------------
rnalib.h
RNA energy library, based on Haskell implementation by Jens Reeder
Author: Peter Steffen
$Date: 2006/04/18 08:40:55 $
--------------------------------------------------------------------------- */


// alphabet size (A,C,G,U,N)
#define ASIZE 5
#define inp(I) z[I]
#define d_inp(I) d_z[I]

/* basepair and stackpair predicates */

extern __shared__ char memory[] ;

// --------

#ifdef SHARED_OFFSET
#define d_offset ((int *) (memory))
#define dd_offset(I) d_offset[I]
#define memory_o (memory + 8010)
#else
#define dd_offset(I) (((I)*((I)+1))/2)
#define memory_o memory
#endif


//__device__ char *g_z;
//__device__ int *d_columns ;


// #ifdef SHARED_Z
// #define d_z (memory)
// #define memory_e (memory_o + 2010)
// #else
// #define d_z g_z
// #define memory_e memory_o
// #endif


// ------------

#ifdef SHARED_ENERGY

#define d_canPair (memory_e + 150)
#define d_stack_dg ((int *) (memory_e + 200))
#define d_tstacki_dg ((int *) (memory_e + 2800))
#define d_termaupenalty_ar ((int *) (memory_e + 5400))
#define d_il_ent_ar ((int *) (memory_e + 5600))
#define d_bl_ent_ar ((int *) (memory_e + 5800))
#define d_hl_ent_ar ((int *) (memory_e + 6000))
#define memory_s (memory_e + 6040)

#define d_basepairing(I,J)  ((I+1 < J) && d_canPair[index2(d_inp((I)+1),d_inp(J))])
#define d_stackpairing(I,J) ((I+3 < J) && d_canPair[index2(d_inp((I)+1),d_inp(J))] && d_canPair[index2(d_inp((I)+2),d_inp((J)-1))])

#define d_stack_dg_ac(I,J,K,L) d_stack_dg [index4(d_inp(I),d_inp(J),d_inp(K),d_inp(L))]
#define d_sr_energy(I,J) d_stack_dg [index4(d_inp((I)),d_inp((I)+1),d_inp((J)-1),d_inp((J)))]
#define d_il_stack(I,J,K,L) (d_tstacki_dg[index4(d_inp((I)),d_inp((I)+1),d_inp((L)),d_inp((L)+1))] + \
			     d_tstacki_dg[index4(d_inp((J)+1),d_inp((J)),d_inp((K)+1),d_inp((K)))])
#define d_termaupenalty(I,J) d_termaupenalty_ar[index2(d_inp(I),d_inp(J))]

#else

#define memory_s memory_e

#define d_canPair g_canPair
#define d_stack_dg g_stack_dg
#define d_tstacki_dg g_tstacki_dg
#define d_termaupenalty_ar g_termaupenalty_ar
#define d_il_ent_ar g_il_ent_ar
#define d_bl_ent_ar g_bl_ent_ar
#define d_hl_ent_ar g_hl_ent_ar

#define d_basepairing(I,J)  ((I+1 < J) && d_canPair[d_inp((I)+1)][d_inp(J)])
#define d_stackpairing(I,J) ((I+3 < J) && d_canPair[d_inp((I)+1)][d_inp(J)] && d_canPair[d_inp((I)+2)][d_inp((J)-1)])
#define d_stack_dg_ac(I,J,K,L) d_stack_dg[d_inp(I)][d_inp(J)][d_inp(K)][d_inp(L)]
#define d_sr_energy(I,J) d_stack_dg[d_inp((I))][d_inp((I)+1)][d_inp((J)-1)][d_inp((J))]
#define d_il_stack(I,J,K,L) (d_tstacki_dg[d_inp((I))][d_inp((I)+1)][d_inp((L))][d_inp((L)+1)] + \
                             d_tstacki_dg[d_inp((J)+1)][d_inp((J))][d_inp((K)+1)][d_inp((K))])

#define d_termaupenalty(I,J) d_termaupenalty_ar[d_inp(I)][d_inp(J)]


#endif





/////

#define basepairing(I,J)  ((I+1 < J) && canPair[inp((I)+1)][inp(J)])
char canStackPair[ASIZE][ASIZE][ASIZE][ASIZE];

#define stackpairing(I,J) ((I+3 < J) && canPair[inp((I)+1)][inp(J)] && canPair[inp((I)+2)][inp((J)-1)])

/* alternative definition of basepair, working on characters */
char basepair(int i, int j);
__device__ char d_basepair(int i, int j);

/* Constants     */
/* ------------- */

#define const_e    (2.718281828459)
#define mean_scale (1.34855)

/* Energy tables          */
/* ---------------------- */

/* The Jacobson-Stockmayer term for loop interpolation. */
#define jacobson_stockmayer(size) (107.856*log((size)/30.0))

#define UNDEF 1000000

char canPair[ASIZE][ASIZE];
__device__ __constant__ char g_canPair[ASIZE][ASIZE];

int stack_dg          [ASIZE][ASIZE][ASIZE][ASIZE];
__device__ __constant__ int g_stack_dg          [ASIZE][ASIZE][ASIZE][ASIZE];
int hl_ent_ar             [31];
__device__ __constant__ int g_hl_ent_ar[31];
int tstackh_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
__device__ __constant__ int d_tstackh_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
int hl_tetra          [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
__device__  int d_hl_tetra          [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
int bl_ent_ar             [31];
__device__ __constant__ int g_bl_ent_ar[31];
int il_ent_ar             [31];
__device__ __constant__ int g_il_ent_ar[31];
int tstacki_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
__device__ __constant__ int g_tstacki_dg        [ASIZE][ASIZE][ASIZE][ASIZE];
int dr_dangle_dg      [ASIZE][ASIZE][ASIZE];
__device__ __constant__ int d_dr_dangle_dg      [ASIZE][ASIZE][ASIZE];
int dl_dangle_dg      [ASIZE][ASIZE][ASIZE];
__device__ __constant__ int d_dl_dangle_dg      [ASIZE][ASIZE][ASIZE];
int termaupenalty_ar  [ASIZE][ASIZE];
__device__ __constant__ int g_termaupenalty_ar  [ASIZE][ASIZE];

int intloop11      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
__device__ int d_intloop11      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
int intloop21      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
__device__ int d_intloop21      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
int intloop22      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
__device__ int d_intloop22      [ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE][ASIZE];
double *scale_ar;
__device__ double *d_scale_ar;

//#include "d_energy.cu"

/* Energy Functions                          */
/* ----------------------------------------- */

#define index2(I,J) (I*ASIZE + J)
#define index3(I,J,K) (index2(index2(I, J), K))
#define index4(I,J,K,L) (index3(index2(I, J), K, L))
#define index5(I,J,K,L,M) (index4(index2(I, J), K, L, M))
#define index6(I,J,K,L,M,N) (index5(index2(I, J), K, L, M, N))
#define index7(I,J,K,L,M,N,O) (index6(index2(I, J), K, L, M, N, O))
#define index8(I,J,K,L,M,N,O,P) (index7(index2(I, J), K, L, M, N, O, P))



#define stack_dg_ac(I,J,K,L) stack_dg[inp(I)][inp(J)][inp(K)][inp(L)]
#define sr_energy(I,J) stack_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]

#define hl_ent(size) ((size) <= 30 ? hl_ent_ar[size] : 769 + jacobson_stockmayer(i))
#define d_hl_ent(size) ((size) <= 30 ? d_hl_ent_ar[size] : 769 + jacobson_stockmayer(i))

#define hl_stack(I,J) tstackh_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]
#define d_hl_stack(I,J) d_tstackh_dg[d_inp((I))][d_inp((I)+1)][d_inp((J)-1)][d_inp((J))]


int hl_energy(int i, int j);
//__device__ int d_hl_energy(int i, int j);

#define bl_ent(size) ((size) <= 30 ? bl_ent_ar[size] : 609 + jacobson_stockmayer(i))
#define d_bl_ent(size) ((size) <= 30 ? d_bl_ent_ar[size] : 609 + jacobson_stockmayer(i))

int bl_energy(int bl, int i, int j, int br);
//__device__ int d_bl_energy(int bl, int i, int j, int br);
int br_energy(int bl, int i, int j, int br);
//__device__ int d_br_energy(int bl, int i, int j, int br);

#define il_ent(size) ((size) <= 30 ? il_ent_ar[size] : 369 + jacobson_stockmayer(i))
#define d_il_ent(size) ((size) <= 30 ? d_il_ent_ar[size] : 369 + jacobson_stockmayer(i))

#define il_stack(I,J,K,L) (tstacki_dg[inp((I))][inp((I)+1)][inp((L))][inp((L)+1)] + \
                           tstacki_dg[inp((J)+1)][inp((J))][inp((K)+1)][inp((K))])


int il_energy(int i, int j, int k, int l);
//__device__ int d_il_energy(int i, int j, int k, int l);

#define dr_energy(I,J)  dr_dangle_dg[inp((I))][inp((J))][inp((J)+1)]
#define d_dr_energy(I,J)  d_dr_dangle_dg[d_inp((I))][d_inp((J))][d_inp((J)+1)]
#define dli_energy(I,J) dr_dangle_dg[inp((J))][inp((I))][inp((I)+1)]
#define d_dli_energy(I,J) d_dr_dangle_dg[d_inp((J))][d_inp((I))][d_inp((I)+1)]

#define dl_energy(I,J)  dl_dangle_dg[inp((I)-1)][inp((I))][inp((J))]
#define d_dl_energy(I,J)  d_dl_dangle_dg[d_inp((I)-1)][d_inp((I))][d_inp((J))]
#define dri_energy(I,J) dl_dangle_dg[inp((J)-1)][inp((J))][inp((I))]
#define d_dri_energy(I,J) d_dl_dangle_dg[d_inp((J)-1)][d_inp((J))][d_inp((I))]

#define ss_energy(I,J) 0
#define d_ss_energy(I,J) 0

#define dangles(i,j,i2,j2,k,l,k2,l2) ((dli_energy(j,k+1) + dri_energy(j2,k2+1)))
#define d_dangles(i,j,i2,j2,k,l,k2,l2) ((d_dli_energy(j,k+1) + d_dri_energy(j2,k2+1)))
#define sspenalty(a) (npp * (a))
#define d_sspenalty(a) (d_npp * (a))

#define termaupenalty(I,J) termaupenalty_ar[inp(I)][inp(J)]

#define mk_pf(X) (exp ((X)/ (-61.6321)))
#define scale(size) scale_ar[size]
#define d_scale(size) d_scale_ar[size]

/* initializations */
void rnalib_init(toptions *opts, tsequence *seq);
void rnalib_free();

/* ---------------------------------------------------------------------------
rnalib.c
RNA energy library, based on Haskell implementation by Jens Reeder
Author: Peter Steffen
$Date: 2006/04/18 08:40:51 $
--------------------------------------------------------------------------- */


/* ---------------------------------------------------------------------------------------------------- */
/* input handling                                                                                       */
/* ---------------------------------------------------------------------------------------------------- */

/* The alphabet */
#define A 0
#define C 1
#define G 2
#define U 3
#define N 4

static int   n;
static int   d_n;
static char *z;
static char *d_z;

#ifdef DIFF3
#define ROUND_THREADS
#endif



/* initialize basepair predicate */
static void init_canPair(){
  if(fread(canPair, sizeof(char), ASIZE*ASIZE, energyFile) != ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_canPair", (char *) canPair,
				    ASIZE*ASIZE*sizeof(char), 0,
				    cudaMemcpyHostToDevice));
}


/* initialize stackpair predicate */
static void init_canStackPair(){
  if(fread(canStackPair, sizeof(char), ASIZE*ASIZE*ASIZE*ASIZE, energyFile) != ASIZE*ASIZE*ASIZE*ASIZE)
    printf("File read error.");

/* // no, it's recomputed from d_canPair
  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_canStackPair", (char *) canStackPair,
				    ASIZE*ASIZE*ASIZE*ASIZE*sizeof(char), 0,
				    cudaMemcpyHostToDevice));
*/
}

/* alternative definition of basepair, working on characters */
char basepair(int i, int j){
  return(((z[i] == 'a') && (z[j] == 'u')) ||
         ((z[i] == 'u') && (z[j] == 'a')) ||
         ((z[i] == 'c') && (z[j] == 'g')) ||
         ((z[i] == 'g') && (z[j] == 'c')) ||
         ((z[i] == 'g') && (z[j] == 'u')) ||
         ((z[i] == 'u') && (z[j] == 'g')));
}

//__device__ char d_basepair(int i, int j){
//  return(((d_z[i] == 'a') && (d_z[j] == 'u')) ||
//         ((d_z[i] == 'u') && (d_z[j] == 'a')) ||
//         ((d_z[i] == 'c') && (d_z[j] == 'g')) ||
//         ((d_z[i] == 'g') && (d_z[j] == 'c')) ||
//         ((d_z[i] == 'g') && (d_z[j] == 'u')) ||
//         ((d_z[i] == 'u') && (d_z[j] == 'g')));
//}


/* ---------------------------------------------------------------------------------------------------- */
/* Energy stuff                                                                                         */
/* ---------------------------------------------------------------------------------------------------- */

/* subword length */
#define size_of(I,J) ((J)-(I))

/* Some constants and utilities */
/* ---------------------------- */


/* ---------------------------------------------------------------------------------------------------- */
/* Stacking Region Energies                                                                             */
/* ---------------------------------------------------------------------------------------------------- */
/*
   Stabilizing energies for canonical basepairs: AU, CG, GU
   Basepairing: Parameters are in 5' 3' order.
   stack_dg a b c d
            ^ ^ ^ ^
            | |_| |
            |_____|
*/

static void init_stack_dg()
{
  if(fread(stack_dg, sizeof(int), ASIZE*ASIZE*ASIZE*ASIZE, energyFile) != ASIZE*ASIZE*ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_stack_dg", (int *) stack_dg,
				    ASIZE*ASIZE*ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* ---------------------------------------------------------------------------------------------------- */
/* Hairpin Loop Energies                                                                                */
/* ---------------------------------------------------------------------------------------------------- */

static void init_hl_ent_ar()
{
  if(fread(hl_ent_ar, sizeof(int), 31, energyFile) != 31)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_hl_ent_ar", (int *) hl_ent_ar,
				    31*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* Stacking Interaction           */
/* ------------------------------ */

static void init_tstackh_dg()
{
  if(fread(tstackh_dg, sizeof(int), ASIZE*ASIZE*ASIZE*ASIZE, energyFile) != ASIZE*ASIZE*ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_tstackh_dg", (int *) tstackh_dg,
				    ASIZE*ASIZE*ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

#define hl_stack(I,J) tstackh_dg[inp((I))][inp((I)+1)][inp((J)-1)][inp((J))]
#define d_hl_stack(I,J) d_tstackh_dg[d_inp((I))][d_inp((I)+1)][d_inp((J)-1)][d_inp((J))]

/* Tetraloop Bonus Energies       */
/* ------------------------------ */
/*  Ultrastable tetra-loops & energy bonus at 37 °C: */

static void init_hl_tetra()
{
  if(fread(hl_tetra, sizeof(int), ASIZE*ASIZE*ASIZE*ASIZE*ASIZE*ASIZE, energyFile) != ASIZE*ASIZE*ASIZE*ASIZE*ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_hl_tetra", (int *) hl_tetra,
				    ASIZE*ASIZE*ASIZE*ASIZE*ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* Terminal AU penalty is included in hl_stack,  */
/* therefore it must be added explicitely only for (size == 3) */

int hl_energy(int i, int j){
  int size;
  int entropy;
  int tetra_bonus, stack_mismatch;
  int termaupen;

  size           = j-i-1;
  entropy        = hl_ent(size);
  stack_mismatch = hl_stack(i,j);
  tetra_bonus    = hl_tetra[inp(i)][inp(i+1)][inp(i+2)][inp(i+3)][inp(i+4)][inp(i+5)];
  termaupen      = termaupenalty_ar[inp(i)][inp(j)];

  if (size==3) return(entropy + termaupen);
  if (size==4) return(entropy + stack_mismatch + tetra_bonus);
  if (size>4)  return(entropy + stack_mismatch);
  printf("hairpin loop < 3 found. Please use production\n");
  printf("  hl <<< lbase -~~ (region `with` minsize 3)  ~~- lbase\n");
  printf("in your grammar.\n");
  exit(1);
}

//__device__ int d_hl_energy(int i, int j){
//  int size;
//  int entropy;
//  int tetra_bonus, stack_mismatch;
//  int termaupen;
//
//  size           = j-i-1;
//  entropy        = d_hl_ent(size);
//  stack_mismatch = d_hl_stack(i,j);
//  tetra_bonus    = d_hl_tetra[d_inp(i)][d_inp(i+1)][d_inp(i+2)][d_inp(i+3)][d_inp(i+4)][d_inp(i+5)];
//  termaupen      = d_termaupenalty_ar[d_inp(i)][d_inp(j)];
//
//  if (size==3) return(entropy + termaupen);
//  if (size==4) return(entropy + stack_mismatch + tetra_bonus);
//  if (size>4)  return(entropy + stack_mismatch);
//  printf("hairpin loop < 3 found. Please use production\n");
//  printf("  hl <<< lbase -~~ (region `with` minsize 3)  ~~- lbase\n");
//  printf("in your grammar.\n");
//  exit(1);
//}
//
/* ---------------------------------------------------------------------------------------------------- */
/* Bulge Loop Energies                                                                                  */
/* ---------------------------------------------------------------------------------------------------- */

static void init_bl_ent_ar()
{
  if(fread(bl_ent_ar, sizeof(int), 31, energyFile) != 31)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_bl_ent_ar", (int *) bl_ent_ar,
				    31*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* Bulge Loop Left                */
/* ------------------------------ */
/*
      											  .        .
      											  .        .
										       (bl+3) - (br-2)
 If size == 1 the terminal aupenalty for the stem starting after the bulge (that is    (bl+2) - (br-1))
										    bl+1
										          bl  -   br

 is added possibly. This is unwanted. Since we do not have a chance to check the size of the bulge when parsing the stem
 we substract the possible penalty here!
*/

int bl_energy(int bl, int i, int j, int br){
  int stacking, size, entropy;

  stacking    = stack_dg[inp(bl)][inp(j+1)][inp(br-1)][inp(br)];
  size        = size_of(i,j);
  entropy     = bl_ent(size);

  if     (size==1)  return(stacking + entropy - termaupenalty_ar[inp(bl+2)][inp(br-1)]);
  else if (size>1)  return(entropy + termaupenalty_ar[inp(bl)][inp(br)]);
  else {printf("bl_energy size < 1\n"); exit(-1);}
}

//__device__ int d_bl_energy(int bl, int i, int j, int br){
//  int stacking, size, entropy;
//
//  stacking    = d_stack_dg[d_inp(bl)][d_inp(j+1)][d_inp(br-1)][d_inp(br)];
//  size        = size_of(i,j);
//  entropy     = d_bl_ent(size);
//
//  if     (size==1)  return(stacking + entropy - d_termaupenalty_ar[d_inp(bl+2)][d_inp(br-1)]);
//  else if (size>1)  return(entropy + d_termaupenalty_ar[d_inp(bl)][d_inp(br)]);
//  else {printf("bl_energy size < 1\n"); exit(-1);}
//}


/* Bulge Loop Right               */
/* ------------------------------ */

int br_energy(int bl, int i, int j, int br){
  int stacking, size, entropy;

  stacking    = stack_dg[inp(bl)][inp(bl+1)][inp(i)][inp(br)];
  size        = size_of(i,j);
  entropy     = bl_ent(size);

  if (size==1) return(stacking + entropy - termaupenalty_ar[inp(bl+1)][inp(br-2)]);
  else return(entropy + termaupenalty_ar[inp(bl)][inp(br)]);
}

//__device__ int d_br_energy(int bl, int i, int j, int br){
//  int stacking, size, entropy;
//
//  stacking    = d_stack_dg[d_inp(bl)][d_inp(bl+1)][d_inp(i)][d_inp(br)];
//  size        = size_of(i,j);
//  entropy     = d_bl_ent(size);
//
//  if (size==1) return(stacking + entropy - d_termaupenalty_ar[d_inp(bl+1)][d_inp(br-2)]);
//  if (size>1)  return(entropy + d_termaupenalty_ar[d_inp(bl)][d_inp(br)]);
//}


/* ---------------------------------------------------------------------------------------------------- */
/* Interior Loop Energies                                                                               */
/* ---------------------------------------------------------------------------------------------------- */

/* Entropic Term                  */
/* ------------------------------ */
/*
  DESTABILIZING ENERGIES BY SIZE OF LOOP

  il_ent 1 and 2 undefined in the tables of Mathews et al. since
  special energy values exist
*/


static void init_il_ent_ar()
{
  if(fread(il_ent_ar, sizeof(int), 31, energyFile) != 31)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_il_ent_ar", (int *) il_ent_ar,
				    31*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* Stacking Interaction           */
/* ------------------------------ */
/*

STACKING ENERGIES : TERMINAL MISMATCHES AND BASE-PAIRS.

Stabilizing energies for canonical basepairs: AU, CG, GU
Basepairing: Paramers are in 5' 3' order.
tstacki_dg a b c d
           ^ ^ ^ ^
           | |_| |
           |_____|

*/

static void init_tstacki_dg()
{
  if(fread(tstacki_dg, sizeof(int), ASIZE*ASIZE*ASIZE*ASIZE, energyFile) != ASIZE*ASIZE*ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_tstacki_dg", (int *) tstacki_dg,
				    ASIZE*ASIZE*ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/*
the time intensive n^4 version of internal loops
(used in reduced form O(n^2*c^2) where c is the maximal internal loop size)

(i,j) = left region, (k,l) = right region

        i --- l+1
 5'    /        \    3'
 |   i+1         l  / \
 |    |          |   |
\ /   |          |   |
 3'   |          |   5'
      j         k+1
       \        /
        j+1 --- k

*/

/* Ninio's equation */
#define il_asym(SL,SR) min(300,((abs((SL)-(SR)))*50))
#define d_il_asym(SL,SR) min(300,((abs((SL)-(SR)))*50))

/* include internal loop energies */
//#include "intloop11.c"
//#include "intloop21.c"
//#include "intloop22.c"

#define il11_energy(lb,rb) intloop11[inp((lb))][inp((lb)+1)][inp((lb)+2)][inp((rb)-2)][inp((rb)-1)][inp((rb))]
#define d_il11_energy(lb,rb) d_intloop11[d_inp((lb))][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((rb)-2)][d_inp((rb)-1)][d_inp((rb))]

#define il12_energy(lb,rb) intloop21[inp(lb)][inp((lb)+1)][inp((lb)+2)][inp((rb)-3)][inp((rb)-2)][inp((rb)-1)][inp(rb)]
#define d_il12_energy(lb,rb) d_intloop21[d_inp(lb)][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((rb)-3)][d_inp((rb)-2)][d_inp((rb)-1)][d_inp(rb)]
#define il21_energy(lb,rb) intloop21[inp((rb)-2)][inp((rb)-1)][inp(rb)][inp(lb)][inp((lb)+1)][inp((lb)+2)][inp((lb)+3)]
#define d_il21_energy(lb,rb) d_intloop21[d_inp((rb)-2)][d_inp((rb)-1)][d_inp(rb)][d_inp(lb)][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((lb)+3)]

#define int22_energy(a,b,c,d,e,f,g,h) intloop22[inp(a)][inp(b)][inp(c)][inp(d)][inp(e)][inp(f)][inp(g)][inp(h)]
#define d_int22_energy(a,b,c,d,e,f,g,h) d_intloop22[d_inp(a)][d_inp(b)][d_inp(c)][d_inp(d)][d_inp(e)][d_inp(f)][d_inp(g)][d_inp(h)]
#define il22_energy(lb,rb) int22_energy(lb,((lb)+1),((lb)+2),((lb)+3),((rb)-3),((rb)-2),((rb)-1),rb)
#define d_il22_energy(lb,rb) d_int22_energy(lb,((lb)+1),((lb)+2),((lb)+3),((rb)-3),((rb)-2),((rb)-1),rb)


int il_energy(int i, int j, int k, int l)
{
  int sl, sr;
  sl = size_of(i,j);
  sr = size_of(k,l);
  if ((sl > 2) || (sr > 2))
    return((il_ent (sl + sr))
         + (il_stack (i,j,k,l))
         + (il_asym(sl,sr))); else
  if ((sl == 1) && (sr == 1)) return(il11_energy(i,l+1)); else
  if ((sl == 1) && (sr == 2)) return(il12_energy(i,l+1)); else
  if ((sl == 2) && (sr == 1)) return(il21_energy(i,l+1)); else
  if ((sl == 2) && (sr == 2)) return(il22_energy(i,l+1)); else
  return 65000;
}

//__device__ int d_il_energy(int i, int j, int k, int l)
//{
//  int sl, sr;
//  sl = size_of(i,j);
//  sr = size_of(k,l);
//  if ((sl > 2) || (sr > 2))
//    return((d_il_ent (sl + sr))
//         + (d_il_stack (i,j,k,l))
//         + (d_il_asym(sl,sr))); else
//  if ((sl == 1) && (sr == 1)) return(d_il11_energy(i,l+1)); else
//  if ((sl == 1) && (sr == 2)) return(d_il12_energy(i,l+1)); else
//  if ((sl == 2) && (sr == 1)) return(d_il21_energy(i,l+1)); else
//  if ((sl == 2) && (sr == 2)) return(d_il22_energy(i,l+1)); else
//  return 65000;
//}


/* ---------------------------------------------------------------------------------------------------- */
/* Dangling ends                                                                                        */
/* ---------------------------------------------------------------------------------------------------- */

/* dangle right                   */
/* ------------------------------ */

static void init_dr_dangle_dg()
{
  if(fread(dr_dangle_dg, sizeof(int), ASIZE*ASIZE*(ASIZE), energyFile) != ASIZE*ASIZE*(ASIZE))
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_dr_dangle_dg", (int *) dr_dangle_dg,
				    ASIZE*ASIZE*(ASIZE)*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* dangle left                    */
/* ------------------------------ */

static void init_dl_dangle_dg()
{
  if(fread(dl_dangle_dg, sizeof(int), (ASIZE)*ASIZE*ASIZE, energyFile) != (ASIZE)*ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_dl_dangle_dg", (int *) dl_dangle_dg,
				    (ASIZE)*ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

#define ss_energy(I,J) 0
#define d_ss_energy(I,J) 0


/* ---------------------------------------------------------------------------------------------------- */
/* special pseudoknot energies                                                                          */
/* ---------------------------------------------------------------------------------------------------- */

/* This are the dangling energies for the bases bridging the stacks */

#define dangles(i,j,i2,j2,k,l,k2,l2) ((dli_energy(j,k+1) + dri_energy(j2,k2+1)))
#define d_dangles(i,j,i2,j2,k,l,k2,l2) ((d_dli_energy(j,k+1) + d_dri_energy(j2,k2+1)))
#define sspenalty(a) (npp * (a))
#define d_sspenalty(a) (d_npp * (a))

/* ---------------------------------------------------------------------------------------------------- */
/* Terminal AU penalty                                                                                  */
/* ---------------------------------------------------------------------------------------------------- */

static void init_termaupenalty_ar()
{
  if(fread(termaupenalty_ar, sizeof(int), ASIZE*ASIZE, energyFile) != ASIZE*ASIZE)
    printf("File read error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("g_termaupenalty_ar", (int *) termaupenalty_ar,
				    ASIZE*ASIZE*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

/* internal loop energies */
static void  init_intloop11(){
 if(fread(intloop11, sizeof(int), (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE), energyFile) != (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE))
    printf("File write error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_intloop11", (int *) intloop11,
				    (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

static void  init_intloop21(){
 if(fread(intloop21, sizeof(int), (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE), energyFile) !=
     (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE))
       printf("File write error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_intloop21", (int *) intloop21,
				    (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}

static void  init_intloop22(){
  if(fread(intloop22, sizeof(int), (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE), energyFile) !=
     (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE))
       printf("File write error.");

  CUDA_SAFE_CALL(cudaMemcpyToSymbol("d_intloop22", (int *) intloop22,
				    (ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*(ASIZE)*sizeof(int), 0,
				    cudaMemcpyHostToDevice));

}


/* ---------------------------------------------------------------------------------------------------- */
/* Scale                                                                                                */
/* ---------------------------------------------------------------------------------------------------- */

static void init_scale_ar()
{
  int i;
  scale_ar=(double *) mcalloc(n+2, sizeof(double));
  scale_ar[0] = 1.0;
  for (i = 1; i<= n; i++) {
    scale_ar[i] = scale_ar[i-1] / mean_scale;
  }
}

/* ---------------------------------------------------------------------------------------------------- */
/* Initialize rna input and energy tables                                                                         */
/* ---------------------------------------------------------------------------------------------------- */

void rnalib_init(toptions *opts, tsequence *seq)
{
  /* initialize input and pairing tables */
  z    = seq->seq - 1;
  n    = seq->length;

  convert_input(1, z, n);

  CUDA_SAFE_CALL(cudaMalloc((void **) &d_z, (n+2)*sizeof(char)));
  cudaMemcpy(d_z, z, (n+2)*sizeof(char), cudaMemcpyHostToDevice);
  d_n=n;

  if((energyFile=fopen(ENERGYFILE, "rb"))==NULL) {
    printf("Cannot open file %s.\n",ENERGYFILE);
    exit(1);
  }

  init_canPair();
  init_canStackPair();

  /* initialize energies */
  init_stack_dg();
  init_hl_ent_ar();
  init_tstackh_dg();
  init_hl_tetra();
  init_bl_ent_ar();
  init_il_ent_ar();
  init_tstacki_dg();
  init_dr_dangle_dg();
  init_dl_dangle_dg();
  init_termaupenalty_ar();

  init_intloop11();
  init_intloop21();
  init_intloop22();

  init_scale_ar();

  fclose(energyFile);

}

void rnalib_free()
{
  free(scale_ar);
}


/* data structures                                                                  */
/* -------------------------------------------------------------------------------- */
#define size_of(I,J) ((J)-(I))
#define d_il11_energy(lb,rb) d_intloop11[d_inp((lb))][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((rb)-2)][d_inp((rb)-1)][d_inp((rb))]
#define d_il12_energy(lb,rb) d_intloop21[d_inp(lb)][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((rb)-3)][d_inp((rb)-2)][d_inp((rb)-1)][d_inp(rb)]
#define d_il21_energy(lb,rb) d_intloop21[d_inp((rb)-2)][d_inp((rb)-1)][d_inp(rb)][d_inp(lb)][d_inp((lb)+1)][d_inp((lb)+2)][d_inp((lb)+3)]
#define d_int22_energy(a,b,c,d,e,f,g,h) d_intloop22[d_inp(a)][d_inp(b)][d_inp(c)][d_inp(d)][d_inp(e)][d_inp(f)][d_inp(g)][d_inp(h)]
#define d_il22_energy(lb,rb) d_int22_energy(lb,((lb)+1),((lb)+2),((lb)+3),((rb)-3),((rb)-2),((rb)-1),rb)
#define d_il_asym(SL,SR) min(300,((abs((SL)-(SR)))*50))

__device__ int d_hl_energy(int i, int j, char *d_z){
  int size;
  int entropy;
  int tetra_bonus, stack_mismatch;
  int termaupen;

  size           = j-i-1;
  entropy        = d_hl_ent(size);
  stack_mismatch = d_hl_stack(i,j);
  tetra_bonus    = d_hl_tetra[d_inp(i)][d_inp(i+1)][d_inp(i+2)][d_inp(i+3)][d_inp(i+4)][d_inp(i+5)];
  termaupen      = d_termaupenalty(i,j);

  if (size==3) return(entropy + termaupen);
  if (size==4) return(entropy + stack_mismatch + tetra_bonus);
  return(entropy + stack_mismatch);
  //printf("hairpin loop < 3 found. Please use production\n");
  //printf("  hl <<< lbase -~~ (region `with` minsize 3)  ~~- lbase\n");
  //printf("in your grammar.\n");
  //exit(1);
}

__device__ int d_bl_energy(int bl, int i, int j, int br, char *d_z){
  int stacking, size, entropy;

  // stacking    = d_stack_dg[d_inp(bl)][d_inp(j+1)][d_inp(br-1)][d_inp(br)];
  stacking    = d_stack_dg_ac(bl,j+1,br-1,br);
  size        = size_of(i,j);
  entropy     = d_bl_ent(size);

  if     (size==1)  return(stacking + entropy - d_termaupenalty(bl+2,br-1));
  return(entropy + d_termaupenalty(bl,br));
}

__device__ int d_br_energy(int bl, int i, int j, int br, char *d_z){
  int stacking, size, entropy;

  // stacking    = d_stack_dg[d_inp(bl)][d_inp(bl+1)][d_inp(i)][d_inp(br)];
	stacking    = d_stack_dg_ac(bl, bl+1, i, br);
  size        = size_of(i,j);
  entropy     = d_bl_ent(size);

  if (size==1) return(stacking + entropy - d_termaupenalty(bl+1,br-2));
  return(entropy + d_termaupenalty(bl,br));
}

__device__ int d_il_energy(int i, int j, int k, int l, char *d_z)
{
  int sl, sr;
  sl = size_of(i,j);
  sr = size_of(k,l);
  if ((sl > 2) || (sr > 2))
    return((d_il_ent (sl + sr))
         + (d_il_stack (i,j,k,l))
         + (d_il_asym(sl,sr))); else
  if ((sl == 1) && (sr == 1)) return(d_il11_energy(i,l+1)); else
  if ((sl == 1) && (sr == 2)) return(d_il12_energy(i,l+1)); else
  if ((sl == 2) && (sr == 1)) return(d_il21_energy(i,l+1)); else
  if ((sl == 2) && (sr == 2)) return(d_il22_energy(i,l+1)); else
  return 65000;
}
