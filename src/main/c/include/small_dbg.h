#ifndef TI_CHR
#define TI_CHR(X) ' '
#endif

// Pretty print the matrix(cost+backtrack) into the file descriptor
void dbg_print(bool gpu, FILE* f) {
	TI* in0 = c_in[0];
	TI* in1 = c_in[1];
	TB* back = c_back;
	TC* cost = c_cost;
	if (gpu) {
		in0=(TI*)malloc(sizeof(TI)*M_H);
		in1=(TI*)malloc(sizeof(TI)*M_W);
		back=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
		cost=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
		#ifdef __CUDACC__
		cuStream(stream);
		cuGet(in0,g_in[0],sizeof(TI)*M_H,stream);
		cuGet(in1,g_in[1],sizeof(TI)*M_W,stream);
		cuGet(back,g_back,sizeof(TB)*MEM_MATRIX,stream);
		cuGet(cost,g_cost,sizeof(TC)*MEM_MATRIX,stream);
		cuSync(stream);
		cuStrFree(stream);
		#endif
	}

	#if defined(SH_RECT)
		const char d[]={'#','|','-','\\'};
		#define PR_W M_W
		#define PR_BACK TB b = back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else if (BT_V(b)) fprintf(f," %c%-2d",d[BT_D(b)],BT_V(b)); else fprintf(f," %c  ",d[BT_D(b)]);
		#define PR_COST fprintf(f,"%4ld",(long)TS_MAP(cost[idx(i,j)]));
	#elif defined(SH_TRI)
		#define PR_W M_W
		#define PR_BACK if (i<=j) { TB b=back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else fprintf(f," _%-2d",b); } else fprintf(f,"    ");
		#define PR_COST if (i<=j) fprintf(f,"%4ld",(long)TS_MAP(cost[idx(i,j)])); else fprintf(f,"    ");
	#elif defined(SH_PARA)
		#define PR_W (2*M_W)
		#define PR_BACK if (i<=j && j<i+M_W) { TB b=back[idx(i,j)]; if (b==BT_STOP) fprintf(f," #  "); else fprintf(f," _%-2d",b); } else fprintf(f,"    ");
		#define PR_COST if (i<=j && j<i+M_W) fprintf(f,"%4ld",(long)cost[idx(i,j)]); else fprintf(f,"    ");
	#endif

	fprintf(f,"Matrix(%ldx%ld), blocks(%ldx%ld)\n",M_H,M_W,B_H,B_W);
	fprintf(f,"  |");
	// header
	for (size_t j=0;j<PR_W;++j) { fprintf(f," %c  ",TI_CHR(in1[j%M_W])); if (j%B_W==B_W-1) fprintf(f," |"); }
	fprintf(f,"\n");
	for (size_t i=0;i<=M_H;++i) {
		// spacer
		if (i%B_H==0) {
			fprintf(f,"--+");
			for (size_t j=0;j<PR_W;++j) { fprintf(f,"----"); if (j%B_W==B_W-1) fprintf(f,"-+"); }
			fprintf(f,"\n");
		}
		if (i==M_H) break;
		// content (backtrack)
		fprintf(f,"%c |",TI_CHR(in0[i]));
		for (size_t j=0;j<PR_W;++j) { PR_BACK if (j%B_W==B_W-1) fprintf(f," |"); }
		fprintf(f,"\n");
		// content (score)
		fprintf(f,"  |");
		for (size_t j=0;j<PR_W;++j) { PR_COST if (j%B_W==B_W-1) fprintf(f," |"); }
		fprintf(f,"\n");
	}

	if (gpu) { free(in0); free(in1); free(back); free(cost); }
}

// Backtrack the solved problem and pretty-print it
void dbg_track(bool gpu, FILE* f) {
	unsigned* bt;
	unsigned sz;
	TS score =
	#ifdef __CUDACC__
		gpu ? g_backtrack(&bt,&sz) :
	#endif
		c_backtrack(&bt,&sz);
	fprintf(f,"Backtrack with best score : %llu\n",(unsigned long long)score);
	if (sz) for (unsigned i=sz-1;;--i) {
		printf("(%d,%d) ",bt[i*2],bt[i*2+1]);
		if (!i) break;
	}
	printf("\n");
	free(bt);
}

