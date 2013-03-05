/* system foo */

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

/* parameters not fixed at compile time */

/* no input variables */

/* no output variables */

/* local variables */
intvar __A;
#define A()	__A

static int compute_A();

/* --let equations */
static int compute_A()
{
  intvar *tmp;
/* printf("Computing: A[]\n"); */
  tmp = &(A());
  if (!tmp->computed) {
          tmp->value = -2;
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   /* no indices */
   /* --inputs */
   /* --outputs */
}