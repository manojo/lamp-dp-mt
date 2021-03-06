/*****************************************
  Emitting C Generated Code
*******************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
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
const int x16 = x9 + x12;
T3iii x19 = x3;
const int x20 = x12 + 1;
const bool x21 = x20 == x16;
if (x21) {
const T3iii x29 = x19;
const int x31 = x29.t2;
const bool x33 = x31 < 0;
T3iii x34;
if (x33) {
x34 = x29;
} else {
const T2ii x22 = x2[x12];
const int x26 = x22.t1;
const int x27 = x22.t2;
const T3iii x28 = (T3iii){x26,0,x27};
x34 = x28;
}
x19 = x34;
} else {
}
const int x23 = x16 - 1;
const int x24 = x23 + 1;
const bool x25 = x20 < x24;
const int x40 = x5 * x12;
if (x25) {
for(int x39=x20; x39 < x24; x39++) {
const int x41 = x40 + x39;
const T3iii x42 = x7[x41];
const int x43 = x5 * x39;
const int x44 = x43 + x16;
const T3iii x45 = x7[x44];
const T2TT x46 = (T2TT){x42,x45};
const T3iii x47 = x46.t1;
const T3iii x48 = x46.t2;
const int x49 = x47.t1;
const int x50 = x47.t2;
const int x51 = x47.t3;
const int x52 = x48.t1;
const int x53 = x48.t2;
const int x54 = x48.t3;
const T3iii x60 = x19;
const int x55 = x50 + x53;
const int x56 = x49 * x51;
const int x57 = x56 * x54;
const int x58 = x55 + x57;
const int x62 = x60.t2;
const bool x64 = x62 < x58;
T3iii x65;
if (x64) {
x65 = x60;
} else {
const T3iii x59 = (T3iii){x49,x58,x54};
x65 = x59;
}
x19 = x65;
}
} else {
}
const T3iii x72 = x19;
const int x71 = x40 + x16;
x7[x71] = x72;
}
}
T3iii x78 = x3;
const int x79 = x5 * 0;
const int x80 = x79 + x4;
const T3iii x81 = x7[x80];
x78 = x81;
const T3iii x83 = x78;
return x83;
}
/*****************************************
  End of C Generated Code
*******************************************/

