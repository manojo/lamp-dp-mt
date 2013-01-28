/* =========================================================================

   RNAfold 1.0




========================================================================= */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "config.h"
#include "options.h"
#include "adplib.h"
#include "RNAfold.h"


/* ======================================================================
   Reset mode
   ====================================================================== */

static void reset_mode(toptions *opt) {
  opt->window_best    = 1; // Show best results in window mode (-B)
  opt->colored_output = 0; // Colored output (-z)
}


/* ======================================================================
   Init default values
   ====================================================================== */

static void init_defaults(toptions *opt) {
  opt->traceback_diff    = 0;    // Set energy range (kcal/mol) (-e)
  opt->traceback_percent = 10;   // Set energy range (%%) (-c)
  opt->maxloop           = 30;   // Set maximal loop length (-M)
  opt->window_mode       = 0;    // Set window size (-w)
  opt->window_size       = 0;    // Set window size (-w)
  opt->window_step       = 1;    // Set window position increment (-W)
  opt->window_best       = 0;    // Show best results in window mode (-B)
  opt->split_output_mode = 0;    // Specify output width for structures (-S)
  opt->split_output_size = 0;    // Specify output width for structures (-S)
  opt->energy_only       = 0;    // Only compute energy, no traceback  (-O)
  if (opt->inputfile) free(opt->inputfile);
  opt->inputfile         = NULL; // Read input from file (-f)
  opt->colored_output    = 0;    // Colored output (-z)
  opt->terminate            = 0;
  opt->interactive          = 0;
  /* PS output */
  opt->number_of_graphics   = 0;
  opt->graphics_includeinfo = 0;
  opt->graphics_highlight   = 0;
  /* output mode */
  opt->output_mode          = 0;
  opt->format_string        = NULL;
}



/* ======================================================================
   Process arguments
   ====================================================================== */

