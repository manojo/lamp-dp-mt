#ifndef BACKTRACK
// BACKTRACK MANUALLY REMOVED
      // ---- cl[i,j] ----
      {
        int _c0 = 999999;
        if (fun6(i,j)) {
          if (i+9<=j && VALID(i+1,j-1,cl)) {
            { int _c=fun0((i),cost[idx(i+1,j-1)].cl,(j-1)); if (_c<_c0) { _c0=_c; } }
          }
          if (i+7<=j) {
            { int _c=fun1((i),(i+1),(T2ii){i+2,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; } }
          }
          if (i+12<=j) _unroll for(int k=i+3,ku=MIN(j-9,i+32); k<=ku; ++k) {
            if (VALID(k,j-2,cl)) {
              { int _c=fun2((i),(i+1),(T2ii){i+2,k},cost[idx(k,j-2)].cl,(j-2),(j-1)); if (_c<_c0) { _c0=_c; } }
            }
          }
          if (i+12<=j) _unroll for(int k=MAX(i+9,j-32),ku=j-3; k<=ku; ++k) {
            if (VALID(i+2,k,cl)) {
              { int _c=fun3((i),(i+1),cost[idx(i+2,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; } }
            }
          }
          if (i+13<=j) for(int k=MAX(i+10,j-32),ku=j-3; k<=ku; ++k) {
            _unroll for(int l=i+3,lu=MIN(k-7,i+32); l<=lu; ++l) {
              if (VALID(l,k,cl)) {
                { int _c=fun4((i),(i+1),(T2ii){i+2,l},cost[idx(l,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; } }
              }
            }
          }
          if (i+18<=j && VALID(i+2,j-2,ml)) {
            { int _c=fun5((i),(i+1),cost[idx(i+2,j-2)].ml,(j-2),(j-1)); if (_c<_c0) { _c0=_c; } }
          }
        }
        cost[idx(i,j)].cl = _c0;
      }
      // ---- ml[i,j] ----
      {
        int _c0 = 999999;
        if (i+15<=j && VALID(i+1,j,ml)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml); if (_c<_c0) { _c0=_c; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_c0) { _c0=_c; } }
          }
        }
        cost[idx(i,j)].ml = _c0;
      }
      // ---- ml1[i,j] ----
      {
        int _c0 = 999999;
        if (i+8<=j && VALID(i+1,j,ml1)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml1); if (_c<_c0) { _c0=_c; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_c0) { _c0=_c; } }
          }
        }
        if (i+7<=j && VALID(i,j,cl)) {
          { int _c=fun9(fun8((i),cost[idx(i,j)].cl,(j))); if (_c<_c0) { _c0=_c; } }
        }
        _unroll for(int k=i+7; k<j; ++k) {
          if (VALID(i,k,cl)) {
            { int _c=fun11(fun9(fun8((i),cost[idx(i,k)].cl,(k))),(T2ii){k,j}); if (_c<_c0) { _c0=_c; } }
          }
        }
        cost[idx(i,j)].ml1 = _c0;
      }
      // ---- st[i,j] ----
      {
        int _c0 = 999999;
        if (fun14(i,j)) {
          if (i+1<=j) {
            { int _c=fun7((i),cost[idx(i+1,j)].st); if (_c<_c0) { _c0=_c; } }
          }
          _unroll for(int k=i+7; k<=j; ++k) {
            if (VALID(i,k,cl)) {
              { int _c=fun12(fun8((i),cost[idx(i,k)].cl,(k)),cost[idx(k,j)].st); if (_c<_c0) { _c0=_c; } }
            }
          }
          if (i==j) {
            { int _c=fun13(); if (_c<_c0) { _c0=_c; } }
          }
        }
        cost[idx(i,j)].st = _c0;
      }

