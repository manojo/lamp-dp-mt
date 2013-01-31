/* system foo */

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

intvar b;
int compute_b();

/* --local variables */

intvar A;
int compute_A();

/* --let equations */

int compute_A()
{
  intvar *tmp;
/*printf("Computing: A[]\n");*/
  tmp = &(A);
  if (!tmp->computed) {
     tmp->value = -2;
     tmp->computed = 1;}
  return tmp->value;
}

int compute_b()
{
  intvar *tmp;
/*printf("Computing: b[]\n");*/
  tmp = &(b);
  if (!tmp->computed) {
     tmp->value = compute_A();
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   printf("b = %d\n" , compute_b() );
   
}
