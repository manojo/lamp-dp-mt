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

realvar v2[4];
double compute_v2(i)
int i;
{
  realvar *tmp;
/*printf("Computing: v2[%d]\n" ,i);*/
  tmp = &(v2[i-1]);
  if (!tmp->computed) {
     printf("Input v2[%d] =" ,i);
     gets(_s);
     tmp->value = atof(_s);
     tmp->computed = 1;}
  return tmp->value;
}

/* --output variables */

realvar c;
double compute_c();

realvar s;
double compute_s();

/* --local variables */

realvar alp;
double compute_alp();

realvar beta;
double compute_beta();

realvar gama;
double compute_gama();

realvar eps;
double compute_eps();

realvar t;
double compute_t();

realvar al[5];
double compute_al();

realvar be[5];
double compute_be();

realvar ga[5];
double compute_ga();

/* --let equations */

double compute_al(j)
int j;
{
  realvar *tmp;
/*printf("Computing: al[%d]\n" ,j);*/
  tmp = &(al[j]);
  if (!tmp->computed) {
     tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_al(j-1) + compute_v1(j) * compute_v1(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_alp()
{
  realvar *tmp;
/*printf("Computing: alp[]\n");*/
  tmp = &(alp);
  if (!tmp->computed) {
     tmp->value = compute_al(4);
     tmp->computed = 1;}
  return tmp->value;
}

double compute_be(j)
int j;
{
  realvar *tmp;
/*printf("Computing: be[%d]\n" ,j);*/
  tmp = &(be[j]);
  if (!tmp->computed) {
     tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_be(j-1) + compute_v2(j) * compute_v2(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_beta()
{
  realvar *tmp;
/*printf("Computing: beta[]\n");*/
  tmp = &(beta);
  if (!tmp->computed) {
     tmp->value = sqrt(compute_be(4));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_ga(j)
int j;
{
  realvar *tmp;
/*printf("Computing: ga[%d]\n" ,j);*/
  tmp = &(ga[j]);
  if (!tmp->computed) {
     tmp->value = ( j==0 )  ? ( 0 ) : 
         ( j-1>=0 )  ? ( compute_ga(j-1) + compute_v1(j) * compute_v2(j) ) : 
         ( printf("? case error\n"), exit(-1));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_gama()
{
  realvar *tmp;
/*printf("Computing: gama[]\n");*/
  tmp = &(gama);
  if (!tmp->computed) {
     tmp->value = compute_ga(4);
     tmp->computed = 1;}
  return tmp->value;
}

double compute_eps()
{
  realvar *tmp;
/*printf("Computing: eps[]\n");*/
  tmp = &(eps);
  if (!tmp->computed) {
     
     tmp->value = compute_beta() - compute_alp() / 2 * compute_gama();
     tmp->computed = 1;}
  return tmp->value;
}

double compute_t()
{
  realvar *tmp;
/*printf("Computing: t[]\n");*/
  tmp = &(t);
  if (!tmp->computed) {
     tmp->value = (compute_eps() == 0) ? (1) : (
             (compute_eps() > 0) ? 
             (1 / (compute_eps() + 1 + compute_eps() * compute_eps())) : 
             (-1 / (-compute_eps() + 1 + compute_eps() * compute_eps())));
     tmp->computed = 1;}
  return tmp->value;
}

double compute_c()
{
  realvar *tmp;
/*printf("Computing: c[]\n");*/
  tmp = &(c);
  if (!tmp->computed) {
     tmp->value = 1 / (1 + compute_t() * compute_t());
     tmp->computed = 1;}
  return tmp->value;
}

double compute_s()
{
  realvar *tmp;
/*printf("Computing: s[]\n");*/
  tmp = &(s);
  if (!tmp->computed) {
     tmp->value = compute_c() * compute_t();
     tmp->computed = 1;}
  return tmp->value;
}

int main()
{
   printf("c = %f\n" , compute_c() );
   
   printf("s = %f\n" , compute_s() );
   
}
