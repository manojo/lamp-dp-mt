#include "include/common.h"
//#define SH_RECT // memory+solve+backtrack seems OK
//#define SH_TRI // memory+solve+backtrack seems OK
#define SH_PARA // memory layout ok

// Problem dimensions
#define B_W 8LU    // block width
#define B_H 8LU    // block height
#define M_W 4LU  // matrix dimension
#define M_H 4LU  // matrix dimension

// -----------------------------------------------------------------------------
#include "include/ns_prob.h"
#include "include/ns.h" // must be included after problem definition
// -----------------------------------------------------------------------------

void c_solve() {
#ifdef SH_RECT
	for (unsigned i=0; i<M_H; ++i) {
		for (unsigned j=0; j<M_W; ++j) {
			TB b=BT_STOP; TC c=0,c2; // stop
			if (!INIT(i,j)) {
				for (unsigned k=1; k<i; ++k) { c2=c_cost[idx(i-k,j)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_UP,k); } }
				for (unsigned k=1; k<j; ++k) { c2=c_cost[idx(i,j-k)]-p_gap(k); if (c2>c) { c=c2; b=BT(DIR_LEFT,k); } }
				c2 = c_cost[idx(i-1,j-1)]+p_cost(c_in[0][i],c_in[1][j]); if (c2>=c) { c=c2; b=BT(DIR_DIAG,1); }
			}
			c_cost[idx(i,j)] = c;
			c_back[idx(i,j)] = b;
		}
	}
#endif
#ifdef SH_TRI
	// not sure we want to proceed by //gram-blocks or by diagonal
	for (unsigned ii=0; ii<M_H; ++ii) {
		unsigned i=M_H-1-ii;
		for (unsigned j=i; j<M_W; ++j) {
			TB b=BT_STOP; TC c=0,c2;  // stop
			if (!INIT(i,j)) {
				mat_t* in0=c_in[0];
				c = COST_MAX;
				for (unsigned k=i; k<j; ++k) {
					c2=c_cost[idx(i,k)] + c_cost[idx(k+1,j)] + in0[i].rows * in0[k].cols * in0[j].cols;
					if (c2<c) { c=c2; b=(TB)k; }
				}
				// printf("%d x %d x %d = %d - (%d + %d)\n",in0[i].rows, in0[b].cols, in0[j].cols,c,c_cost[idx(i,b)], c_cost[idx(b+1,j)]);
			}
			c_cost[idx(i,j)] = c;
			c_back[idx(i,j)] = b;
		}
	}
	mat_t* in0=c_in[0];
	for (unsigned i=0; i<M_H; ++i) printf("%dx%d ",in0[i].rows,in0[i].cols); printf("\n");
#endif
#ifdef SH_PARA
	for (unsigned jj=0; jj<M_W; ++jj) {
		for (unsigned i=0; i<M_H; ++i) {
			unsigned j=jj+i;
			TB b=BT_STOP; TC c=0,c2;  // stop
			if (!INIT(i,j)) {
				for (unsigned k=i+1;k<j;++k) {
					c2 = c_cost[idx(i,j)]=c_cost[idx(i,k)]+c_cost[idx(k,j)] + p_cost(c_in[0][i],c_in[0][k%M_H]); // mind the modulo
					if (c2>c) { c=c2; b=(TB)k; }
				}
			}
			c_cost[idx(i,j)] = c;
			c_back[idx(i,j)] = b;
		}
	}
#endif
}

#include <list>
#include <utility> // pair
// simply return the pair of indices (i,j) that are in the backtrack
TC c_backtrack(unsigned** bt, unsigned* size) {
	unsigned i,j;

#ifdef SH_RECT // SWat
	// Find the position with maximal cost
	unsigned mi=0; TC ci=0;
	unsigned mj=0; TC cj=0;
	for (unsigned i=0; i<M_H; ++i) { TC c=c_cost[idx(i,M_W-1)]; if (c>ci) { mi=i; ci=c; } }
	for (unsigned j=0; j<M_W; ++j) { TC c=c_cost[idx(M_H-1,j)]; if (c>cj) { mj=j; cj=c; } }
	if (ci>cj) { i=mi; j=M_W-1; } else { i=M_H-1; j=mj; }

	TC cost = c_cost[idx(i,j)];
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
	TC cost = c_cost[idx(0,M_H-1)];
	if (bt && size) {
		// returns internal nodes of the binary tree whose leaves are on diagonal
		*bt=(unsigned*)malloc((M_W+M_H)*2*sizeof(unsigned));
		unsigned sz=0;
		unsigned* track=*bt;

		std::list<std::pair<int,int> > queue;
		queue.push_back(std::make_pair(0,M_H-1));

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
	TC c2,cost=c_cost[idx(i,j)];
	for (unsigned k=1;k<M_H;++k) {
		c2=c_cost[idx(k,M_W-1+k)];
		if (c2>cost) { cost=c2; i=k; j=M_W-1+k; }
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
			track[0]=i; track[1]=j; track+=2; ++sz;

/*
			TB k = c_back[idx(p.first,p.second)];
			if (k!=BT_STOP) {
				queue.push_back(std::make_pair(i,k));
				queue.push_back(std::make_pair(k+1,j));
			}
*/
		}



		*size=sz;
	}
#endif
	return cost;
}

// -----------------------------------------------------------------------------

int main(int argc, char** argv) {
	cuTimer t;
	dbg_init();

	c_solve();

	for (unsigned i=0;i<M_H;++i) {
		for (unsigned j=0;j<M_W;++j) {
			printf("[%d-%d]=%2ld  ",i,j,p_cost(c_in[0][i],c_in[0][j]));
		}
		printf("\n");
	}

	dbg_print(false,stdout);
	dbg_track(false,stdout);

/*
	// CPU solving
	for (int i=0;i<2;++i) { t.start(); c_solve(); t.stop(); }
	printf("CPU solve: "); t.print(); printf("\n");

	// GPU solving
	// for (int i=0;i<2;++i) { t.start(); g_solve(); t.stop(); }
	// printf("GPU solve: "); t.print(); printf("\n");

	// dbg_compare();

*/
	dbg_cleanup();
	return 0;
}
