#ifndef BACKTRACK
// BACKTRACK MANUALLY REMOVED
      // ---- s[i,j] ----
      {
        int _c0 = -1000;
        if (i==j) {
          int _c=fun0(); if (_c>_c0) _c0=_c;
        }
        if (i+1<=j) {
          int _c=fun1(_in1[i],cost[idx(i+1,j)].s); if (_c>_c0) _c0=_c;
        }
        if (i+1<=j) {
          int _c=fun2(cost[idx(i,j-1)].s,_in1[j-1]); if (_c>_c0) _c0=_c;
        }
        if (fun4(i,j) && i+2<=j) {
          int _c=fun3(_in1[i],cost[idx(i+1,j-1)].s,_in1[j-1]); if (_c>_c0) _c0=_c;
        }
        _unroll for(int k=i+1; k<j; ++k) {
          int _c=fun5(cost[idx(i,k)].s,cost[idx(k,j)].s); if (_c>_c0) _c0=_c;
        }
        cost[idx(i,j)].s = _c0;
      }
#else
      // ---- s[i,j] ----
      {
        bt1 _b0 = {-1,{0}};
        int _c0 = -1000;
        if (i==j) {
          { int _c=fun0(); if (_c>_c0) { _c0=_c; _b0=(bt1){0}; } }
        }
        if (i+1<=j) {
          { int _c=fun1(_in1[i],cost[idx(i+1,j)].s); if (_c>_c0) { _c0=_c; _b0=(bt1){1}; } }
        }
        if (i+1<=j) {
          { int _c=fun2(cost[idx(i,j-1)].s,_in1[j-1]); if (_c>_c0) { _c0=_c; _b0=(bt1){2}; } }
        }
        if (fun4(i,j) && i+2<=j) {
          { int _c=fun3(_in1[i],cost[idx(i+1,j-1)].s,_in1[j-1]); if (_c>_c0) { _c0=_c; _b0=(bt1){3}; } }
        }
        _unroll for(int k=i+1; k<j; ++k) {
          { int _c=fun5(cost[idx(i,k)].s,cost[idx(k,j)].s); if (_c>_c0) { _c0=_c; _b0=(bt1){4,{k}}; } }
        }
        cost[idx(i,j)].s = _c0;
        back[idx(i,j)].s = _b0;
      }
#endif
