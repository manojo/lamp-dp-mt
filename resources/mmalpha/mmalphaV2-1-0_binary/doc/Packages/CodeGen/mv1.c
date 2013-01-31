/* Generated: 8/9/2002 at 20:51:51 */
/* Code generated by MMAlpha code generator version 0.2.6 (02/02/2001 11:35) FQ */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <assert.h>
 
 

#define min(a,b) ((a) > (b) ? (b) : (a))
#define max(a,b) ((a) > (b) ? (a) : (b))
#define power(a, i) ((a)^(i))
static int rfloor (int a, int b) {
  assert (b>0);
  return ((a<0) ? ((a+1)/b)-1 : a/b);
}
static int rceil (int a, int b) {
  assert (b>0);
  return ((a>0) ?  ((a-1)/b)+1 : a/b);
}

void prodVect(int* _a, int* _b, int* _c) {
  /* aliases for all variables */
#define a(i, j) _a[(3*(j) + -4 + (i))]
#define b(i) _b[(-1 + (i))]
#define c(i) _c[(-1 + (i))]
#define C(t, p) _C[(4*(p) + -5 + (t))]
#define outc(t, p) c(p)
   
  /* allocate memory for local variables */
  int * _C = (int *) malloc(sizeof(int)*(12));
  
   
  /* loops variables */
  int i;
  int p;
  int t;
   
  /* a few loops */
  t = 1;
  for (p = 1; p <= 3; ++p) {
    C(t, p) = 0;
  }
  for (t = 2; t <= 3; ++t) {
    for (p = 1; p <= 3; ++p) {
      C(t, p) = (C((-1 + t), p) + (a(p, (-1 + t)) * b((-1 + t))));
    }
  }
  t = 4;
  for (p = 1; p <= 3; ++p) {
    C(t, p) = (C((-1 + t), p) + (a(p, (-1 + t)) * b((-1 + t))));
  }
  for (p = 1; p <= 3; ++p) {
    outc(t, p) = C(t, p);
  }
   
  /* clean up local variables' memory */
  /* commented out because it was crashing at run time*/
  /*
  free(_C);
  
  */
  /* and finally undef aliases */
#undef a
#undef b
#undef c
#undef C
#undef outc
}
 
int main (void) {
#define a(i, j) _a[(3*(j) + -4 + (i))]
#define b(i) _b[(-1 + (i))]
#define c(i) _c[(-1 + (i))]
  int * _a = (int *) malloc(sizeof(int)*(9));
  int * _b = (int *) malloc(sizeof(int)*(3));
  int * _c = (int *) malloc(sizeof(int)*(3));
  int i;
  int j;
   
  for (i = 1; i <= 3; ++i) {
    for (j = 1; j <= 3; ++j) {
       
      fscanf(stdin, "%i", &(a(i, j)));
       
    }
  }
  for (i = 1; i <= 3; ++i) {
     
    fscanf(stdin, "%i", &(b(i)));
     
  }
  prodVect(_a, _b, _c);
  for (i = 1; i <= 3; ++i) {
    fprintf(stdout, "%i\n", c(i));
     
  }
   
  free(_a);
  free(_b);
  free(_c);
#undef a
#undef b
#undef c
   exit(0);
}
