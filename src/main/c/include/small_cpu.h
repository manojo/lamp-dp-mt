#define _infinity c=COST_MAX;
#ifdef SH_RECT
#define _ini(i) c_in[0][i]
#define _inj(j) c_in[1][j]
#endif
#ifdef SH_TRI
#define _in(i) c_in[0][i]
#endif
#ifdef SH_PARA
#define _in(i) c_in[0][i%M_H]
#endif

#define _cost(i,j) c_cost[idx(i,j)]
#define _max_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2>c) { c=c2; b=BACK; } }
#define _max(EXPR,BACK) c2=EXPR; if (c2>=c) { c=c2; b=BACK; }
#define _min_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2<c) { c=c2; b=BACK; } }
#define _min(EXPR,BACK) c2=EXPR; if (c2<=c) { c=c2; b=BACK; }

// -----------------------------------------------------------------------------

void c_solve() {
#ifdef SH_RECT
	for (unsigned i=0; i<M_H; ++i) {
		for (unsigned j=0; j<M_W; ++j) {
#endif
#ifdef SH_TRI
	for (unsigned ii=0; ii<M_H; ++ii) {
		unsigned i=M_H-1-ii;
		for (unsigned j=i; j<M_W; ++j) {
#endif
#ifdef SH_PARA
	for (unsigned jj=0; jj<M_W; ++jj) {
		for (unsigned i=0; i<M_H; ++i) {
			unsigned j=jj+i;
#endif
			TB b=BT_STOP; __attribute__((unused)) TC c=INIT_COST,c2; // stop
			if (!INIT(i,j)) { p_kernel }
			c_cost[idx(i,j)] = c;
			c_back[idx(i,j)] = b;
		}
	}
}

// -----------------------------------------------------------------------------

#undef _ini
#undef _inj
#undef _in
#undef _cost
#undef _max
#undef _min
#undef _max_loop
#undef _min_loop
#undef _infinity

// -----------------------------------------------------------------------------

#include <list>
#include <utility> // pair
// simply return the pair of indices (i,j) that are in the backtrack
TS c_backtrack(unsigned** bt, unsigned* size) {
	TS score;
	unsigned i,j;

#ifdef SH_RECT // SWat
	// Find the position with maximal cost along bottom+right borders
	unsigned mi=0; TS ci=0;
	unsigned mj=0; TS cj=0;
	for (unsigned i=0; i<M_H; ++i) { TS c=TS_MAP(c_cost[idx(i,M_W-1)]); if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TS c=TS_MAP(c_cost[idx(M_H-1,j)]); if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	score = TS_MAP(c_cost[idx(i,j)]);
	// Backtrack, returns a pair of coordinates in reverse order
	if (bt && size) {
		TB b;
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;
		do {
			track[0]=i; track[1]=j; track+=2; ++sz;
			b = c_back[idx(i,j)];
			switch(BT_D(b)) {
				case DIR_LEFT: j-=BT_V(b); break;
				case DIR_UP: i-=BT_V(b); break;
				case DIR_DIAG: i-=BT_V(b); j-=BT_V(b); break;
			}
		} while (b!=BT_STOP);
		*size=sz;
	}
#endif

#ifdef SH_TRI
	score = c_cost[idx(0,M_H-1)];
	if (bt && size) {
		// returns internal nodes of the binary tree whose leaves are on diagonal
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;

		std::list<std::pair<int,int> > queue;
		queue.push_back(std::make_pair(0,M_H-1)); // start in top+right corner

		while (!queue.empty()) {
			std::pair<int,int> p = queue.front(); queue.pop_front();
			i=p.first; j=p.second;
			track[0]=i; track[1]=j; track+=2; ++sz;

			TB k = c_back[idx(p.first,p.second)];
			if (k!=BT_STOP) {
				queue.push_back(std::make_pair(i,k));
				queue.push_back(std::make_pair(k+1,j));
			}
		}
		*size=sz;
	}
#endif

#ifdef SH_PARA
	i=0,j=M_W-1;
	score=c_cost[idx(i,j)];
	for (unsigned k=1;k<M_H;++k) { // find max along last diagonal
		TC c2=c_cost[idx(k,M_W-1+k)];
		if (c2>score) { score=c2; i=k; j=M_W-1+k; }
	}

	if (bt && size) {
		*bt=(unsigned*)malloc((M_H+M_W)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;

		std::list<std::pair<int,int> > queue;
		queue.push_back(std::make_pair(i,j));

		while (!queue.empty()) {
			std::pair<int,int> p = queue.front(); queue.pop_front();
			i=p.first; j=p.second;
			track[0]=i%M_H; track[1]=j%M_H; track+=2; ++sz;
			TB k = c_back[idx(i,j)];
			if (k!=BT_STOP) {
				if (k-i>1) queue.push_back(std::make_pair(i,k));
				if (j-k>1) queue.push_back(std::make_pair(k,j));
			}
		}

		*size=sz;
	}
#endif
	return score;
}
