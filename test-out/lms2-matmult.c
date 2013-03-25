/*****************************************
  Emitting C Generated Code
*******************************************/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {int t1; int t2; int t3; } T3iii;
typedef struct {T3iii t1; T3iii t2; } T2TT;
typedef struct {int t1; int t2 ;} T2ii;

T3iii testParse(T2ii x2[], const int x4) {
const int x5 = x4 + 1;
const int x6 = x5 * x5;
T3iii x7[x6];
const T3iii x3 = (T3iii){0,10000,0};
for(int x9=0; x9 < x5; x9++) {
const int x10 = x5 - x9;
for(int x12=0; x12 < x10; x12++) {
T3iii x14 = x3;
const int x13 = x9 + x12;
const int x15 = x12 + 1;
const bool x16 = x15 == x13;
if (x16) {
const T3iii x24 = x14;
const int x26 = x24.t2;
const bool x28 = x26 < 0;
T3iii x29;
if (x28) {
x29 = x24;
} else {
const T2ii x17 = x2[x12];
const int x21 = x17.t1;
const int x22 = x17.t2;
const T3iii x23 = (T3iii){x21,0,x22};
x29 = x23;
}
x14 = x29;
} else {
}
const int x18 = x13 - 1;
const int x19 = x18 + 1;
const bool x20 = x15 < x19;
const int x35 = x5 * x12;
if (x20) {
for(int x34=x15; x34 < x19; x34++) {
const int x36 = x35 + x34;
const T3iii x37 = x7[x36];
const bool x38 = true; //x37 != null;
if (x38) {
const int x39 = x5 * x34;
const int x40 = x39 + x13;
const T3iii x41 = x7[x40];
const bool x42 = true; //x41 != null;
if (x42) {
const T2TT x43 = (T2TT){x37,x41};
const T3iii x44 = x43.t1;
const T3iii x45 = x43.t2;
const int x46 = x44.t1;
const int x47 = x44.t2;
const int x48 = x44.t3;
const int x49 = x45.t1;
const int x50 = x45.t2;
const int x51 = x45.t3;
const T3iii x57 = x14;
const int x52 = x47 + x50;
const int x53 = x46 * x48;
const int x54 = x53 * x51;
const int x55 = x52 + x54;
const int x59 = x57.t2;
const bool x61 = x59 < x55;
T3iii x62;
if (x61) {
x62 = x57;
} else {
const T3iii x56 = (T3iii){x46,x55,x51};
x62 = x56;
}
x14 = x62;
} else {
}
} else {
}
}
} else {
}
const T3iii x73 = x14;
const int x72 = x35 + x13;
x7[x72] = x73;
}
}
T3iii x79 = x3;
const int x80 = x5 * 0;
const int x81 = x80 + x4;
const T3iii x82 = x7[x81];
const bool x83 = true; //x82 != null;
if (x83) {
x79 = x82;
} else {
}
const T3iii x87 = x79;
return x87;
}
/*****************************************
  End of C Generated Code
*******************************************/

int main() {

  T2ii matrices[] = {
    {1, 2}
  };

  T3iii res = testParse(matrices, 0);

  printf("(%d, %d, %d)\n", res.t1, res.t2, res.t3 );

}
