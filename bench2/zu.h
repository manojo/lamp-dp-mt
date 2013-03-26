// Type: sequence parser, complexity=O(n^3), splits=31
// Rule #0  'cl'     : id=0  alt=6  cat=2  min=7  max=-1
// Rule #1  'ml'     : id=6  alt=2  cat=1  min=14 max=-1
// Rule #2  'ml1'    : id=8  alt=4  cat=1  min=7  max=-1
// Rule #3  'st'     : id=12 alt=3  cat=1  min=0  max=-1
typedef struct __T2ii T2ii;
typedef struct __bt2 bt2;
typedef struct __bt1 bt1;
struct __T2ii { int _1; int _2; };
struct __bt2 { short rule; short pos[2]; };
struct __bt1 { short rule; short pos[1]; };
#define input_t char
typedef struct { int cl; int ml; int ml1; int st; } cost_t;
typedef struct { bt2 cl; bt1 ml; bt1 ml1; bt1 st; } back_t;
#define MAX(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a>_b?_a:_b; })
#define MIN(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a<_b?_a:_b; })
typedef struct { short i,j,rule; short pos[2]; } trace_t;
const unsigned trace_len[15] = {2,2,2,2,2,2,1,1,1,1,1,1,1,1,1};
void my_init(input_t* in1, input_t* in2);
void my_free();
void my_solve();
int my_backtrack(trace_t** trace, unsigned* size);
