s/@C_ADDITIONAL_HEADER@/int maxloop;\
/g
s/@C_INPUT_DECLARATION@//g
s/@OUTPUT_OPTIMAL@/      if (opts->traceback_percent) traceback_diff = abs(result_score * opts->traceback_percent \/ 100);\
      rna_output_optimal(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);/g
s/@OUTPUT_SUBOPT_START@/      rna_output_subopt_start(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);/g
s/@OUTPUT_SUBOPT@/            rna_output_subopt(opts, seq, "mfe", score, result_prettyprint);/g
s/@OUTPUT_SUBOPT_END@/      rna_output_subopt_end(opts, seq, "mfe", result_score, result_score, result_score + traceback_diff);/g
s/@RNALIB_FREE@/rnalib_free();\
/g
s/@MODULENAME@/rnafold_mfe/g
s/@MODULEMAININIT@/traceback_diff = opts->traceback_diff * 100;\
   maxloop = opts->maxloop;\
   rnalib_init(opts,seq);/g
s/@MODULEMAINFINISH@/  freeall();/g
