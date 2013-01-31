/* system matrix_mult */

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

intvar a[9];
int compute_a(i,j)
int i,j;
{
  intvar *tmp;
/*printf("Computing: a[%d,%d]\n" ,i,j);*/
  tmp = &(a[i+3*j-4]);
  if (!tmp->computed) {
     printf("Input a[%d,%d] =" ,i,j);
     gets(_s);
     tmp->value = atoi(_s);
     tmp->computed = 1;}
  return tmp->value;
}

intvar b[9];
int compute_b(i,j)
int i,j;
{
  intvar *tmp;
/*printf("Computing: b[%d,%d]\n" ,i,j);*/
  tmp = &(b[i+3*j-4]);
  if (!tmp->computed) {
     printf("Input b[%d,%d] =" ,i,j);
     gets(_s);
     tmp->value = atoi(_s);
     tmp->computed = 1;}
  return tmp->value;
}

/* --output variables */

realvar c[9];
double compute_c();

/* --local variables */

intvar C[36];
int compute_C();

/* --let equations */

int compute_C(i,j,k)
int i,j,k;
{
  intvar *tmp;
/*printf("Computing: C[%d,%d,%d]\n" ,i,j,k);*/
  tmp = &(C[i+3*j+9*k-4]);
  if (!tmp->computed) {
     tmp->value = ( k==0 )  ? ( 0 ) : 
         ( k-1>=0 )  ? 
            ( compute_C(i,j,k-1) + compute_a(i,k) * compute_b(k,j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_c(i,j)
int i,j;
{
  realvar *tmp;
/*printf("Computing: c[%d,%d]\n" ,i,j);*/
  tmp = &(c[i+3*j-4]);
  if (!tmp->computed) {
     tmp->value = compute_C(i,j,3);
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   { int i,j ;
   for (i=1; i<=3; i++) {
   for (j=1; j<=3; j++) {
   printf("c[%d,%d]= %f\n", i,j, compute_c(i,j) );
   }}}
}
