/* system R5 */

/* C-Code generated by Alpha Code Generator version 1.2 */

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
#define SHR(x,y) ((x)/(double)(1<<(y)))
#define SHL(x,y) ((x)*(double)(1<<(y)))
#define EXP(x,y) pow((x),(y))
#define TRUNCATE(x) ((int)(x))
#define CEILING(x) ((int)(ceil(x)))
#define FLOOR(x) ((int)(floor(x)))
#define ROUND(x) ((int)(rint(x)))
#define FLOAT(x) ((double)(x))

/* parameters */
#define W 4

/* no input variables */

/* output variables */
intvar __XT[4];
#define XT(k)	__XT[(k)]

/* no local variables */

static int compute_XT();

/* --let equations */
static int compute_XT(k)
int k;
{
  intvar *tmp;
/* printf("Computing: XT[%d]\n" ,k); */
  tmp = &(XT(k));
  if (!tmp->computed) {
          tmp->value = (2*k+1);
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   int k ;
   
   /* --inputs */
   /* --outputs */
   for (k=0; k<=W-1; k++)
   {  printf("XT[%d]= %d\n", k, compute_XT(k) );
   }
}