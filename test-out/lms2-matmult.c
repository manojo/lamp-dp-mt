/*****************************************
  Emitting C Generated Code
*******************************************/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {int t1; int t2; int t3; } T3iii;
typedef struct {T3iii t1; T3iii t2; } T2TT;
typedef struct {int t1; int t2;} T2ii;

T3iii testParse(T2ii x2[]) {
const int x4 = 8;
const int x5 = x4 + 1;
const int x6 = x5 + 1;
const int x7 = x5 * x6;
const int x8 = x7 / 2;
T3iii x9[x8];
const T3iii x3 = (T3iii){0,10000,0};
for(int x11=0; x11 < x5; x11++) {
const int x12 = x5 - x11;
for(int x14=0; x14 < x12; x14++) {
T3iii x16 = x3;
const int x15 = x11 + x14;
const int x17 = x14 + 1;
const bool x18 = x17 == x15;
if (x18) {
const T3iii x26 = x16;
const int x28 = x26.t2;
const bool x30 = x28 < 0;
T3iii x31;
if (x30) {
x31 = x26;
} else {
const T2ii x19 = x2[x14];
const int x23 = x19.t1;
const int x24 = x19.t2;
const T3iii x25 = (T3iii){x23,0,x24};
x31 = x25;
}
x16 = x31;
} else {
}
const int x20 = x15 - 1;
const int x21 = x20 + 1;
const bool x22 = x17 < x21;
const int x37 = x6 + x14;
if (x22) {
for(int x36=x17; x36 < x21; x36++) {
const int x38 = x37 - x36;
const int x39 = x38 - 1;
const int x40 = x38 * x39;
const int x41 = x7 - x40;
const int x42 = x41 / 2;
const int x43 = x42 + x14;
const T3iii x44 = x9[x43];
const bool x45 = true ;// x44 != NULL;//null
if (x45) {
const int x46 = x6 + x36;
const int x47 = x46 - x15;
const int x48 = x47 - 1;
const int x49 = x47 * x48;
const int x50 = x7 - x49;
const int x51 = x50 / 2;
const int x52 = x51 + x36;
const T3iii x53 = x9[x52];
const bool x54 = true; //x53 != null;
if (x54) {
const T2TT x55 = (T2TT){x44,x53};
const T3iii x56 = x55.t1;
const T3iii x57 = x55.t2;
const int x58 = x56.t1;
const int x59 = x56.t2;
const int x60 = x56.t3;
const int x61 = x57.t1;
const int x62 = x57.t2;
const int x63 = x57.t3;
const T3iii x69 = x16;
const int x64 = x59 + x62;
const int x65 = x58 * x60;
const int x66 = x65 * x63;
const int x67 = x64 + x66;
const int x71 = x69.t2;
const bool x73 = x71 < x67;
T3iii x74;
if (x73) {
x74 = x69;
} else {
const T3iii x68 = (T3iii){x58,x67,x63};
x74 = x68;
}
x16 = x74;
} else {
}
} else {
}
}
} else {
}
const T3iii x90 = x16;
const int x84 = x37 - x15;
const int x85 = x84 - 1;
const int x86 = x84 * x85;
const int x87 = x7 - x86;
const int x88 = x87 / 2;
const int x89 = x88 + x14;
x9[x89] = x90;
}
}
T3iii x96 = x3;
const int x97 = x6 + 0;
const int x98 = x97 - x4;
const int x99 = x98 - 1;
const int x100 = x98 * x99;
const int x101 = x7 - x100;
const int x102 = x101 / 2;
const int x103 = x102 + 0;
const T3iii x104 = x9[x103];
const bool x105 = true; //x104 != null;
if (x105) {
x96 = x104;
} else {
}
const T3iii x109 = x96;
return x109;
}


int main(){

  T2ii matrices[] = {
    {1,2},{2,20},{20,2},{2,4},
    {4,2},{2,1},{1,7},{7,3}
  };

  T3iii res = testParse(matrices);

  printf("(%d, %d, %d) \n",res.t1, res.t2, res.t3);

};
/*****************************************
  End of C Generated Code
*******************************************/