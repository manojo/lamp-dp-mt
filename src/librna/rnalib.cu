/* RNA energy library, CUDA wrapper for Vienna-Tables */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "vienna/vienna.h" // paramT

#define my_len g_len
#define my_seq g_seq
#define my_P g_P
#define my_dev __device__
#include "librna_impl.h"

// -----------------------------------------------------------------------------
// EXAMPLE APPLICATION
// -----------------------------------------------------------------------------

#include "vienna/vienna.c"
#include "vienna/energy_par.c"

// -----------------------------
#define cuReset cudaDeviceReset()
#define cuDevSync cudaDeviceSynchronize()
#define cuErr(err) cuErr_(err,__FILE__,__LINE__)
__attribute__((unused)) static inline void cuErr_(cudaError_t err, const char *file, int line) { if (err==cudaSuccess) return;
    fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); cudaDeviceReset(); exit(EXIT_FAILURE);
}
// Device memory
#define cuMalloc(ptr,size) cuErr(cudaMalloc((void**)&ptr,size))
#define cuFree(ptr) cuErr(cudaFree(ptr))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
// -----------------------------

static paramT *cg_P=NULL;
static char* cg_seq=NULL; // CPU pointers
__global__ void _initP(paramT* params) { g_P=params; }
void initP() { paramT* P = get_scaled_parameters(); cuMalloc(cg_P,sizeof(paramT)); cuPut(P,cg_P,sizeof(paramT),NULL); _initP<<<1,1>>>(cg_P); free(P); }
void freeP() { cuFree(cg_P); }

__global__ void _initSeq(char* seq, int len) { g_seq=seq; g_len=len; }
void initSeq(const char* str) {
  size_t i,len=strlen(str); char* seq=(char*)malloc((len+1)*sizeof(char));
  for (i=0;i<len;++i) switch(str[i]) {
    case 'a': seq[i]=1; break; case 'c': seq[i]=2; break; case 'g': seq[i]=3; break; case 'u': seq[i]=4; break;
    default: fprintf(stderr,"Bad character '%c' (%d) in the provided sequence.\n",str[i],str[i]); exit(1);
  }
  seq[len]=0; cuMalloc(cg_seq,len); cuPut(seq,cg_seq,len,NULL); _initSeq<<<1,1>>>(cg_seq,len); free(seq);
}
void freeSeq() { cuFree(cg_seq); }

int main() {
    read_parameter_file("vienna/rna_turner2004.par");
    initP();
    initSeq("guaugagaua");
    // execution here
    freeSeq();
    freeP();
    return 0;
}
