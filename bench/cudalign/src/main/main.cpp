#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <errno.h>
#include <sys/wait.h>

#include "../common/cudalign.hpp"
#include "../stage1/sw_stage1.h"
#include "../stage2/sw_stage2.h"
#include "../stage3/sw_stage3.h"
#include "../stage4/sw_stage4.h"
#include "../stage5/sw_stage5.h"
#include "../stage6/sw_stage6.h"

/**
 * CUDAlign Version to be shown in usage help.
 */
#define CUDALIGN_VERSION    "2.0.0"

/**
 * Default amount of disk space used for flushing special lines.
 */
#define DEFAULT_FLUSH_LIMIT (4*1024*1024*1024LL) // 4G
#define DEFAULT_FLUSH_LIMIT_STRING "4G" // SHOW USAGE

/**
 * Constant used to represent that no special lines will be flushed.
 */
#define NO_FLUSH (-1)

/**
 * The default working directory for temprary data.
 */
#define DEFAULT_WORK_DIRECTORY "./work.tmp"

/**
 *
 */
#define DEFAULT_PHASE_3_SIZE 16
#define DEFAULT_MPS_STRING "16" // SHOW USAGE

/**
 *
 */
#define DETECT_FASTEST_GPU (-1)


/**
 * Optarg: command line parameters.
 * Characters are short options. Hexadecimals are long options.
 */
// General Options
#define ARG_HELP                'h'
#define ARG_WORK_DIR            'd'
#define ARG_CLEAR               'c'
#define ARG_VERBOSE             'v'
#define ARG_GPU                 'g'
#define ARG_LIST_GPUS           0x8001
#define ARG_MULTIPLE_GPUS       0x8002
#define ARG_BLOCKS              'b'

// Input Options
#define ARG_TRIM                't'
#define ARG_SPLIT               's'
#define ARG_CLEAR_N             0x9002
#define ARG_REVERSE             0x9003
#define ARG_COMPLEMENT          0x9004
#define ARG_REVERSE_COMPLEMENT  0x9005

// Execution Options
#define ARG_STAGE_1             '1'
#define ARG_NO_FLUSH            'n'
#define ARG_DISK_SIZE           0x1006
#define ARG_FLUSH_COLUMN        0x1007
#define ARG_LOAD_COLUMN         0x1008
#define ARG_STAGE_2             '2'
#define ARG_STAGE_3             '3'
#define ARG_MAXIMUM_PARTITION   0x3009
#define ARG_NOT_ORTHOGONAL      0x3010
#define ARG_STAGE_4             '4'
#define ARG_STAGE_5             '5'
#define ARG_STAGE_6             '6'
#define ARG_OUTPUT_FORMAT       0x6011
#define ARG_LIST_FORMATS        0x6012


/**
 * Header of CUDAlign Execution.
 */
#define CUDALIGN_HEADER "\
                                                                               \n\