static void process_args(toptions *opt, char interactive, int argc, char **argv) {
  int   c;
  char  manopt, manoptmode;

  opterr = 0; optind = 1;

  pcolor(opt->colored_output,COLOR_BLUE);
  while ((c = getopt (argc, argv, "hH:ve:c:M:w:W:BS:f:z:O")) != -1) {
    switch (c) {

      // Display this information (-h)
      case 'h':
        if (interactive) {
          printf("Interactive mode:\nEnter sequence directly or use the following commands to change settings:\n");
        }
        else {

        printf("Options:\n");
        }
        printf("  -h           	Display this information\n");
        printf("  -H <option>  	Display detailed information on <option>\n");
        printf("  -v           	Show version\n");
        printf("  -e <value>   	Set energy range (kcal/mol)\n");
        printf("  -c <value>   	Set energy range (%%)\n");
        printf("  -M <value>   	Set maximal loop length\n");
        printf("  -w <value>   	Set window size\n");
        printf("  -W <value>   	Set window position increment\n");
        printf("  -B           	Show best results in window mode\n");
        printf("  -O           	Only compute energy, no traceback\n");
        printf("  -S <value>   	Specify output width for structures\n");
        printf("  -f <filename>	Read input from file\n");
        printf("  -z           	Colored output\n");
        if (opt->interactive) {
        printf("Additional interactive mode commands:\n");
        printf("  :s           	Show current configuration\n");
        printf("  :d           	Reset configuration\n");
        printf("  :e <string>  	Execute system command\n");
        printf("  :q           	Quit\n");
        }
        opt->terminate = 1;
        break;
      // Display detailed information on <option> (-H)
      case 'H':
        if      (optarg[0]=='-') { manoptmode = '-'; manopt = optarg[1]; }
        else if (optarg[0]==':') { manoptmode = ':'; manopt = optarg[1]; }
        else                     { manoptmode = '-'; manopt = optarg[0]; }
        if (!interactive) printf("\n");
        #include "RNAfold-man.c"
        if (!interactive) printf("\n");
        opt->terminate = 1;
        break;
      // Show version (-v)
      case 'v':
        printf("%s (%s)\n",PACKAGE_STRING,RELEASE_DATE);
        printf("\n");
        opt->terminate = 1;
        break;
      // Set energy range (kcal/mol) (-e)
      case 'e':
        sscanf(optarg,"%f",&(opt->traceback_diff));
        opt->traceback_diff = max(0, opt->traceback_diff);
        if (interactive) printf("Energy range set to %.2f kcal/mol.\n", opt->traceback_diff);

        opt->traceback_percent = 0;
        break;
      // Set energy range (%%) (-c)
      case 'c':
        sscanf(optarg,"%d",&(opt->traceback_percent));
        opt->traceback_percent = max(0, opt->traceback_percent);
        if (interactive) printf("Energy range set to %d%% of mfe.\n", opt->traceback_percent);

        opt->traceback_diff = 0;
        break;
      // Set maximal loop length (-M)
      case 'M':
        sscanf(optarg,"%d",&(opt->maxloop));
        opt->maxloop = max(0, opt->maxloop);
        if (interactive) printf("Set maximal loop length to %d.\n", opt->maxloop);
        break;
      // Set window size (-w)
      case 'w':
        if ((interactive) && (optarg[0] == '-')) {
          printf("Window mode disabled.\n");
          opt->window_mode = 0;
        }
        if (optarg[0] != '-') {
          opt->window_mode = 1;
          sscanf(optarg,"%d",&(opt->window_size));
          opt->window_size = max(1, opt->window_size);
          if (interactive) printf("Set window size to %d. Type -w - to disable.\n", opt->window_size);
        }
        break;
      // Set window position increment (-W)
      case 'W':
        sscanf(optarg,"%d",&(opt->window_step));
        opt->window_step = max(1, opt->window_step);
        if (interactive) printf("Set window position increment to %d.\n", opt->window_step);
        break;
      // Show best results in window mode (-B)
      case 'B':
        if (interactive) {
          printf("Show best results in window mode");
          opt->window_best = 1 - opt->window_best;
          if (opt->window_best) printf (" = ON. Type -B again to switch off.\n");
          else printf (" = OFF. Type -B again to switch on.\n");
        }
        else opt->window_best = 1;
        break;
      // Only compute energy, no traceback  (-O)
      case 'O':
        opt->energy_only = 1;
        break;
      // Specify output width for structures (-S)
      case 'S':
        if ((interactive) && (optarg[0] == '-')) {
          printf("Output splitting disabled.\n");
          opt->split_output_mode = 0;
        }
        if (optarg[0] != '-') {
          opt->split_output_mode = 1;
          sscanf(optarg,"%d",&(opt->split_output_size));
          opt->split_output_size = max(1, opt->split_output_size);
          if (interactive) printf("Set output size to %d. Type -S - to disable.\n", opt->split_output_size);
        }
        break;
      // Read input from file (-f)
      case 'f':
        if (opt->inputfile) free(opt->inputfile);
        opt->inputfile = mkstr(optarg);
        break;
      // Colored output (-z)
      case 'z':
        if (interactive) {
          printf("Colored output");
          opt->colored_output = 1 - opt->colored_output;
          if (opt->colored_output) printf (" = ON. Type -z again to switch off.\n");
          else printf (" = OFF. Type -z again to switch on.\n");
        }
        else opt->colored_output = 1;

             if (opt->interactive && !opt->colored_output) printf(COLOR_DEFAULT);

        break;


      case '?':
        if (interactive) printf("Unknown option '-%c'. Type -h for more information.\n", optopt);
        else {
          fprintf (stderr, "%s: unknown option `-%c'.\nTry '%s -h' for more information.\n", argv[0], optopt, argv[0]);
          exit(1);
        }
        break;
      default:
        abort ();
      }
  }
  pcolor(opt->colored_output,COLOR_DEFAULT);
}

/* ======================================================================
   Print settings
   ====================================================================== */