// -----------------------------------------------------------------------------
#else
// -----------------------------------------------------------------------------
      // ---- cl[i,j] ----
      {
        bt2 _b0 = {-1,{0,0}};
        int _c0 = 999999;
        if (fun6(i,j)) {
          if (i+9<=j && VALID(i+1,j-1,cl)) {
            { int _c=fun0((i),cost[idx(i+1,j-1)].cl,(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){0}; } }
          }
          if (i+7<=j) {
            { int _c=fun1((i),(i+1),(T2ii){i+2,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){1}; } }
          }
          if (i+12<=j) _unroll for(int k=i+3,ku=MIN(j-9,i+32); k<=ku; ++k) {
            if (VALID(k,j-2,cl)) {
              { int _c=fun2((i),(i+1),(T2ii){i+2,k},cost[idx(k,j-2)].cl,(j-2),(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){2,{k}}; } }
            }
          }
          if (i+12<=j) _unroll for(int k=MAX(i+9,j-32),ku=j-3; k<=ku; ++k) {
            if (VALID(i+2,k,cl)) {
              { int _c=fun3((i),(i+1),cost[idx(i+2,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){3,{k}}; } }
            }
          }
          if (i+13<=j) for(int k=MAX(i+10,j-32),ku=j-3; k<=ku; ++k) {
            _unroll for(int l=i+3,lu=MIN(k-7,i+32); l<=lu; ++l) {
              if (VALID(l,k,cl)) {
                { int _c=fun4((i),(i+1),(T2ii){i+2,l},cost[idx(l,k)].cl,(T2ii){k,j-2},(j-2),(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){4,{l,k}}; } }
              }
            }
          }
          if (i+18<=j && VALID(i+2,j-2,ml)) {
            { int _c=fun5((i),(i+1),cost[idx(i+2,j-2)].ml,(j-2),(j-1)); if (_c<_c0) { _c0=_c; _b0=(bt2){5}; } }
          }
        }
        cost[idx(i,j)].cl = _c0;
        back[idx(i,j)].cl = _b0;
      }
      // ---- ml[i,j] ----
      {
        bt1 _b0 = {-1,{0}};
        int _c0 = 999999;
        if (i+15<=j && VALID(i+1,j,ml)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml); if (_c<_c0) { _c0=_c; _b0=(bt1){6}; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_c0) { _c0=_c; _b0=(bt1){7,{k}}; } }
          }
        }
        cost[idx(i,j)].ml = _c0;
        back[idx(i,j)].ml = _b0;
      }
      // ---- ml1[i,j] ----
      {
        bt1 _b0 = {-1,{0}};
        int _c0 = 999999;
        if (i+8<=j && VALID(i+1,j,ml1)) {
          { int _c=fun7((i),cost[idx(i+1,j)].ml1); if (_c<_c0) { _c0=_c; _b0=(bt1){8}; } }
        }
        _unroll for(int k=i+7,ku=j-7; k<=ku; ++k) {
          if (VALID(i,k,cl) && VALID(k,j,ml1)) {
            { int _c=fun10(fun9(fun8((i),cost[idx(i,k)].cl,(k))),cost[idx(k,j)].ml1); if (_c<_c0) { _c0=_c; _b0=(bt1){9,{k}}; } }
          }
        }
        if (i+7<=j && VALID(i,j,cl)) {
          { int _c=fun9(fun8((i),cost[idx(i,j)].cl,(j))); if (_c<_c0) { _c0=_c; _b0=(bt1){10}; } }
        }
        _unroll for(int k=i+7; k<j; ++k) {
          if (VALID(i,k,cl)) {
            { int _c=fun11(fun9(fun8((i),cost[idx(i,k)].cl,(k))),(T2ii){k,j}); if (_c<_c0) { _c0=_c; _b0=(bt1){11,{k}}; } }
          }
        }
        cost[idx(i,j)].ml1 = _c0;
        back[idx(i,j)].ml1 = _b0;
      }
      // ---- st[i,j] ----
      {
        bt1 _b0 = {-1,{0}};
        int _c0 = 999999;
        if (fun14(i,j)) {
          if (i+1<=j) {
            { int _c=fun7((i),cost[idx(i+1,j)].st); if (_c<_c0) { _c0=_c; _b0=(bt1){12}; } }
          }
          _unroll for(int k=i+7; k<=j; ++k) {
            if (VALID(i,k,cl)) {
              { int _c=fun12(fun8((i),cost[idx(i,k)].cl,(k)),cost[idx(k,j)].st); if (_c<_c0) { _c0=_c; _b0=(bt1){13,{k}}; } }
            }
          }
          if (i==j) {
            { int _c=fun13(); if (_c<_c0) { _c0=_c; _b0=(bt1){14}; } }
          }
        }
        cost[idx(i,j)].st = _c0;
        back[idx(i,j)].st = _b0;
      }
#endif
