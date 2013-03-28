#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int nussinov (int, char *);

int main () {
	char p[10000];
	int n;
	int e;
	while (1==scanf ("%9999s", &p)) { // only GNU C
		n = strlen(p);
		e = nussinov (n, p);
		printf ("%s %d\n", p, e);
		//free(p);
		//p=0;
	};
	return 0;
}

int nussinov (int n, char *p) {
	int l = n*n;
	int i;
	int j;
	int k;
	int at;
	int cur;
	int new;
	int *mat = calloc (l, sizeof(int));
	//  printf (">>> %d\n", n);
	for (i = n-1; i>=0; i--) for (j=i; j<n; j++) {
		at = i * (n-1) + j;
		if (i==j) { //empty
			cur = 0;
		}
		if (i<j) { //left
			new = mat[(i+1)*(n-1) + j];
			if (cur < new) cur = new;
		};
		if (i<j) { //right
			new = mat[i*(n-1) + j-1];
			if (cur < new) cur = new;
		};
		if (i<j) { //pair
			new = i+1>=j ? 0 : mat[(i+1)*(n-1) +j-1];
			switch (p[i]) {
				case 'C': new += p[j]=='G' ? 1 : -999999; break;
				case 'G': new += p[j]=='C' || p[j]=='U' ? 1 : -999999; break;
				case 'A': new += p[j]=='U' ? 1 : -999999; break;
				case 'U': new += p[j]=='A' || p[j]=='G' ? 1 : -999999; break;
				default:  new = -999999;
			};
			if (cur < new) cur = new;
		};
		for (k = i+1; k<j; k++) { //split
			new = mat[i*(n-1) + k] + mat[(k+1)*(n-1) + j];
			if (cur < new) cur = new;
		};
		mat[at] = cur;
		//    printf ("... i %d %c j %d %c : %d\n", i, p[i], j, p[j], cur);
	};
	free (mat);
	return cur;
}
