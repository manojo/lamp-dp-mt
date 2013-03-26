// Type: sequence parser, complexity=O(n^3), splits=1
// Rule #0  's'      : id=0  alt=5  cat=1  min=0  max=-1
typedef struct __bt1 bt1;
struct __bt1 { short rule; short pos[1]; };
#define input_t char
typedef struct { int s; } cost_t;
typedef struct { bt1 s; } back_t;
#define MAX(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a>_b?_a:_b; })
#define MIN(a,b) ({__typeof__(a) _a=(a); __typeof__(b) _b=(b); _a<_b?_a:_b; })
typedef struct { short i,j,rule; short pos[1]; } trace_t;
const unsigned trace_len[5] = {1,1,1,1,1};
void my_init(input_t* in1, input_t* in2);
void my_free();
void my_solve();
int my_backtrack(trace_t** trace, unsigned* size);
