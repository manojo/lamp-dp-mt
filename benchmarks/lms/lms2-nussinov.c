/*****************************************
  Emitting C Generated Code
*******************************************/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int testParse(char x2[], const int x3) {
const int x4 = x3 + 1;
const int x5 = x4 * x4;
int x6[x5];
for(int x8=0; x8 < x4; x8++) {
const int x9 = x4 - x8;
for(int x11=0; x11 < x9; x11++) {
int x13 = 0;
const int x15 = x11 + 1;
const int x12 = x8 + x11;
const int x16 = x12 - 0;
const bool x17 = x16 <= x15;
int x18;
if (x17) {
x18 = x16;
} else {
x18 = x15;
}
const int x19 = x18 + 1;
const bool x20 = x15 < x19;
if (x20) {
for(int x57=x15; x57 < x19; x57++) {
const bool x58 = x15 == x57;
if (x58) {
const int x59 = x4 * x57;
const int x60 = x59 + x12;
const int x61 = x6[x60];
const int x63 = x13;
const bool x64 = x63 >= x61;
int x65;
if (x64) {
x65 = x63;
} else {
x65 = x61;
}
x13 = x65;
} else {
}
}
} else {
}
const int x21 = x11 + 0;
const int x22 = x12 - 1;
const bool x23 = x21 >= x22;
int x24;
if (x23) {
x24 = x21;
} else {
x24 = x22;
}
const int x25 = x22 + 1;
const bool x26 = x24 < x25;
const int x75 = x4 * x11;
if (x26) {
for(int x74=x24; x74 < x25; x74++) {
const int x76 = x75 + x74;
const int x77 = x6[x76];
const int x78 = x74 + 1;
const bool x79 = x78 == x12;
if (x79) {
const int x82 = x13;
const bool x83 = x82 >= x77;
int x84;
if (x83) {
x84 = x82;
} else {
x84 = x77;
}
x13 = x84;
} else {
}
}
} else {
}
const int x27 = x11 + 2;
const bool x28 = x27 > x12;
bool x50;
if (x28) {
x50 = false;
} else {
const char x29 = x2[x11];
const bool x31 = x29 == 'a';
const char x30 = x2[x22];
const bool x32 = x30 == 'u';
const bool x33 = x31 && x32;
const bool x34 = x29 == 'u';
const bool x35 = x30 == 'a';
const bool x36 = x34 && x35;
const bool x37 = x33 || x36;
const bool x38 = x29 == 'g';
const bool x39 = x38 && x32;
const bool x40 = x37 || x39;
const bool x41 = x30 == 'g';
const bool x42 = x34 && x41;
const bool x43 = x40 || x42;
const bool x44 = x29 == 'c';
const bool x45 = x44 && x41;
const bool x46 = x43 || x45;
const bool x47 = x30 == 'c';
const bool x48 = x38 && x47;
const bool x49 = x46 || x48;
x50 = x49;
}
if (x50) {
const bool x51 = x15 >= x22;
int x52;
if (x51) {
x52 = x15;
} else {
x52 = x22;
}
const bool x53 = x52 < x25;
if (x53) {
for(int x93=x52; x93 < x25; x93++) {
const int x94 = x93 - 0;
const bool x95 = x94 <= x15;
int x96;
if (x95) {
x96 = x94;
} else {
x96 = x15;
}
const int x97 = x96 + 1;
const bool x98 = x15 < x97;
if (x98) {
const int x106 = x93 + 1;
const bool x107 = x106 == x12;
for(int x100=x15; x100 < x97; x100++) {
const bool x101 = x15 == x100;
if (x101) {
const int x102 = x4 * x100;
const int x103 = x102 + x93;
const int x104 = x6[x103];
if (x107) {
const int x111 = x13;
const int x110 = x104 + 1;
const bool x112 = x111 >= x110;
int x113;
if (x112) {
x113 = x111;
} else {
x113 = x110;
}
x13 = x113;
} else {
}
} else {
}
}
} else {
}
}
} else {
}
} else {
}
const bool x54 = x15 < x25;
if (x54) {
for(int x130=x15; x130 < x25; x130++) {
const int x131 = x75 + x130;
const int x132 = x6[x131];
const int x133 = x4 * x130;
const int x134 = x133 + x12;
const int x135 = x6[x134];
const int x138 = x13;
const int x137 = x132 + x135;
const bool x139 = x138 >= x137;
int x140;
if (x139) {
x140 = x138;
} else {
x140 = x137;
}
x13 = x140;
}
} else {
}
const int x147 = x13;
const int x146 = x75 + x12;
x6[x146] = x147;
}
}
int x153 = 0;
const int x154 = x4 * 0;
const int x155 = x154 + x3;
const int x156 = x6[x155];
x153 = x156;
const int x158 = x153;
return x158;
}
/*****************************************
  End of C Generated Code
*******************************************/
#include <sys/time.h>
  int main() {

    char rna[] = {
      'a','c','g','u','a','c','g','u'
    };

    struct timeval ts, te;
    gettimeofday(&ts, NULL);

    int res = testParse(rna, 8);

    gettimeofday(&te, NULL);

    double last=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
    printf("Runnin time: %7.2fms [%7.2f,%7.2f], %d runs \n",last);


    printf("%d\n", res);

  }