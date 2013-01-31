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

/* --output variables */

realvar a[9];
double compute_a();

realvar b[9];
double compute_b();

realvar c[9];
double compute_c();

/* --local variables */

intvar C[36];
int compute_C();

intvar A[9];
int compute_A();

intvar B[9];
int compute_B();

/* --let equations */

int compute_A(i,j)
int i,j;
{
  intvar *tmp;
/*printf("Computing: A[%d,%d]\n" ,i,j);*/
  tmp = &(A[i+3*j-4]);
  if (!tmp->computed) {
     tmp->value = ( i-1==0 && j-1==0 )  ? ( 1 ) : 
         ( j-1==0 && i-2>=0 )  ? ( compute_A(i-1,j) + 3 ) : 
         ( j-2>=0 )  ? ( compute_A(i,j-1) + 1 ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

int compute_B(i,j)
int i,j;
{
  intvar *tmp;
/*printf("Computing: B[%d,%d]\n" ,i,j);*/
  tmp = &(B[i+3*j-4]);
  if (!tmp->computed) {
     tmp->value = ( i-1==0 && j-1==0 )  ? ( 1 ) : 
         ( i-j==0 && j-2>=0 )  ? ( 2 ) : 
         ( i-j-1>=0 )  ? ( 0 ) : 
         ( -i+j-1>=0 )  ? ( 0 ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

int compute_C(i,j,k)
int i,j,k;
{
  intvar *tmp;
/*printf("Computing: C[%d,%d,%d]\n" ,i,j,k);*/
  tmp = &(C[i+3*j+9*k-4]);
  if (!tmp->computed) {
     tmp->value = ( k==0 )  ? ( 0 ) : 
         ( k-1>=0 )  ? 
            ( compute_C(i,j,k-1) + compute_A(i,k) * compute_B(k,j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_a(i,j)
int i,j;
{
  realvar *tmp;
/*printf("Computing: a[%d,%d]\n" ,i,j);*/
  tmp = &(a[i+3*j-4]);
  if (!tmp->computed) {
     tmp->value = compute_A(i,j);
     tmp->computed = 1;}
  return tmp->value;
}

double compute_b(i,j)
int i,j;
{
  realvar *tmp;
/*printf("Computing: b[%d,%d]\n" ,i,j);*/
  tmp = &(b[i+3*j-4]);
  if (!tmp->computed) {
     tmp->value = compute_B(i,j);
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
   printf("a[%d,%d]= %f\n", i,j, compute_a(i,j) );
   }}}
   { int i,j ;
   for (i=1; i<=3; i++) {
   for (j=1; j<=3; j++) {
   printf("b[%d,%d]= %f\n", i,j, compute_b(i,j) );
   }}}
   { int i,j ;
   for (i=1; i<=3; i++) {
   for (j=1; j<=3; j++) {
   printf("c[%d,%d]= %f\n", i,j, compute_c(i,j) );
   }}}
}
