#ifndef __VIENNA_RNA_PACKAGE_UTILS_H__
#define __VIENNA_RNA_PACKAGE_UTILS_H__

/**
 *  \file utils.h
 *  \brief Various utility- and helper-functions used throughout the Vienna RNA package
 */

/**
 *  Output flag of \ref get_input_line():  "An ERROR has occured, maybe EOF"
 */
#define VRNA_INPUT_ERROR                  1U
/**
 *  Output flag of \ref get_input_line():  "the user requested quitting the program"
 */
#define VRNA_INPUT_QUIT                   2U
/**
 *  Output flag of \ref get_input_line():  "something was read"
 */
#define VRNA_INPUT_MISC                   4U

/** Input/Output flag of \ref get_input_line():\n
 *  if used as input option this tells get_input_line() that the data to be read should comply
 *  with the FASTA format
 *
 *  the function will return this flag if a fasta header was read
 */
#define VRNA_INPUT_FASTA_HEADER           8U

/** Input flag for get_input_line():\n
 *  Tell get_input_line() that we assume to read a nucleotide sequence
 *
 */
#define VRNA_INPUT_SEQUENCE               16U

/**
 *  Input switch for \ref get_input_line():
 *  "do not trunkate the line by eliminating white spaces at end of line"
 */
#define VRNA_INPUT_NO_TRUNCATION          256U

/**
 *  Input switch for read_record():  "do fill rest array"
 */
#define VRNA_INPUT_NO_REST                512U

/**
 *  Input switch for read_record():  "never allow data to span more than one line"
 */
#define VRNA_INPUT_NO_SPAN                1024U

/**
 *  Input switch for read_record():  "do not skip empty lines"
 */
#define VRNA_INPUT_NOSKIP_BLANK_LINES     2048U

/**
 *  Output flag for read_record():  "read an empty line"
 */
#define VRNA_INPUT_BLANK_LINE             4096U

/**
 *  Input switch for \ref get_input_line():  "do not skip comment lines"
 */
#define VRNA_INPUT_NOSKIP_COMMENTS        128U

/**
 *  Output flag for read_record():  "read a comment"
 */
#define VRNA_INPUT_COMMENT                8192U

/**
 * Tell a function that an input is assumed to span several lines if used as input-option
 * A function might also be returning this state telling that it has read data from
 * multiple lines.
 *
 * \see extract_record_rest_structure(), read_record()
 *
 */
#define VRNA_OPTION_MULTILINE             32U


/**
 *  Get the minimum of two comparable values
 */
#define MIN2(A, B)      ((A) < (B) ? (A) : (B))
/**
 *  Get the maximum of two comparable values
 */
#define MAX2(A, B)      ((A) > (B) ? (A) : (B))
/**
 *  Get the minimum of three comparable values
 */
#define MIN3(A, B, C)   (MIN2(  (MIN2((A),(B))) ,(C)))
/**
 *  Get the maximum of three comparable values
 */
#define MAX3(A, B, C)   (MAX2(  (MAX2((A),(B))) ,(C)))


/**
 * Stringify a macro after expansion
 */
#define XSTR(s) STR(s)
/**
 * Stringify a macro argument
 */
#define STR(s) #s

#ifndef FILENAME_MAX_LENGTH
/**
 *  \brief Maximum length of filenames that are generated by our programs
 *
 *  This definition should be used throughout the complete ViennaRNA package
 *  wherever a static array holding filenames of output files is declared.
 */
#define FILENAME_MAX_LENGTH   80
/**
 *  \brief Maximum length of id taken from fasta header for filename generation
 *
 *  this has to be smaller than FILENAME_MAX_LENGTH since in most cases,
 *  some suffix will be appended to the ID
 */
#define FILENAME_ID_LENGTH    42
#endif

#define space(S) calloc(1,(S))

/**
 *  \brief Reallocate space safely
 *
 *  \param p    A pointer to the memory region to be reallocated
 *  \param size The size of the memory to be allocated in bytes
 *  \return     A pointer to the newly allocated memory
 */
