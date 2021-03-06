/* system cosparam */

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

/* input variables */
char __s_[32];
realvar __v1[4];
#define v1(i)	__v1[(i)-1]
realvar __v2[4];
#define v2(i)	__v2[(i)-1]

/* output variables */
realvar __c;
#define c()	__c
realvar __s;
#define s()	__s

/* local variables */
realvar __alp;
#define alp()	__alp
realvar __beta;
#define beta()	__beta
realvar __gama;
#define gama()	__gama
realvar __eps;
#define eps()	__eps
realvar __t;
#define t()	__t
realvar __al[5];
#define al(j)	__al[(j)]
realvar __be[5];
#define be(j)	__be[(j)]
realvar __ga[5];
#define ga(j)	__ga[(j)]

static double compute_v1(i)
int i;
{
  realvar *tmp;
/* printf("Computing: v1[%d]\n" ,i); */
  tmp = &(v1(i));
  if (!tmp->computed) {
          printf("Input v1[%d] =" ,i);
     gets(__s_);
     tmp->value = atof(__s_);
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_v2(i)
int i;
{
  realvar *tmp;
/* printf("Computing: v2[%d]\n" ,i); */
  tmp = &(v2(i));
  if (!tmp->computed) {
          printf("Input v2[%d] =" ,i);
     gets(__s_);
     tmp->value = atof(__s_);
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_c();

static double compute_s();

static double compute_alp();

static double compute_beta();

static double compute_gama();

static double compute_eps();

static double compute_t();

static double compute_al();

static double compute_be();

static double compute_ga();

/* --let equations */
static double compute_al(j)
int j;
{
  realvar *tmp;
/* printf("Computing: al[%d]\n" ,j); */
  tmp = &(al(j));
  if (!tmp->computed) {
          tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_al(j-1) + compute_v1(j) * compute_v1(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_alp()
{
  realvar *tmp;
/* printf("Computing: alp[]\n"); */
  tmp = &(alp());
  if (!tmp->computed) {
          tmp->value = compute_al(4);
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_be(j)
int j;
{
  realvar *tmp;
/* printf("Computing: be[%d]\n" ,j); */
  tmp = &(be(j));
  if (!tmp->computed) {
          tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_be(j-1) + compute_v2(j) * compute_v2(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_beta()
{
  realvar *tmp;
/* printf("Computing: beta[]\n"); */
  tmp = &(beta());
  if (!tmp->computed) {
          tmp->value = compute_be(4);
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_ga(j)
int j;
{
  realvar *tmp;
/* printf("Computing: ga[%d]\n" ,j); */
  tmp = &(ga(j));
  if (!tmp->computed) {
          tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_ga(j-1) + compute_v1(j) * compute_v2(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_gama()
{
  realvar *tmp;
/* printf("Computing: gama[]\n"); */
  tmp = &(gama());
  if (!tmp->computed) {
          tmp->value = compute_ga(4);
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_eps()
{
  realvar *tmp;
/* printf("Computing: eps[]\n"); */
  tmp = &(eps());
  if (!tmp->computed) {
          tmp->value = (compute_beta() - compute_alp()) / 2 * compute_gama();
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_t()
{
  realvar *tmp;
/* printf("Computing: t[]\n"); */
  tmp = &(t());
  if (!tmp->computed) {
          tmp->value = (compute_eps() == 0) ? (1) : ((compute_eps() > 0) ? (1 / (compute_eps() + 1 + compute_eps() * compute_eps())) : (-1 / (-compute_eps() + 1 + compute_eps() * compute_eps())));
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_c()
{
  realvar *tmp;
/* printf("Computing: c[]\n"); */
  tmp = &(c());
  if (!tmp->computed) {
          tmp->value = 1 / (1 + compute_t() * compute_t());
     tmp->computed = 1;}
  return tmp->value;
}

static double compute_s()
{
  realvar *tmp;
/* printf("Computing: s[]\n"); */
  tmp = &(s());
  if (!tmp->computed) {
          tmp->value = compute_c() * compute_t();
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   int j, i ;
   
   /* --inputs */
   for (i=1; i<=4; i++)
   {  printf("v1[%d]= %f\n", i, compute_v1(i) );
   }
   for (i=1; i<=4; i++)
   {  printf("v2[%d]= %f\n", i, compute_v2(i) );
   }
   /* --outputs */
   printf("c = %f\n" , compute_c() );
   printf("s = %f\n" , compute_s() );
}
