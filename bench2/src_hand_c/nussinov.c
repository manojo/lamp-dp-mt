#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <stdbool.h>

#define MAX(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a>_b?_a:_b; })
#define MIN(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a<_b?_a:_b; })

typedef struct {int t1; int t2; int t3; } T3iii;
typedef struct {T3iii t1; T3iii t2; } T2TT;
typedef struct {int t1; int t2 ;} T2ii;

int nussinov(const char in[], const int size) {

  int n = size+1;
  int costMatrix[n][n];

/*  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      costMatrix[i][j] = 0;
    }
  }
  */

  for(int d = 0; d < n; d++){
    for(int i = 0; i < n-d; i++){
      int j = d + i;

      int max = 0;

      /*if(i ==j && i+1 == j){
        //no pairings possible
      }*/

      if(i+1 < j){
        char left = in[i]; char right = in[j-1];
        printf("(%d, %d)\n", i, j);
        printf("(%c, %c)\n", left, right );

        bool isBasePair =
          (left == 'a' && right == 'u') ||
          (left == 'u' && right == 'a') ||
          (left == 'g' && right == 'u') ||
          (left == 'u' && right == 'g') ||
          (left == 'c' && right == 'g') ||
          (left == 'g' && right == 'c');

        if(!isBasePair){
          max = MAX(max, costMatrix[i+1][j]);
          max = MAX(max, costMatrix[i][j-1]);
        }else{
          max = MAX(max, costMatrix[i+1][j-1])+1;
        }


        for(int k = i+1; k < j-1; k++){
          int left = costMatrix[i][k];
          int right = costMatrix[k+1][j];

          max = MAX(max, left+right);

        }
      }
      costMatrix[i][j] = max;
    }
  }

  for(int i = 0; i < n; i++) {
      for(int j = 0; j < n; j++) {
          printf("%d ", costMatrix[i][j]);
      }
      printf("\n");
  }

  return costMatrix[0][size];
}

int main() {

  char rna[] = {
    'a','c','g','u','a','c','g','u'
  };

  struct timeval ts, te;
  gettimeofday(&ts, NULL);

  int res = nussinov(rna, 8);

  gettimeofday(&te, NULL);

  double last=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("Runnin time: %7.2fms [%7.2f,%7.2f], %d runs \n",last);


  printf("%d\n", res);

}