/*@only@*/ /*@notnull@*/
void  *xrealloc(/*@null@*/ /*@only@*/ /*@out@*/ /*@returned@*/ void *p,
                unsigned size) /*@modifies *p @*/ /*@ensures MaxSet(result) == (size-1) @*/;

/**
 *  \brief Die with an error message
 *
 *  \see warn_user()
 *  \param message The error message to be printed before exiting with 'FAILURE'
 */
/*@exits@*/
void nrerror(const char message[]);

/**
 *  \brief  Get a data record from stdin
 *
 *  This function may be used to obtain complete datasets from stdin. A dataset is always
 *  defined to contain at least a sequence. If data on stdin starts with a fasta header,
 *  i.e. a line like
 *  \verbatim >some header info \endverbatim
 *  then read_record() will assume that the sequence that follows the header may span
 *  over several lines. To disable this behavior and to assign a single line to the argument
 *  'sequence' one can pass VRNA_INPUT_NO_SPAN in the 'options' argument.
 *  If no fasta header is read in the beginning of a data block, a sequence must not span over
 *  multiple lines!\n
 *  Unless the options #VRNA_INPUT_NOSKIP_COMMENTS or #VRNA_INPUT_NOSKIP_BLANK_LINES are passed,
 *  a sequence may be interrupted by lines starting with a comment character or empty lines.\n
 *  A sequence is regarded as completely read if it was either assumed to not span over multiple
 *  lines, a secondary structure or structure constraint follows the sequence on the next line
 *  or a new header marks the beginning of a new sequence...\n
 *  All lines following the sequence (this includes comments) and not initiating a new dataset are
 *  available through the line-array 'rest'. Here one can usually find the structure constraint or
 *  other information belonging to the current dataset. Filling of 'rest' may be prevented by
 *  passing #VRNA_INPUT_NO_REST to the options argument.\n
 *
 *  \note This function will exit any program with an error message if no sequence could be read!
 *
 *  The main purpose of this function is to be able to easily parse blocks of data from stdin
 *  in the header of a loop where all calculations for the appropriate data is done inside the
 *  loop. The loop may be then left on certain return values, e.g.:
 *  \verbatim
char *id, *seq, **rest;
int  i;
while(!(read_record(&id, &seq, &rest, 0) & (VRNA_INPUT_ERROR | VRNA_INPUT_QUIT))){
  if(id) printf("%s\n", id);
  printf("%s\n", seq);
  if(rest)
    for(i=0;rest[i];i++)
      printf("%s\n", rest[i]);
} \endverbatim
 *
 *  In the example above, the while loop will be terminated when read_record() returns either an
 *  error or a user initiated quit request.\n
 *  As long as data is read from stdin, the id is printed if it is available for the current block
 *  of data. The sequence will be printed in any case and if some more lines belong to the current
 *  block of data each line will be printed as well.
 *
 *  \note Do not forget to free the memory occupied by header, sequence and rest!
 *
 *  \param  header    A pointer which will be set such that it points to the header of the record
 *  \param  sequence  A pointer which will be set such that it points to the sequence of the record
 *  \param  rest      A pointer which will be set such that it points to an array of lines which also belong to the record
 *  \return           A flag with information about what the function actually did read
 */
unsigned int read_record( char **header,
                          char **sequence,
                          char  ***rest);

/**
 *  \brief Convert an input sequence to uppercase
 *
 *  \param sequence The sequence to be converted
 */
void  str_uppercase(char *sequence);

/**
 *  \brief Get an index mapper array (indx) for accessing the energy matrices, e.g. in MFE related functions.
 *
 *  Access of a position "(i,j)" is then accomplished by using \verbatim (i,j) ~ indx[j]+i \endverbatim
 *  This function is necessary as most of the two-dimensional energy matrices are actually one-dimensional arrays throughout
 *  the ViennaRNAPackage
 *
 *  Consult the implemented code to find out about the mapping formula ;)
 *
 *  \see get_iindx()
 *  \param length The length of the RNA sequence
 *  \return       The mapper array
 *
 */
int   *get_indx(unsigned int length);

#endif
