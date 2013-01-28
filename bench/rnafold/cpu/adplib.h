#ifndef adplib_h
#define adplib_h

/* abstraction for poor people - after including, undef and redef them
 * if you use tupels */

#define get_result_score(a) a

#define is_suboptimal(a, b, c) abs(a - b) <= c

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

#endif
