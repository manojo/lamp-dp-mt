#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void genSeq(char* seq, int size) {
	const char* map="nacgu_";
	for (int i=0;i<size;++i) seq[i]=map[random()%4+1];
}

int main(int argc, char** argv) {
	srandom(0x87654321);
	if (argc<3) { fprintf(stderr,"%s <size> <sequence_num>\n",argv[0]); exit(1); }
	int size = strtol(argv[1],NULL,10); if (size==0) { fprintf(stderr,"Bad size\n"); exit(1); }
	int off = strtol(argv[2],NULL,10);

	char* seq=(char*)malloc(size+1);
	int i; for (i=0;i<off;++i) genSeq(seq,size);
	genSeq(seq,size); seq[size]=0; printf("%s\n",seq);
	free(seq);
	return 0;
}
