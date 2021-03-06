/* Generated: 23/4/2010 at 8:39:39 */
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

void firr(int* _x, int* _d, int* _res, int M, int D) {
  /* Aliases for all variables */
#define x(n) _x[(-1 + (n))]
#define d(n) _d[(-10 + (n))]
#define res(n) _res[(-10 + (n))]
  struct {
    int dim2;
    int dim0;
  } __W = {(-10 + 2*M), (100 + -10*2*M)};
#define W(t, p) _W[((p)*__W.dim2 + (t) + __W.dim0)]
  struct {
    int dim2;
    int dim0;
  } __Y = {(2*M + -9), (-10*2*M + 81)};
#define Y(t, p) _Y[((p)*__Y.dim2 + (t) + __Y.dim0)]
#define E(t, p) _E[(-10 + (p))]
#define outres(t, p) res(p)
   
  /* Allocate memory for local variables */
  int * _W = (int *) malloc(sizeof(int)*((-10*M + 90 + -9*2*M + M*2*M)));
  int * _Y = (int *) malloc(sizeof(int)*((81 + -9*2*M + -9*M + M*2*M)));
  int * _E = (int *) malloc(sizeof(int)*((-9 + M)));
  
   
  /* Loop variables */
  int n;
  int p;
  int t;
   
  /* A few loops */
  for (t = 0; t <= 8; ++t) {
    for (p = 10; p <= rfloor(((20 + t)),(2)); ++p) {
      W(t, p) = 0;
    }
  }
  t = 9;
  for (p = 10; p <= 14; ++p) {
    W(t, p) = 0;
  }
  p = 10;
  Y(t, p) = 0;
  for (t = 10; t <= 19; ++t) {
    for (p = rceil(((11 + t)),(2)); p <= rfloor(((20 + t)),(2)); ++p) {
      W(t, p) = 0;
    }
    if ((((11 + t))%2) == 0) {
      p = ((11 + t))/2;
      Y(t, p) = 0;
    }
    for (p = 10; p <= rfloor(((10 + t)),(2)); ++p) {
      Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
    }
  }
  t = 20;
  p = 16; {
    W(t, p) = 0;
  }
  /* dead code removed */
  p = 11; {
    Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
  }
  p = 10;
  outres(t, p) = Y((-1 + 2*p), p);
  for (t = 21; t <= (-1 + 2*D); ++t) {
    for (p = rceil(((11 + t)),(2)); p <= min(rfloor(((20 + t)),(2)),(9 + D)); ++p) {
      W(t, p) = 0;
    }
    if ((((11 + t))%2) == 0) {
      p = ((11 + t))/2;
      Y(t, p) = 0;
    }
    for (p = rceil(((1 + t)),(2)); p <= rfloor(((10 + t)),(2)); ++p) {
      Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
    }
    if ((((-1 + t))%2) == 0) {
      p = ((-1 + t))/2;
      E(t, p) = ((d(p) - outres(2*p, p)) / 32);
    }
    if (((t)%2) == 0) {
      p = (t)/2;
      outres(t, p) = Y((-1 + 2*p), p);
    }
  }
  for (t = 2*D; t <= (2*D + 7); ++t) {
    for (p = rceil(((11 + t)),(2)); p <= (9 + D); ++p) {
      W(t, p) = 0;
    }
    for (p = (10 + D); p <= min(rfloor(((20 + t)),(2)),M); ++p) {
      W(t, p) = (W((-2 + t), (-1 + p)) + (E((1 + -2*D + 2*p), (-D + p)) * x((11 + -D + -p + t))));
    }
    if ((((11 + t))%2) == 0) {
      p = ((11 + t))/2;
      Y(t, p) = 0;
    }
    for (p = rceil(((1 + t)),(2)); p <= rfloor(((10 + t)),(2)); ++p) {
      Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
    }
    if ((((-1 + t))%2) == 0) {
      p = ((-1 + t))/2;
      E(t, p) = ((d(p) - outres(2*p, p)) / 32);
    }
    if (((t)%2) == 0) {
      p = (t)/2;
      outres(t, p) = Y((-1 + 2*p), p);
    }
  }
  for (t = (2*D + 8); t <= (-11 + 2*M); ++t) {
    for (p = max((10 + D),rceil(((11 + t)),(2))); p <= min(rfloor(((20 + t)),(2)),M); ++p) {
      W(t, p) = (W((-2 + t), (-1 + p)) + (E((1 + -2*D + 2*p), (-D + p)) * x((11 + -D + -p + t))));
    }
    if ((((11 + t))%2) == 0) {
      p = ((11 + t))/2;
      Y(t, p) = 0;
    }
    for (p = rceil(((1 + t)),(2)); p <= rfloor(((10 + t)),(2)); ++p) {
      Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
    }
    if ((((-1 + t))%2) == 0) {
      p = ((-1 + t))/2;
      E(t, p) = ((d(p) - outres(2*p, p)) / 32);
    }
    if (((t)%2) == 0) {
      p = (t)/2;
      outres(t, p) = Y((-1 + 2*p), p);
    }
  }
  for (t = (-10 + 2*M); t <= (-1 + 2*M); ++t) {
    for (p = rceil(((1 + t)),(2)); p <= M; ++p) {
      Y(t, p) = (Y((-1 + t), p) + (W((-21 + 4*p + -t), p) * x((-10 + 3*p + -t))));
    }
    if ((((-1 + t))%2) == 0) {
      p = ((-1 + t))/2;
      E(t, p) = ((d(p) - outres(2*p, p)) / 32);
    }
    if (((t)%2) == 0) {
      p = (t)/2;
      outres(t, p) = Y((-1 + 2*p), p);
    }
  }
  t = 2*M;
  /* dead code removed */
  p = M;
  outres(t, p) = Y((-1 + 2*p), p);
  t = (1 + 2*M);
  p = M;
  E(t, p) = ((d(p) - outres(2*p, p)) / 32);
   
  /* Clean up local variables' memory */
  /* Commented out because it was crashing at run time*/
  /*
  free(_W);
  free(_Y);
  free(_E);
  
  */
  /* And finally undef aliases */
#undef x
#undef d
#undef res
#undef W
#undef Y
#undef E
#undef outres
}
 
