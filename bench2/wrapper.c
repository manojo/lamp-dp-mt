#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>

#ifdef NU
#include "nu.h"
#else
#include "zu.h"
#endif

void genSeq(char* seq) {
	const char* map="nacgu_";
	for (int i=0;i<SIZE;++i) {
		seq[i]=random()%4+1;
		#ifdef NU
		seq[i]=map[(int)seq[i]];
		#endif
	}
}

int main(int argc, char** argv) {
	struct timeval ts, te;
	srandom(0x87654321);
	char* seq=(char*)malloc(SIZE);
	printf("sprintf('%%.3f',median(["); fflush(stdout);

	for (int i=0;i<LOOPS;++i) {
		genSeq(seq);
		my_init(seq,NULL);
		trace_t* trace=NULL;
		unsigned size=0;
		gettimeofday(&ts, NULL);
		my_solve();
		#ifdef BACKTRACK
		int res = my_backtrack(&trace, &size);
		#ifdef CHECK
		printf("\nResult = %d\n",res);
		#endif
		#endif
		gettimeofday(&te, NULL);
		my_free();
		free(trace);
		double last=(te.tv_sec-ts.tv_sec)*1000.0+(te.tv_usec-ts.tv_usec)/1000.0;
		printf("%7.2f ",last); fflush(stdout);
	}
	printf(" ])) %% ");
	#ifdef NU
	printf("Nussinov");
	#else
	printf("Zuker");
	#endif
	#ifdef CUDA
	printf("-CUDA");
	#else
	printf("-CPU");
	#endif
	#ifdef BACKTRACK
	printf("-BT");
	#else
	printf("-plain");
	#endif
	printf("-%d, %d samples\n",SIZE,LOOPS);
	free(seq);
	return 0;
}
