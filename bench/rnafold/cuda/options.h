#ifndef options_h
#define options_h

typedef struct {

  int  	number_of_blocks;  // Set number of blocks (-b)
  int  	threads_per_block; // Set number of threads per blocks (-T)
  float	traceback_diff;    // Set energy range (kcal/mol) (-e)
  int  	traceback_percent; // Set energy range (%%) (-c)
  int  	maxloop;           // Set maximal loop length (-M)
  char 	window_mode;       // Set window size (-w)
  int  	window_size;       // Set window size (-w)
  int  	window_step;       // Set window position increment (-W)
  char 	window_best;       // Show best results in window mode (-B)
  char 	split_output_mode; // Specify output width for structures (-S)
  int  	split_output_size; // Specify output width for structures (-S)
  char 	*inputfile;        // Read input from file (-f)
  char 	colored_output;    // Colored output (-z)


  int window_pos;            // current window position
  
  int number_of_graphics;    // PS output 
  char graphics_includeinfo; // include info
  char graphics_highlight;   // highlight upper case characters
  
  int output_mode;           // output mode (-o)
  char *format_string;       // format string
  
  char interactive;          // interactive mode active
  char terminate;            // terminate program
} toptions;

#endif
