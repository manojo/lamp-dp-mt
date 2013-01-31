/* system cosparam */

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

realvar v1[4];
double compute_v1(i)
int i;
{
  realvar *tmp;
/*printf("Computing: v1[%d]\n" ,i);*/
  tmp = &(v1[i-1]);
  if (!tmp->computed) {
     printf("Input v1[%d] =" ,i);
     gets(_s);
     tmp->value = atof(_s);
     tmp->computed = 1;}
  return tmp->value;
}

/* --output variables */

realvar v2[4];
double compute_v2();

/* --local variables */

realvar ga[5];
double compute_ga();

/* --let equations */

double compute_v2(i)
int i;
{
  realvar *tmp;
/*printf("Computing: v2[%d]\n" ,i);*/
  tmp = &(v2[i-1]);
  if (!tmp->computed) {
     tmp->value = sqrt(compute_v1(i-1));
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   { int i ;
   for (i=1; i<=4; i++) {
   printf("v2[%d]= %f\n", i, compute_v2(i) );
   }}
}
