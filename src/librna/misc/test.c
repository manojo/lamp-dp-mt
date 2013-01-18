
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// FLAGS:= ../vienna/*.c

int c_len=0;
char* c_seq=NULL;

#define my_len c_len
#define my_seq c_seq
#define my_P c_P
#define my_dev
#include "../librna_impl.h"
#include "../vienna/vienna.h"
#define my_seq c_seq

#define PRIVATE static
#define MIN2(a,b) ((a)<(b) ? (a) : (b))
#include "../rnafold/loop_energies.h"

void freeSeq() { free(c_seq); free(c_P); }
void initSeq(const char* param, const char* seq) {
  int i; read_parameter_file(param);
  c_P = get_scaled_parameters();
  c_len = strlen(seq);
  c_seq = malloc(c_len+1);
  for (i=0; i<c_len; ++i) switch (seq[i]) {
    case 'a': c_seq[i]=1; break;
    case 'c': c_seq[i]=2; break;
    case 'g': c_seq[i]=3; break;
    case 'u': c_seq[i]=4; break;
    default: exit(1);
  }
}

int E_stack(int i, int j) { // = sr_energy
  return c_P->stack[_bp(i,j)][_bp(j-1,i+1)];
}



int main(int argc, char **argv) {
  const char* s= "aacaaaccggguuuguu";

  initSeq("../vienna/rna_turner2004.par",s);

/*
  printf("%d -- /\n",ext_mismatch_energy(0, 9)); // dlr
  printf("%d -- /\n",termau_energy(0,9));
  printf("%d -- %d\n",sr_energy(0,9), E_stack(0,9)); // stack
  printf("%d -- %d\n",sr_energy(1,8), E_stack(1,8)); // hairpin
  printf("%d -- %d\n",hl_energy(2,7), E_Hairpin(4,_bp(2,7),3,6,"CUCAGG",c_P));
  */

/*
  int r =
    ext_mismatch_energy(0, 9) + termau_energy(0,9) + // dlr(0,9)
    sr_energy(0,9) + // stack(0,9)
    sr_energy(1,8) + hl_energy(2,7); // hairpin (1,8)

  printf("Result = %d (goal = -130)\n",r);
*/


  printf("CPU Result = %d\n",
    ext_mismatch_energy(1,16) + termau_energy(1,16)
  );

  printf("GPU Result = %d\n",
    ext_mismatch_energy(0,17) + termau_energy(0,17) +
    sr_energy(1,16)
  );




  freeSeq();
  return 0;
}