// Checks that the CPU and GPU implementation return the same costs
// Note that backtrack may vary depending the ordering of paths selection
void dbg_compare() {
	double ttc=0,ttg=0; cuTimer t;
	// Matrix filling
#ifdef __CUDACC__
	TC* tc=(TC*)malloc(sizeof(TC)*MEM_MATRIX);
	TB* tb=(TB*)malloc(sizeof(TB)*MEM_MATRIX);
	cudaMemset(g_cost,0xff,sizeof(TC)*MEM_MATRIX);
	cudaMemset(g_back,0xff,sizeof(TB)*MEM_MATRIX);
	t.start();
	g_solve();
	ttg=t.stop();
	cuGet(tc,g_cost,sizeof(TC)*MEM_MATRIX,NULL);
	cuGet(tb,g_back,sizeof(TB)*MEM_MATRIX,NULL);
#endif
	t.start();
	c_solve();
	ttc=t.stop();
	fprintf(stderr,"- Matrix cpu(%.3f)/gpu(%.3f) : ",ttc/1000,ttg/1000);
	// Matrix content comparison
#ifdef __CUDACC__
	int err=0;
	#ifdef SH_RECT // some extra memory is needed, we want to ignore it
	for (int i=0;i<M_H;++i) for (int j=0;j<M_W;++j) { if (TS_MAP(tc[idx(i,j)])!=TS_MAP(c_cost[idx(i,j)])) ++err; }
	// for (int j=0;j<M_W;++j) { for (int i=0;i<M_H;++i) printf("%c",tc[idx(i,j)]!=c_cost[idx(i,j)]?'!':' '); printf("\n"); }
	#else
	for (unsigned i=0;i<MEM_MATRIX;++i) { if (TS_MAP(tc[i])!=TS_MAP(c_cost[i])) ++err; }
	#endif
	if (err==0) fprintf(stderr,"identical.\n"); else fprintf(stderr,"WARNING %d ERRORS !!\n",err);
	free(tc);
	free(tb);
#endif
	// Backtracking
	ttc=0; ttg=0;
	TS cost_c,cost_g;
	unsigned *bt,size;
	t.start(); cost_c=c_backtrack(&bt,&size); ttc=t.stop(); if (size&&bt) free(bt);
#ifdef __CUDACC__
	t.start(); cost_g=g_backtrack(&bt,&size); ttg=t.stop(); if (size&&bt) free(bt);
#else
	cost_g=cost_c;
#endif
	fprintf(stderr,"- Backtrack cpu(%.3f)/gpu(%.3f) : ",ttc/1000,ttg/1000);
	if (cost_c==cost_g) fprintf(stderr,"identical (%lld).\n",(long long)cost_c);
	else fprintf(stderr,"WARNING ERROR ( %lld != %lld ) !!\n",(long long)cost_c,(long long)cost_g);
}

// Initialize some structures
void dbg_init(bool info=false) {
	#ifdef __CUDACC__
	if (info) cuInfo();
	#endif
	fprintf(stderr,SH_SHAPE " %ldx%ld with block %ldx%ld and %d splits\n",M_H,M_W,B_H,B_H,SPLITS);
	TI* in0=p_input();
	TI* in1=NULL;
	#ifdef SH_RECT
	in1=p_input(true);
	#endif
	c_init(in0,in1);
	#ifdef __CUDACC__
	g_init(in0,in1);
	#endif
}

// Cleanup the initialized structures
void dbg_cleanup() {
	c_free();
	#ifdef __CUDACC__
	g_free();
	cudaDeviceReset();
	#endif
}

// -----------------------------------------------------------------------------
// Unused functions

#if 0
// Check the memory addressing / together with print
void dbg_checkmem() {
	// Memory mapping
	//for (int i=0;i<MEM_MATRIX;++i) { c_cost[i]=i; c_back[i]=BT_STOP; }
	// Swipe lines and columns numbers
	#define CHK(i0,in,j0,jn,x) for (unsigned i=i0;i<in;++i) for (unsigned j=j0;j<jn;++j) { c_cost[idx(i,j)]=x; c_back[idx(i,j)]=BT_STOP; } dbg_print(false,stdout);
	#ifdef SH_RECT
	CHK(0,M_H,0,M_W,i) CHK(0,M_H,0,M_W,j)
	#endif
	#ifdef SH_PARA
	CHK(0,M_H,i,i+M_W,i) CHK(0,M_H,i,i+M_W,j)
	#endif
	#ifdef SH_TRI
	CHK(0,M_H,i,M_W,i) CHK(0,M_H,i,M_W,j)
	#endif
}

// Get additional data to check correctness of printed solution
void dbg_print2() {
	#ifdef SH_TRI
		mat_t* in0=c_in[0];
		for (unsigned i=0; i<M_H; ++i) printf("%dx%d ",in0[i].rows,in0[i].cols); printf("\n");
	#endif
	#ifdef SH_PARA
		for (unsigned i=0;i<M_H;++i) {
			for (unsigned j=i+1;j<=i+M_W;++j) {
				printf("<%c-%c> = %2ld  ",c_in[0][i],c_in[0][j%M_H],p_cost(c_in[0][i],c_in[0][j%M_H]));
			}
			printf("\n");
		}
	#endif
}

#endif