\033[1mCUDAlign "CUDALIGN_VERSION"  -  GPU tool for huge sequences alignment (Smith-Waterman)\033[0m \n\
Developed by Edans Sandes (2010) - University of Brasilia/UnB - Brazil         \n\
\n"



/**
 * Usage string to be shown in help.
 */
#define USAGE "\
Usage: cudalign [OPTIONS] [FASTA FILE #1] [FASTA FILE #2]                      \n\
\n\
FASTA FILES:            Supply two sequences in fasta format files.            \n\
\n\
\n\
\033[1mGeneral Options:\033[0m\n\
\n\
-h, --help              Shows this help.\n\
-d, --work-dir=DIR      Directory used to store files exchanged between stages.\n\
                           Default: "DEFAULT_WORK_DIRECTORY" \n\
-c, --clear             Clears the work directory before any computation. This \n\
                           prevents the continuation of previously interrupted \n\
                           execution.\n\
-v, --verbose=LEVEL     Shows informative output during computation.           \n\
                           0: Silently;\n\
                           1: Only shows error messages;\n\
                           2: (Default) Shows progress and statistics;    \n\
                           3: Gives full output data.\n\
-g, --gpu=GPU           Selects the index of GPU used for the computation. If  \n\
                           GPU is not informed, the fastest GPU is selected.   \n\
                           A list of available GPUs can be obtained with the   \n\
                           --list-gpus parameter. \n\
--list-gpus             Lists all available GPUs. \n\
--multiple-gpus         Uses all available GPUs. \n\
--blocks=B              Run B CUDA Blocks\n\
\n\
\n\
\033[1mInput Options:\033[0m\n\
\n\
-t, --trim=I0,I1,J0,J1  Trims sequence #1 from position I0 to I1 (inclusive).  \n\
                           and sequence #2 from position J0 to J1 (inclusive). \n\
                           Zero represents either first and last positions.    \n\
                           This parameter is ignored if used together with the \n\
                           --split parameter. \n\
-s, --split=STEP/COUNT  Splits sequence #2 in COUNT equal segments and         \n\
                           processes split #STEP (1..COUNT). This parameter may\n\
                           be used when there is not available video memory to \n\
                           compare the full sequences in only one step.        \n\
--clear-n               Remove all 'N' characters on both fasta files.\n\
--reverse=[1|2|both]    Reverse strands of sequence 1, 2 or both.              \n\
--complement=[1|2|both] Generate complement (AT,CG) for sequence 1, 2 or both. \n\
--reverse-complement=[1|2|both] \n\
                        Generate reverse-complement (opposite strand) for      \n\
                           sequence 1, 2 or both. This parameter joins the     \n\
                           --reverse and --complement parameters. \n\
\n\
\033[1mStage Options:\033[0m\n\
\n\
\033[1mStage #1 Options:\033[0m\n\
-1, --stage-1           Executes only the stage #1 of algorithm, i.e., returns \n\
                           the best score and its coordinates. Special rows    \n\
                           are stored in disk to allow the execution of the    \n\
                           subsequent stages.\n\
-n, --no-flush          Do not write special rows to disk. Using this option   \n\
                           in stage #1 will prevent the execution of subsequent\n\
                           phases.\n\
--disk-space=SIZE       Limits the disk size available to the special rows.    \n\
                           The SIZE parameter may contain suffix M (e.g., 500M)\n\
                           or G (e.g., 10G). This option is ignored if used\n\
                           together with the --no-flush parameter. \n\
                           Default value: "DEFAULT_FLUSH_LIMIT_STRING".\n\
--flush-column=URL      Store the last column cells in some destination. The   \n\
                           URL is given in some of these formats: \n\
                           file://PATH_TO_FILE \n\
                           socket://0.0.0.0:LISTENING_PORT \n\
--load-column=URL       Loads the first column cells from some destination. The\n\
                           URL is given in some of these formats: \n\
                           file://PATH_TO_FILE \n\
                           socket://HOSTNAME:PORT \n\
\n\
\033[1mStage #2 Options:\033[0m\n\
-2, --stage-2           Executes only the stage #2 of algorithm, i.e., returns \n\
                           a list of crosspoints inside the optimal alignment. \n\
                           Special columns are stored in disk to allow the     \n\
                           execution of the subsequent stages. The disk size   \n\
                           available to store the special columns may be       \n\
                           configured using the --disk-space parameter. \n\
\n\
\033[1mStage #3 Options:\033[0m\n\
-3, --stage-3           Executes only the stage #3 of algorithm, i.e., returns \n\
                           a bigger list of crosspoints inside the optimal     \n\
                           alignment.\n\
\n\
\033[1mStage #4 Options:\033[0m\n\
-4, --stage-4           Executes only the stage #4 of algorithm, i.e., given a \n\
                           list of coordinates of the optimal alignment,       \n\
                           increases the number of crosspoint using            \n\
                           Myers and Miller's algorithm, until all the         \n\
                           partitions are smaller than the maximum partition   \n\
                           size.\n\
--maximum-partition=SIZE \n\
                        Defines the maximum partition size allowed as output   \n\
                           of the stage #4. This parameter limits the size of  \n\
                           partitions processed in stage #5. \n\
                           Default Value: "DEFAULT_MPS_STRING" \n\
--not-orthogonal        Does not use the orthogonal execution otimization.     \n\
\n\
\033[1mStage #5 Options:\033[0m\n\
-5, --stage-5           Executes only the stage #5 of algorithm, i.e., given   \n\
                           a list of coordinates of the optimal alignment,     \n\
                           returns the full alignment (as binary output).      \n\
\n\
\033[1mStage #6 Options:\033[0m\n\
-6, --stage-6           Executes only the stage #6 of algorithm, i.e., given   \n\
                           an alignment in binary format, returns the full     \n\
                           alignment in the format defined in with the         \n\
                           --output-format argument.\n\
--output-format=FORMAT  Selects the output format of the full alignment        \n\
                           in stage #6. Possibile formats may be listed with   \n\
                           the --list-formats parameter. \n\
--list-formats          Lists all the possible output formats for stage #6.    \n\
\n\
\n\
"


/**
 * Shows the usage of the command line tool.
 */
void show_usage() {
    printf ( USAGE );
}


int parse_sequence_flags ( char* optarg, bool* flag1, bool* flag2 ) {
    if ( strcasecmp ( optarg, "none" ) ==0 ) {
        *flag1 = false;
        *flag2 = false;
    } else if ( strcasecmp ( optarg, "1" ) ==0 ) {
        *flag1 = true;
        *flag2 = false;
    } else if ( strcasecmp ( optarg, "2" ) ==0 ) {
        *flag1 = false;
        *flag2 = true;
    } else if ( strcasecmp ( optarg, "both" ) ==0 ) {
        *flag1 = true;
        *flag2 = true;
    } else {
        return 0;
    }
    return 1;
}


/**
 * Show possible output formats used in stage #6->
 */
void print_output_formats ( FILE* file=stdout ) {
    fprintf ( file, "Output Formats\n" );
    fprintf ( file, "%10s: %s\n", "NAME", "DESCRIPTION" );
    fprintf ( file, "---------------------------\n" );
    for ( output_format_t* format = stage6_formats; format->name; format++ ) {
        fprintf ( file, "%10s: %s\n", format->name, format->description );
    }
}

/**
 * Load both sequences to Job structure.
 */
void load_sequences ( Job* _job, int clear_n,
                      int reverse_seq1, int reverse_seq2,
                      int complement_seq1, int complement_seq2,
                      char** fasta_file ) {

    /* Select Flags */
    int flags_1 = 0;
    int flags_2 = 0;
    if ( clear_n ) flags_1 = ( flags_1 | FLAG_CLEAR_N );
    if ( clear_n ) flags_2 = ( flags_2 | FLAG_CLEAR_N );
    if ( reverse_seq1 ) flags_1 = ( flags_1 | FLAG_REVERSE );
    if ( reverse_seq2 ) flags_2 = ( flags_2 | FLAG_REVERSE );
    if ( complement_seq1 ) flags_1 = ( flags_1 | FLAG_COMPLEMENT );
    if ( complement_seq2 ) flags_2 = ( flags_2 | FLAG_COMPLEMENT );

    /* Read both files with selected flags */
    _job->seq[0].readFile ( fasta_file[0], flags_1 );
    _job->seq[1].readFile ( fasta_file[1], flags_2 );
}



/**
 * Program entry point.
 */
int main ( int argc, char** argv ) {
    printf ( CUDALIGN_HEADER );
    int c;
    char *arg_error = NULL;
    char *fasta_file[2];
    Job* _job = new Job();

    /* Default Values */
    int verbosity = 2;
    bool clear_work_directory = false;
    bool multiple_gpus = false;
    _job->flush_limit = DEFAULT_FLUSH_LIMIT;
    _job->setWorkPath ( DEFAULT_WORK_DIRECTORY );
    _job->stage4_maximum_partition_size = DEFAULT_PHASE_3_SIZE;
    _job->stage4_orthogonal_execution = true;
    _job->stage6_output_format = 0;
    _job->gpu = DETECT_FASTEST_GPU;
    _job->blocks = 0;
    _job->flush_column_url = "";
    _job->load_column_url = "";
    int phase = 0;
    int trim_i0 = 0;
    int trim_i1 = 0;
    int trim_j0 = 0;
    int trim_j1 = 0;
    int split_step = 0;
    int split_count = 0;
    bool clear_n = false;
    bool reverse_seq1 = false;
    bool reverse_seq2 = false;
    bool complement_seq1 = false;
    bool complement_seq2 = false;

    while ( 1 ) {
        static struct option long_options[] = {
            // General Options
            {"help",        no_argument,            0, ARG_HELP},
            {"work-dir",    required_argument,      0, ARG_WORK_DIR},
            {"clear",       no_argument,            0, ARG_CLEAR},
            {"verbose",     required_argument,      0, ARG_VERBOSE},
            {"gpu",         required_argument,      0, ARG_GPU},
            {"list-gpus",   no_argument,            0, ARG_LIST_GPUS},
            {"multiple-gpus", no_argument,          0, ARG_MULTIPLE_GPUS},
            {"blocks",      required_argument,      0, ARG_BLOCKS},

            // Input Options
            {"trim",        required_argument,      0, ARG_TRIM},
            {"split",       required_argument,      0, ARG_SPLIT},
            {"clear-n",     no_argument,            0, ARG_CLEAR_N},
            {"reverse",     required_argument,      0, ARG_REVERSE},
            {"complement",  required_argument,      0, ARG_COMPLEMENT},
            {"reverse-complement", required_argument, 0, ARG_REVERSE_COMPLEMENT},

            // Execution Options
            {"stage-1",     no_argument,            0, ARG_STAGE_1},
            {"no-flush",    no_argument,            0, ARG_NO_FLUSH},
            {"disk-size",   required_argument,      0, ARG_DISK_SIZE},
            {"flush-column", required_argument,     0, ARG_FLUSH_COLUMN},
            {"load-column", required_argument,      0, ARG_LOAD_COLUMN},

            {"stage-2",     no_argument,            0, ARG_STAGE_2},

            {"stage-3",     no_argument,            0, ARG_STAGE_3},

            {"stage-4",     optional_argument,      0, ARG_STAGE_4},
            {"maximum-partition", required_argument, 0, ARG_MAXIMUM_PARTITION},
            {"not-orthogonal", no_argument,         0, ARG_NOT_ORTHOGONAL},

            {"stage-5",     no_argument,            0, ARG_STAGE_5},

            {"stage-6",     no_argument,            0, ARG_STAGE_6},
            {"output-format", required_argument,    0, ARG_OUTPUT_FORMAT},
            {"list-formats", no_argument,           0, ARG_LIST_FORMATS},
            {0, 0, 0, 0}
        };
        /* getopt_long stores the option index here. */
        int option_index = 0;

        c = getopt_long ( argc, argv, "hd:cv:g:b:t:s:n123456",
                          long_options, &option_index );

        /* Detect the end of the options. */
        if ( c == -1 )
            break;

        //printf("c: %c\n", c);
        switch ( c ) {

        case ARG_HELP:
            show_usage();
            exit ( 2 );
            break;
        case ARG_WORK_DIR:
            _job->setWorkPath ( optarg );
            break;
        case ARG_CLEAR:
            clear_work_directory = true;
            break;
        case ARG_VERBOSE:
            verbosity = atoi ( optarg );
            if ( verbosity < 0 || verbosity > 2 ) {
                arg_error = "Wrong Verbosity";
            }
            break;
        case ARG_GPU:
            if ( optarg != NULL )  {
                sscanf ( optarg, "%d", &_job->gpu );
            }
            break;
        case ARG_LIST_GPUS:
            printGPUDevices();
            exit ( 1 );
            break;
        case ARG_MULTIPLE_GPUS:
            multiple_gpus = 1;
            break;
        case ARG_BLOCKS:
            if ( optarg != NULL )  {
                sscanf ( optarg, "%d", &_job->blocks );
                if ( _job->blocks > BLOCKS_COUNT ) {
                    arg_error = "Blocks count cannot be greater than BLOCKS_COUNT";//TODO BLOCKS COUNT STRING
                }
            }
            break;
        case ARG_TRIM:
            if ( optarg != NULL )  {
                sscanf ( optarg, "%d,%d,%d,%d",
                         &trim_i0, &trim_i1, &trim_j0, &trim_j1 );
            }
            break;
        case ARG_SPLIT:
            if ( optarg != NULL )  {
                int step;
                int count;
                sscanf ( optarg, "%d/%d", &split_step, &split_count );
                if ( split_step > split_count || split_step <= 0 ) {
                    arg_error = "Split STEP must lie in 1..COUNT range";
                }
            } else {
                arg_error = "Inform split parameters: STEP/COUNT";
            }
            break;
        case ARG_CLEAR_N:
            clear_n = true;
            break;
        case ARG_REVERSE:
            if ( optarg != NULL )  {
                if ( !parse_sequence_flags ( optarg, &reverse_seq1, &reverse_seq2 ) ) {
                    arg_error = "Wrong reverse argument. Choose 'none', '1', '2' or 'both'.";
                }
            } else {
                arg_error = "Inform reverse argument. Choose 'none', '1', '2' or 'both'.";
            }
            break;
        case ARG_COMPLEMENT:
            if ( optarg != NULL )  {
                if ( !parse_sequence_flags ( optarg, &complement_seq1, &complement_seq2 ) ) {
                    arg_error = "Wrong complement argument. Choose 'none', '1', '2' or 'both'.";
                }
            } else {
                arg_error = "Inform complement argument. Choose 'none', '1', '2' or 'both'.";
            }
            break;
        case ARG_REVERSE_COMPLEMENT:
            if ( optarg != NULL )  {
                if ( !parse_sequence_flags ( optarg, &complement_seq1, &complement_seq2 ) ) {
                    arg_error = "Wrong reverse-complement argument. Choose 'none', '1', '2' or 'both'.";
                } else {
                    reverse_seq1 = complement_seq1;
                    reverse_seq2 = complement_seq2;
                }
            } else {
                arg_error = "Inform reverse-complement argument. Choose 'none', '1', '2' or 'both'.";
            }
            break;
        case ARG_STAGE_1:
            phase = STAGE_1;
            break;
        case ARG_NO_FLUSH:
            _job->flush_limit = NO_FLUSH;
            break;
        case ARG_DISK_SIZE:
            if ( _job->flush_limit != NO_FLUSH ) {
                char str[40];
                strcpy ( str, optarg );
                char prefix = str[strlen ( str )-1];
                str[strlen ( str )-1] = 0;
                switch ( prefix ) {
                case 'M':
                    _job->flush_limit = ( long long ) ( atof ( str ) *1024*1024LL );
                    break;
                case 'G':
                    _job->flush_limit = ( long long ) ( atof ( str ) *1024*1024*1024LL );
                    break;
                default:
                    arg_error = "Wrong size suffix (use 'M' or 'G')";
                }
                if ( _job->flush_limit == 0 ) {
                    arg_error = "Wrong size limit";
                }
            }
            break;
        case ARG_FLUSH_COLUMN:
            if ( optarg != NULL )  {
                _job->flush_column_url = optarg;
            } else {
                arg_error = "Inform URL";
            }
            break;
        case ARG_LOAD_COLUMN:
            if ( optarg != NULL )  {
                _job->load_column_url = optarg;
            } else {
                arg_error = "Inform URL";
            }
            break;

        case ARG_STAGE_2:
            phase = STAGE_2;
            break;

        case ARG_STAGE_3:
            phase = STAGE_3;
            break;
        case ARG_MAXIMUM_PARTITION:
            if ( optarg != NULL )  {
                sscanf ( optarg, "%d", &_job->stage4_maximum_partition_size );
            } else {
                arg_error = "No maximum partition size informed.";
            }
            break;
        case ARG_NOT_ORTHOGONAL:
            _job->stage4_orthogonal_execution = false;
            break;

        case ARG_STAGE_4:
            phase = STAGE_4;
            break;

        case ARG_STAGE_5:
            phase = STAGE_5;
            break;

        case ARG_STAGE_6:
            phase = STAGE_6;
            break;
        case ARG_LIST_FORMATS:
            print_output_formats();
            exit ( 1 );
            break;
        case ARG_OUTPUT_FORMAT:
            if ( optarg != NULL )  {
                _job->stage6_output_format = -1;
                for ( int id=0; stage6_formats[id].name != NULL; id++ ) {
                    if ( strcasecmp ( optarg, stage6_formats[id].name ) ==0 ) {
                        _job->stage6_output_format = id;
                    }
                }
                if ( _job->stage6_output_format == -1 ) {
                    arg_error = "Wrong output format.";
                }
            } else {
                arg_error = "No output format informed.";
            }
            break;

        case '?':
            // invalid option detected
            fprintf ( stderr, "See `cudalign --help' for more information.\n" );
            exit ( 2 );
            break;

        default:
            abort ();
        }
    }

    /* Mandatory file names */
    if ( argc - optind == 2 ) {
        fasta_file[0] = argv[optind++];
        fasta_file[1] = argv[optind++];
    } else {
        arg_error = "Supply two fasta files.";
    }

    /* Show message if some error has occurred. */
    if ( arg_error ) {
        printf ( "%s\n", arg_error );
        printf ( "See `cudalign --help' for more information.\n" );
        exit ( 1 );
    }


    /* Loads both sequences */
    load_sequences ( _job, clear_n,
                     reverse_seq1, reverse_seq2,
                     complement_seq1, complement_seq2,
                     fasta_file );

    /* Trim sequences. The 0 values means first and last characters. */
    _job->seq[0].trim ( trim_i0, trim_i1 );
    _job->seq[1].trim ( trim_j0, trim_j1 );


    printf ( "Alignment sequences:\n" );
    printf ( ">%s (%d)\n", _job->seq[0].name.c_str(), _job->seq[0].getLen() );
    printf ( ">%s (%d)\n", _job->seq[1].name.c_str(), _job->seq[1].getLen() );


    /* Job initialization */

    if ( !_job->initialize() ) { // TODO throw exception
        exit ( 1 );
    }

    /* Job Execution */

    if ( phase == 0 ) {
        stage1 ( _job );
        stage2 ( _job );
        stage3 ( _job );
        stage4 ( _job );
        stage5 ( _job );
        stage6 ( _job );
    } else if ( phase == STAGE_1 ) {
        stage1 ( _job );
    } else if ( phase == STAGE_2 ) {
        stage2 ( _job );
    } else if ( phase == STAGE_3 ) {
        stage3 ( _job );
    } else if ( phase == STAGE_4 ) {
        stage4 ( _job );
    } else if ( phase == STAGE_5 ) {
        stage5 ( _job );
    } else if ( phase == STAGE_6 ) {
        stage6 ( _job );
    }

    /* Job finalization */
    /*if (multiple_gpus) {
        wait();
    }*/

    exit ( 0 );
}

