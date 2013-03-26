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
const int x12 = x5 - 1;
for(int x9=0; x9 < x5; x9++) {
for(int x11=x9; x11 < x5; x11++) {
T3iii x15 = x3;
const int x13 = x12 - x11;
const int x14 = x13 + x9;
const int x16 = x13 + 1;
const bool x17 = x16 == x14;
if (x17) {
const T3iii x25 = x15;
const int x27 = x25.t2;
const bool x29 = x27 < 0;
T3iii x30;
if (x29) {
x30 = x25;
} else {
const T2ii x18 = x2[x13];
const int x22 = x18.t1;
const int x23 = x18.t2;
const T3iii x24 = (T3iii){x22,0,x23};
x30 = x24;
}
x15 = x30;
} else {
}
const int x19 = x14 - 1;
const int x20 = x19 + 1;
const bool x21 = x16 < x20;
const int x36 = x5 * x13;
if (x21) {
for(int x35=x16; x35 < x20; x35++) {
const int x37 = x36 + x35;
const T3iii x38 = x7[x37];
const bool x39 = true; //x38 != null;
if (x39) {
const int x40 = x5 * x35;
const int x41 = x40 + x14;
const T3iii x42 = x7[x41];
const bool x43 = true;// x42 != null;
if (x43) {
const T2TT x44 = (T2TT){x38,x42};
const T3iii x45 = x44.t1;
const T3iii x46 = x44.t2;
const int x47 = x45.t1;
const int x48 = x45.t2;
const int x49 = x45.t3;
const int x50 = x46.t1;
const int x51 = x46.t2;
const int x52 = x46.t3;
const T3iii x58 = x15;
const int x53 = x48 + x51;
const int x54 = x47 * x49;
const int x55 = x54 * x52;
const int x56 = x53 + x55;
const int x60 = x58.t2;
const bool x62 = x60 < x56;
T3iii x63;
if (x62) {
x63 = x58;
} else {
const T3iii x57 = (T3iii){x47,x56,x52};
x63 = x57;
}
x15 = x63;
} else {
}
} else {
}
}
} else {
}
const T3iii x74 = x15;
const int x73 = x36 + x14;
x7[x73] = x74;
}
}
T3iii x80 = x3;
const int x81 = x5 * 0;
const int x82 = x81 + x4;
const T3iii x83 = x7[x82];
const bool x84 = true; //x83 != null;
if (x84) {
x80 = x83;
} else {
}
const T3iii x88 = x80;
return x88;
}
/*****************************************
  End of C Generated Code
*******************************************/

int main() {

  T2ii matrices[] = {
    {1,2},{2,20},{20,2},{2,4},{4,2},{2,1},{1,7},{7,3}
  };

  T3iii res = testParse(matrices, 8);

  printf("(%d, %d, %d)\n", res.t1, res.t2, res.t3 );

}
