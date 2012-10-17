// -----------------------------------------------------------------------------
#ifdef SH_RECT
// Smith-Waterman with arbitrary gap cost function (rectangular matrix).
// SWat(S,T); by convention, S is the longest string and put vertically
//   M[i,j] = max { 0                                 stop } = B[i,j]
//                { M[i-1,j-1]+cost(S[i],T[j])        NW   }
//                { max{1<=k<=j-1} M[i,j-k] - gap(k)  N(k) }
//                { max{1<=k<=i-1} M[i-k,j] - gap(k)  W(k) }
// Data types
#define TI char     // input data type
#define TI_CHR(X) X // conversion to char
#define TC int      // cost type
#define TB short    // backtrack type (2 bits for direction + 14 for value)
//#define TW int    // wavefront type (if not defined, no wavefront)
// Initialization
#define INIT(i,j)  ((i)==0 || (j)==0) // matrix initialization at [stop]
// Input
TI* p_input(bool horz=false) {
	static unsigned sh=time(NULL), sv=time(NULL)+573; // keep consistent
	const char alph[4]={'A','C','G','T'};
	unsigned n = horz?M_W:M_H; mseed(horz?sh:sv);
	TI* in = (TI*)malloc(n*sizeof(TI));
	for (unsigned i=0;i<n;++i) in[i]=alph[mrand()%4];
	return in;
}
// Helpers
_hostdev _inline TC p_gap(int k) { return 20-k; }
_hostdev _inline TC p_cost(char s, char t) { return s==t?1:0; }
#endif

// -----------------------------------------------------------------------------
#ifdef SH_TRI
// Matrix multiplication parenthesizing (triangular matrix)
//
//   M[i,j]= min {i<=k<j} M[i,k] + M [k+1,j] + r_i * c_k * c_j
//
// Data types
typedef struct { unsigned rows,cols; char print() { return 'X'; } } mat_t;
#define TI mat_t         // input data type
#define TI_CHR(X) ('0'+(X).rows) // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)
// Initialization
#define INIT(i,j) (j<=i) // matrix initialization at [stop]
// Input
TI* p_input() {
	static unsigned s=time(NULL); mseed(s); // keep consistent
	TI* in = (TI*)malloc(M_H*sizeof(TI));
	#define RNZ ({ unsigned x; do { x=mrand()%10; } while (!x); x; })
	in[0].rows=RNZ;
	for (unsigned i=1;i<M_H;++i) { in[i-1].cols=in[i].rows=RNZ; }
	in[M_H-1].cols=RNZ;
	return in;
}
#endif

// -----------------------------------------------------------------------------
#ifdef SH_PARA
// Polygon triangulation (parallelogram matrix).
//
//   M[i,j]= S(i,k) + max_{i<k<j} M[i,k]+M[k,j]
//
// Data types
#define TI char          // input data type
#define TI_CHR(X) (X)    // conversion to char (debug)
#define TC unsigned long // cost type
#define TB short         // backtrack type (2 bits for direction + 14 for value)
// Initialization
#define INIT(i,j) (i>=j) // matrix initialization at [stop]
// Input
TI* p_input() {
	const char* names="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	static const int n = strlen(names);
	TI* in = (TI*)malloc(M_H*sizeof(TI));
	for (unsigned i=0;i<M_H;++i) in[i]=names[i%n];
	return in;
}
_hostdev _inline TC p_cost(TI a, TI b) {
	static long s = time(NULL); // seed
	long n = ( s ^ (a ^ b) ) % 44927;
	n=n%23; if (n==0) n=1; return n;
}

// This is a requirement for the problem
ASSERT(M_W==M_H-1);
#endif
