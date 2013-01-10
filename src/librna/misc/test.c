#include "../rnalib.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// FLAGS:= -std=c99 ../rnalib.c ../vienna/*.c

void conv(char *x) {
  for (int i=0,l=strlen(x); i < l; i++) switch (x[i]) {
    case 'a' : x[i] = 1; break;
    case 'c' : x[i] = 2; break;
    case 'g' : x[i] = 3; break;
    case 'u' : x[i] = 4; break;
    default: exit(1);
  }
}

int main(int argc, char **argv) {
  char s[]="gccaaccucgugca";
  //        (((......).)).     len=14
  //        --        --- bulgeRight(0,12)
  //          -      - sr(2,9)

  conv(s);
  librna_read_param_file("../vienna/rna_turner2004.par");

  /*
  // ml
  printf("%d\n",ml_energy());
  printf("%d\n",ul_energy());
  printf("%d\n",ml_mismatch_energy(s, 1, 12));
  printf("%d\n",sr_energy(s, 0, 13));
  printf("%d\n",termau_energy(s, 0, 13));
  printf("%d\n",ml_mismatch_energy(s, 1, 12));
  // il
  printf("%d\n",il_energy(s, 1, 2, 11, 12));
  printf("%d\n",sr_energy(s,0, 13));
  */
  /*
  printf("%d\n",br_energy(s,1,9,9,11,11));
  printf("%d\n",br_energy(s,1,10,10,11,11));
  printf("%d\n",br_energy(s,1,9,9,12,11));
  */

  int r =
    ext_mismatch_energy(s,0, 12, 14) + termau_energy(s,0,12) + // dlr(0..12)
    // br: bulge right
    br_energy(s,1,9,11,11,2) +
    sr_energy(s,0,12) + // bulge


    //hl_energy(s,5,9) +

    // ml: multi-loop
    //ml_energy() + ul_energy() +
    //sr_energy(s, 0, 13) + termau_energy(s, 0, 13) + ml_mismatch_energy(s, 1, 12) +

    sr_energy(s,2,9); // inner sr


  printf("Result = %d (goal = -10)\n",r);

  return 0;
}
