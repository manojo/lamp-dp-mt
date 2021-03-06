/* Generated: 27/12/2002 at 18:31:31 */
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

void SimpleEx(float* _a, float* _c, int N) {
  /* aliases for all variables */
#define a(n) _a[(-1 + (n))]
#define c(n) _c[(-1 + (n))]
#define A(t, p) _A[(-1 + (p))]
#define outc(t, p) c(p)
   
  /* allocate memory for local variables */
  float * _A = (float *) malloc(sizeof(float)*(N));
  
   
  /* loops variables */
  int n;
  int p;
  int t;
   
  /* a few loops */
  t = 1;
  for (p = 1; p <= N; ++p) {
    A(t, p) = (a(p) * a(p));
  }
  t = 2;
  for (p = 1; p <= N; ++p) {
    outc(t, p) = A(1, p);
  }
   
  /* clean up local variables' memory */
  /* commented out because it was crashing at run time*/
  /*
  free(_A);
  
  */
  /* and finally undef aliases */
#undef a
#undef c
#undef A
#undef outc
}
 
int main (void) {
#define a(n) _a[(-1 + (n))]
#define c(n) _c[(-1 + (n))]
  float * _a = (float *) malloc(sizeof(float)*(N));
  float * _c = (float *) malloc(sizeof(float)*(N));
  int n;
   
  for (n = 1; n <= N; ++n) {
    fprintf(stdout, "a[%i]?", n);
    fscanf(stdin, "%f", &(a(n)));
     
  }
  SimpleEx(_a, _c);
  for (n = 1; n <= N; ++n) {
    fprintf(stdout, "c[%i]=%f\n", n, c(n));
     
  }
   
  free(_a);
  free(_c);
#undef a
#undef c
   exit(0);
}
