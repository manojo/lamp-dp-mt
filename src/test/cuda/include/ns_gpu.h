#define _infinity c=COST_MAX;
#ifdef SH_RECT
#define _ini(i) in0[i]
#define _inj(j) in1[j]
#endif
#ifdef SH_TRI
#define _in(i) in0[i]
#endif
#ifdef SH_PARA
#define _in(i) in0[i%M_H]
#endif

#define _cost(i,j) cost[idx(i,j)]
#define _max_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2>c) { c=c2; b=BACK; } }
#define _max(EXPR,BACK) c2=EXPR; if (c2>=c) { c=c2; b=BACK; }
#define _min_loop(K,MIN,MAX,EXPR,BACK) for (unsigned K=MIN; K<MAX; ++K) { c2=EXPR; if (c2<c) { c=c2; b=BACK; } }
#define _min(EXPR,BACK) c2=EXPR; if (c2<=c) { c=c2; b=BACK; }

// -----------------------------------------------------------------------------

// XXX: fill with *.cu file content