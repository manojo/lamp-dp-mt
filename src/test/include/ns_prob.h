// Kernel mini-language
// -----------------------------------------------------------------------------
// Variables: i, j, correspond to resp. row and column indices

// _ini(i)         access the vertical string at position i (SH_RECT)
// _inj(j)         access the horizontal string at position j (SH_RECT)
// _in(i)          access the string at position i (SH_TRI, SH_PARA)

// _cost(i,j)      return the cost at position (i,j)

// _infinity       sets the current cost to infinity
// _min(cost,back) take the min between current cost and (cost) with backtrack (back)
// _max(cost,back) take the max between current cost and (cost) with backtrack (back)

// _max_loop(k,min,max,cost,back)  compute the max over {min<=k<max} of (cost) with backtrack (back)
// _min_loop(k,min,max,cost,back)  compute the min over {min<=k<max} of (cost) with backtrack (back)

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
// Helpers functions
_hostdev _inline TC p_gap(int k) { return 20-k; }
_hostdev _inline TC p_cost(char s, char t) { return s==t?1:0; }
// Computation kernel
#define p_kernel \
	_max_loop(k,1,i,  _cost(i-k,j) - p_gap(k),                  BT(DIR_UP,k)   ) \
	_max_loop(k,1,j,  _cost(i,j-k) - p_gap(k),                  BT(DIR_LEFT,k) ) \
	_max(             _cost(i-1,j-1) + p_cost(_ini(i),_inj(j)), BT(DIR_DIAG,1) )

// for (unsigned k=1; k<i; ++k) { c2=c_cost[idx(i-k,j)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_UP,k); } }
// for (unsigned k=1; k<j; ++k) { c2=c_cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_LEFT,k); } }
// c2 = c_cost[idx(i-1,j-1)]+p_cost(c_in[0][i],c_in[1][j]); if (c2>=c) { c=c2; b=BT(DIR_DIAG,1); }

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
// Computation kernel
#define p_kernel \
	_infinity \
	_min_loop(k,i,j,  _cost(i,k) + _cost(k+1,j) + _in(i).rows * _in(k).cols * _in(j).cols, k )

// mat_t* in0=c_in[0];
// c = COST_MAX;
// for (unsigned k=i; k<j; ++k) {
// 	c2=c_cost[idx(i,k)] + c_cost[idx(k+1,j)] + in0[i].rows * in0[k].cols * in0[j].cols;
// 	if (c2<c) { c=c2; b=(TB)k; }
// }

#endif

// -----------------------------------------------------------------------------
#ifdef SH_PARA
// Polygon triangulation (parallelogram matrix).
//
//   M[i,j]= S(i,k) + max_{i<k<j} M[i,k]+M[k,j]
//
// This is a requirement for the problem
//ASSERT(M_W==M_H-1);
#undef M_W
#define M_W (M_H-1)
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
// Helpers functions
_hostdev _inline TC p_cost(TI a, TI b) { long s=0xdeadbeef; //time(NULL); // seed, warning with static for GPU
	long n = ( s ^ (a ^ b) ) % 44927; n=n%23; if (n==0) n=1; return n;
}
// Computation kernel
#define p_kernel \
	TC Cij = p_cost(_in(i),_in(j)); \
	_max_loop(k,i+1,j, _cost(i,k) + _cost(k,j) + Cij,  k  )

// TC Cij = p_cost(c_in[0][i],c_in[0][j%M_H]); // mind the modulo, we just want to pass (i,j) actually
// for (unsigned k=i+1;k<j;++k) {
// 	c2 = c_cost[idx(i,k)] + c_cost[idx(k,j)] + Cij;
// 	if (c2>c) { c=c2; b=(TB)k; }
// }

#endif
