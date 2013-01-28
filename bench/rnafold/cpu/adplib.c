#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <errno.h>

#include "config.h"
#include "options.h"
#include "adplib.h"


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
        mem->address = mrealloc(mem->address, sizeof (char *) * mem->currentBlock);
        mem->numberOfBlocks = mem->currentBlock;
        mem->address[mem->currentBlock - 1] = mmalloc(mem->blockSize);
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

/* A 	Adenine */
/* C 	Cytosine */
/* G 	Guanine */
/* T (or U) 	Thymine (or Uracil) */
/* R 	A or G */
/* Y 	C or T */
/* S 	G or C */
/* W 	A or T */
/* K 	G or T */
/* M 	A or C */
/* B 	C or G or T */
/* D 	A or G or T */
/* H 	A or C or T */
/* V 	A or C or G */
/* N 	any base */
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
      tinput = realloc(tinput, sizeof (char) * (tinput_alloc * 2));
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
  int pos, rpos;
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
  pos=0; rpos=0;
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
  struct dbcol_result *dbcol;
  char *dbString_org, *shapeString_org;
  char colors;

  itr = format_string_struct;
  dbString_org = dbString;
  shapeString_org = shapeString;
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