int main() {

  T2ii matrices[] = {
    //{1,2},{2,20},{20,2},{2,4},{4,2},{2,1},{1,7},{7,3}
    {20,165},{165,91},{91,231},{231,121},{121,186},{186,253},{253,234},{234,130},{130,101},{101,154},{154,207},{207,44},{44,84},{84,169},{169,212},{212,191},{191,56},{56,46},{46,215},{215,12},{12,76},{76,119},{119,178},{178,184},{184,141},{141,66},{66,242},{242,233},{233,110},{110,196},{196,223},{223,208},{208,205},{205,72},{72,215},{215,38},{38,186},{186,23},{23,210},{210,180},{180,83},{83,116},{116,145},{145,212},{212,183},{183,127},{127,44},{44,166},{166,43},{43,178},{178,231},{231,154},{154,113},{113,17},{17,51},{51,193},{193,108},{108,18},{18,116},{116,187},{187,103},{103,159},{159,195},{195,117},{117,18},{18,138},{138,4},{4,97},{97,227},{227,26},{26,197},{197,173},{173,143},{143,157},{157,91},{91,40},{40,169},{169,20},{20,236},{236,250},{250,159},{159,248},{248,200},{200,248},{248,223},{223,151},{151,17},{17,34},{34,39},{39,248},{248,40},{40,160},{160,171},{171,117},{117,26},{26,36},{36,238},{238,241},{241,213},{213,150},{150,161},{161,4},{4,162},{162,48},{48,62},{62,205},{205,83},{83,196},{196,72},{72,164},{164,204},{204,248},{248,12},{12,180},{180,9},{9,239},{239,12},{12,208},{208,49},{49,113},{113,66},{66,45},{45,66},{66,177},{177,60},{60,248},{248,231},{231,134},{134,231},{231,194},{194,7},{7,211},{211,41},{41,153},{153,139},{139,106},{106,93},{93,20},{20,12},{12,249},{249,130},{130,61},{61,137},{137,57},{57,45},{45,82},{82,195},{195,202},{202,170},{170,100},{100,93},{93,43},{43,8},{8,186},{186,246},{246,177},{177,164},{164,219},{219,143},{143,176},{176,88},{88,46},{46,149},{149,164},{164,195},{195,148},{148,34},{34,152},{152,20},{20,212},{212,149},{149,229},{229,105},{105,149},{149,124},{124,223},{223,127},{127,39},{39,100},{100,29},{29,152},{152,161},{161,163},{163,138},{138,150},{150,148},{148,158},{158,85},{85,62},{62,240},{240,80},{80,210},{210,154},{154,179},{179,190},{190,217},{217,253},{253,16},{16,97},{97,73},{73,204},{204,195},{195,93},{93,68},{68,248},{248,56},{56,42},{42,237},{237,15},{15,27},{27,9},{9,230},{230,216},{216,47},{47,50},{50,31},{31,223},{223,41},{41,208},{208,48},{48,196},{196,86},{86,145},{145,166},{166,123},{123,230},{230,79},{79,84},{84,13},{13,34},{34,59},{59,35},{35,234},{234,39},{39,68},{68,188},{188,147},{147,237},{237,50},{50,61},{61,201},{201,41},{41,80},{80,97},{97,2},{2,132},{132,81},{81,206},{206,28},{28,242},{242,1},{1,108},{108,86},{86,155},{155,19},{19,46},{46,173},{173,7},{7,78},{78,238},{238,191},{191,73},{73,241},{241,149},{149,238},{238,141},{141,158},{158,160},{160,62},{62,181},{181,197},{197,143},{143,85},{85,147},{147,55},{55,139},{139,174},{174,130},{130,175},{175,15},{15,38},{38,29},{29,85},{85,78},{78,53},{53,73},{73,105},{105,155},{155,43},{43,41},{41,146},{146,179},{179,12},{12,54},{54,183},{183,113},{113,15},{15,88},{88,90},{90,48},{48,83},{83,61},{61,143},{143,123},{123,73},{73,154},{154,250},{250,139},{139,81},{81,105},{105,94},{94,118},{118,251},{251,239},{239,77},{77,106},{106,115},{115,204},{204,145},{145,71},{71,17},{17,252},{252,220},{220,49},{49,88},{88,174},{174,170},{170,194},{194,98},{98,203},{203,71},{71,128},{128,164},{164,218},{218,51},{51,35},{35,11},{11,62},{62,176},{176,37},{37,172},{172,151},{151,229},{229,52},{52,133},{133,77},{77,50},{50,225},{225,211},{211,148},{148,95},{95,192},{192,120},{120,95},{95,99},{99,228},{228,35},{35,86},{86,133},{133,105},{105,157},{157,107},{107,33},{33,98},{98,97},{97,121},{121,175},{175,121},{121,229},{229,62},{62,173},{173,135},{135,139},{139,61},{61,17},{17,234},{234,160},{160,252},{252,204},{204,184},{184,60},{60,229},{229,47},{47,60},{60,147},{147,181},{181,29},{29,156},{156,245},{245,241},{241,159},{159,197},{197,136},{136,41},{41,109},{109,178},{178,221},{221,240},{240,83},{83,130},{130,246},{246,52},{52,64},{64,137},{137,208},{208,124},{124,168},{168,187},{187,151},{151,186},{186,232},{232,6},{6,127},{127,203},{203,249},{249,119},{119,56},{56,113},{113,87},{87,180},{180,32},{32,211},{211,217},{217,219},{219,111},{111,73},{73,153},{153,240},{240,196},{196,108},{108,76},{76,89},{89,149},{149,69},{69,126},{126,123},{123,33},{33,221},{221,124},{124,46},{46,160},{160,65},{65,229},{229,83},{83,168},{168,220},{220,132},{132,224},{224,66},{66,15},{15,109},{109,177},{177,105},{105,151},{151,108},{108,84},{84,172},{172,248},{248,243},{243,216},{216,171},{171,139},{139,134},{134,243},{243,222},{222,181},{181,82},{82,110},{110,175},{175,207},{207,20},{20,82},{82,75},{75,181},{181,17},{17,23},{23,200},{200,126},{126,17},{17,2},{2,111},{111,58},{58,123},{123,86},{86,67},{67,178},{178,211},{211,125},{125,3},{3,187},{187,17},{17,59},{59,37},{37,144},{144,204},{204,109},{109,80},{80,93},{93,196},{196,249},{249,187},{187,178},{178,104},{104,148},{148,111},{111,89},{89,184},{184,26},{26,217},{217,7},{7,158},{158,4}
  };

  struct timeval ts, te;
  gettimeofday(&ts, NULL);

  T3iii res = testParse(matrices, 512);

  gettimeofday(&te, NULL);

  double last=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
  printf("Running time: %7.2fms\n",last);

  printf("(%d, %d, %d)\n", res.t1, res.t2, res.t3 );

}
