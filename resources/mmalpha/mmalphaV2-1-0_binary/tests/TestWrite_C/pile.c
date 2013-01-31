/* system pile */

#include <math.h>

typedef struct { int value;
		 int computed; } intvar;
typedef struct { int value;
		 int computed; } boolvar;
typedef struct { double value;
		 int computed; } realvar;
double atof();
int    atoi();

#define min(x,y) ((x)<(y)?(x):(y))
#define max(x,y) ((x)>(y)?(x):(y))
#define INFINITY 0x7fffffff

/* --parameters */

/* --input variables */

char _s[32];

boolvar b;
int compute_b()
{
  boolvar *tmp;
/*printf("Computing: b[]\n");*/
  tmp = &(b);
  if (!tmp->computed) {
     printf("Input b =" );
     gets(_s);
     tmp->value = atoi(_s);
     tmp->computed = 1;}
  return tmp->value;
}

/* --output variables */

intvar S[5];
int compute_S();

/* --local variables */

int compute_C();

int compute_V();

int compute_R();

/* --let equations */

int compute_C(t)
int t;
{
  int tmp;
/*printf("Computing: C[%d]\n" ,t);*/
  tmp = ( t-1==0 )  ? ( 0 ) : 
    ( t-2==0 )  ? ( 0 ) : 
    ( t-3==0 )  ? ( 2 ) : 
    ( t-4==0 )  ? ( 1 ) : 
    ( t-5==0 )  ? ( 1 ) : 
    ( printf("? case error\n"), exit(-1));
  return tmp;
}

int compute_V(t)
int t;
{
  int tmp;
/*printf("Computing: V[%d]\n" ,t);*/
  tmp = ( t==0 )  ? ( 0 ) : 
    ( t-1==0 )  ? ( 1 ) : 
    ( t-2==0 )  ? ( 2 ) : 
    ( t-3==0 )  ? ( 3 ) : 
    ( t-4==0 )  ? ( 4 ) : 
    ( t-5==0 )  ? ( 5 ) : 
    ( printf("? case error\n"), exit(-1));
  return tmp;
}

int compute_R(t,p)
int t,p;
{
  int tmp;
/*printf("Computing: R[%d,%d]\n" ,t,p);*/
  tmp = ( p-1>=0 && -p+5>=0 )  ? 
       ( (compute_C(t) == 0) ? (compute_R(t-1,p-1)) : (0) ) : 
    ( p==0 )  ? ( compute_V(t) ) : 
    ( p-5==0 )  ? ( 0 ) : 
    ( printf("? case error\n"), exit(-1));
  return tmp;
}

int compute_S(t)
int t;
{
  intvar *tmp;
/*printf("Computing: S[%d]\n" ,t);*/
  tmp = &(S[t-1]);
  if (!tmp->computed) {
     tmp->value = compute_R(t,1);
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   { int t ;
   for (t=1; t<=5; t++) {
   printf("S[%d]= %d\n", t, compute_S(t) );
   }}
}