static void print_settings(toptions *opt) {
  printf("Current settings\n-----------------\n");
  printf("Energy range                           %.2f kcal/mol  (-e)\n", opt->traceback_diff);
  printf("Energy range                           %d%% of mfe  (-c)\n", opt->traceback_percent);
  printf("Maximal loop length:                   %d  (-M)\n", opt->maxloop);
  if (opt->window_mode)
  printf("Window size:                           %d  (-w)\n", opt->window_size);
  else
  printf("Window size:                           %s-  (-w)\n","");
  printf("Window position increment:             %d  (-W)\n", opt->window_step);
  printf("Show best result in window mode        %s  (-B)\n", opt->window_best ? "ON" : "OFF" );
  if (opt->split_output_mode)
  printf("Output width for structures:           %d  (-S)\n", opt->split_output_size);
  else
  printf("Output width for structures:           %s-  (-S)\n","");
  printf("Colored output                         %s  (-z)\n", opt->colored_output ? "ON" : "OFF" );
}


/* ======================================================================
   Main interface
   ====================================================================== */

int main (int argc, char **argv) {
  toptions   *opt;
  tsequence  *seq;
  treadseq   *rs        = NULL;
  ttokenizer *tokenizer = NULL;
  char       *command;



  opt = (toptions *) calloc(1,sizeof(toptions));

  init_defaults(opt);
  process_args(opt, 0, argc, argv);

  if (!opt->terminate) {
    if (optind < argc)               rs = readseq_open(READSEQ_STRING, argv[optind]);
    else if (opt->inputfile)         rs = readseq_open(READSEQ_FILE,   opt->inputfile);
    else if (!isatty(fileno(stdin))) rs = readseq_open(READSEQ_STDIN,  NULL);
    else {
      printf("Interactive mode. Try `./RNAfold -h` for more information.\n", argv[0]);
      rl_init();
      opt->interactive = 1;
      opt->colored_output = 1 - opt->colored_output;
      tokenizer = tokenizer_new();
      rs = readseq_open(READSEQ_STRING, "");
    }

    while (1) {
      if (opt->interactive) {
        if (opt->colored_output)
          printf("%s\nInput sequence (upper or lower case); :q to quit, -h for help.\n....,....1....,....2....,....3....,....4....,....5....,....6....,....7....,....8\n%s",COLOR_RED,COLOR_DEFAULT);
        else
	  printf("\nInput sequence (upper or lower case); :q to quit, -h for help.\n....,....1....,....2....,....3....,....4....,....5....,....6....,....7....,....8\n");
        command = rl_gets();

        if (!command || (command[0] == '@') || ((command[0] == ':') && (command[1] == 'q'))) {
          pcolor(opt->colored_output,COLOR_BLUE);
          printf("Leaving RNAfold.");
          pcolor(opt->colored_output,COLOR_DEFAULT);
          printf("\n");
          exit(0);
        }
        else if (command[0] == ':') {
          pcolor(opt->colored_output,COLOR_BLUE);
          if (command[1] == 's') print_settings(opt);
          if (command[1] == 'd') {
            init_defaults(opt);
            opt->colored_output = 1;
            opt->interactive = 1;
            printf("Activated default configuration.\n");
            pcolor(opt->colored_output,COLOR_DEFAULT);
          }
          if (command[1] == 'e') {
            system(command + 2);
          }
          if (command[1] == 'r') {
            system("make update");
            system("./RNAfold");
            exit(0);
          }
        }
        else if (command[0] == '-') {
          tokenizer_exec(tokenizer, argv[0], command);
          process_args(opt, 1, tokenizer->count, tokenizer->token);
          if (opt->inputfile) {
            rs = readseq_free(rs);
            rs = readseq_open(READSEQ_FILE, opt->inputfile);
          }
          free(opt->inputfile);
          opt->inputfile = NULL;
        }
        else {
          rs = readseq_free(rs);
          rs = readseq_open(READSEQ_STRING, command);
        }
      }

      while (1) {
        seq = readseq_next_fasta(rs);
        if (!(seq->success)) break;
        if (1) {
          main_rnafold_mfe(opt, seq);
        }

        sequence_free(seq);
      }

      if (!opt->interactive) break;
    }
  }
  exit(0);
}