int main (void) {
#define x(n) _x[(-1 + (n))]
#define d(n) _d[(-10 + (n))]
#define res(n) _res[(-10 + (n))]
  int * _x = (int *) malloc(sizeof(int)*(M));
  int * _d = (int *) malloc(sizeof(int)*((-9 + M)));
  int * _res = (int *) malloc(sizeof(int)*((-9 + M)));
  int n;
   FILE   *file_x=fopen("stimx.txt","w"); 
   FILE   *file_d=fopen("stimd.txt","w"); 
   FILE   *file_res=fopen("stimres.txt","w"); 
  for (n = 1; n <= M; ++n) {
    fprintf(stdout, "x[%i]?", n);
    fscanf(stdin, "%i", &(x(n)));
    fprintf(file_x,"x[%i]=", n);
    fprintf(file_x,"%i\n", (x(n)));
  }
  for (n = 10; n <= M; ++n) {
    fprintf(stdout, "d[%i]?", n);
    fscanf(stdin, "%i", &(d(n)));
    fprintf(file_d,"d[%i]=", n);
    fprintf(file_d,"%i\n", (d(n)));
  }
  firr(_x, _d, _res);
  for (n = 10; n <= M; ++n) {
    fprintf(stdout, "res[%i]=%i\n", n, res(n));
    fprintf(file_res,"res[%i]=%i\n", n, res(n));
  }
  fclose(file_x);
  fclose(file_d);
  fclose(file_res);
  free(_x);
  free(_d);
  free(_res);
#undef x
#undef d
#undef res
   exit(0);
}
