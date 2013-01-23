// Type: sequence alignment, complexity=O(n^2), splits=1
// Rule #0  'g2'     : id=7  alt=3  cat=0  min=0  max=-1
// Rule #1  'g1'     : id=4  alt=3  cat=0  min=0  max=-1
// Rule #2  'M'      : id=0  alt=4  cat=0  min=0  max=-1
typedef struct __bt0 bt0;
struct __bt0 { short rule; };
#define input_t char
typedef struct { int g2; int g1; int M; } cost_t;
typedef struct { bt0 g2; bt0 g1; bt0 M; } back_t;
#define MAX(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a>_b?_a:_b; })
typedef struct { short i,j,rule; } trace_t;
const unsigned trace_len[10] = {0,0,0,0,0,0,0,0,0,0};
void g_init(input_t* in1, input_t* in2);
void g_free();
void g_solve();
int g_backtrack(trace_t** trace, unsigned* size);
