/* system foobug2 */

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

intvar a[4];
int compute_a();

/* --local variables */

intvar A[4];
int compute_A();

/* --let equations */

int compute_A(i)
int i;
{
  intvar *tmp;
/*printf("Computing: A[%d]\n" ,i);*/
  tmp = &(A[i-1]);
  if (!tmp->computed) {
     tmp->value = ( -i+1>=0 )  ? ( 0 ) : 
         ( i-3>=0 )  ? ( 0 ) : 
         ( i-2==0 )  ? ( 1 ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

int compute_a(i)
int i;
{
  intvar *tmp;
/*printf("Computing: a[%d]\n" ,i);*/
  tmp = &(a[i-1]);
  if (!tmp->computed) {
     tmp->value = compute_A(i);
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   { int i ;
   for (i=1; i<=4; i++) {
   printf("a[%d]= %d\n", i, compute_a(i) );
   }}
}
