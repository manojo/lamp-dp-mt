#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// -----------------------------
// CUDA helpers
#define cuReset cudaDeviceReset()
#define cuDevSync cudaDeviceSynchronize()
#define cuErr(err) cuErr_(err,__FILE__,__LINE__)
__attribute__((unused)) static inline void cuErr_(cudaError_t err, const char *file, int line) { if (err==cudaSuccess) return;
    fprintf(stderr,"%s:%i CUDA error %d:%s\n", file, line, err, cudaGetErrorString(err)); cudaDeviceReset(); exit(EXIT_FAILURE);
}
#define cuMalloc(ptr,size) cuErr(cudaMalloc((void**)&ptr,size))
#define cuFree(ptr) cuErr(cudaFree(ptr))
#define cuPut(host,dev,size,stream) cuErr(cudaMemcpyAsync(dev,host,size,cudaMemcpyHostToDevice,stream))
#define cuGet(host,dev,size,stream) cuErr(cudaMemcpyAsync(host,dev,size,cudaMemcpyDeviceToHost,stream))
// -----------------------------

__device__ static char* g_seq = NULL;
__device__ static int g_len = 0;

#define my_len g_len
#define my_seq g_seq
#define my_P g_P
#define my_dev __device__
#include "../librna_impl.h"

// -----------------------------
// transfer helpers
static paramT *cg_P=NULL;
static char* cg_seq=NULL; // CPU pointers
__global__ static void _initP(paramT* params) { g_P=params; }
void initP() { paramT* P = get_scaled_parameters(); cuMalloc(cg_P,sizeof(paramT)); cuPut(P,cg_P,sizeof(paramT),NULL); _initP<<<1,1>>>(cg_P); free(P); }
void freeP() { cuFree(cg_P); }

__global__ static void _initSeq(char* seq, int len) { g_seq=seq; g_len=len; }
void initSeq(const char* str) {
  size_t i,len=strlen(str); char* seq=(char*)malloc((len+1)*sizeof(char));
  for (i=0;i<len;++i) switch(str[i]) {
    case 'a': seq[i]=1; break; case 'c': seq[i]=2; break; case 'g': seq[i]=3; break; case 'u': seq[i]=4; break;
    default: fprintf(stderr,"Bad character '%c' (%d) in the provided sequence.\n",str[i],str[i]); exit(1);
  }
  seq[len]=0; cuMalloc(cg_seq,len); cuPut(seq,cg_seq,len,NULL); _initSeq<<<1,1>>>(cg_seq,len); free(seq);
}
void freeSeq() { cuFree(cg_seq); }
// -----------------------------


// -----------------------------------------------------------------------------
// EXAMPLE APPLICATION
// -----------------------------------------------------------------------------

#include "../vienna/vienna.c"
#include "../vienna/energy_par.c"

__global__ void testKern(int* out) {


  printf("CPU Result = %d\n",
    ext_mismatch_energy(1,16) + termau_energy(1,16)
  );

  printf("GPU Result = %d\n",
    ext_mismatch_energy(0,17) + termau_energy(0,17) +
    sr_energy(1,16)
  );


	*out =
    ext_mismatch_energy(0, 9) + termau_energy(0,9) + // dlr(0,9)
    sr_energy(0,9) + // stack(0,9)
    sr_energy(1,8) + hl_energy(2,7); // hairpin (1,8)

}

int main() {
    read_parameter_file("../vienna/rna_turner2004.par");
    initP();
    initSeq("aacaaaccggguuuguu");

    // execution here
    int c;
    int *g;
    cuMalloc(g,sizeof(int));
    testKern<<<1,1>>>(g);
    cuGet(&c,g,sizeof(int),NULL);
    printf("Result = %d\n",c);

    cuFree(g);


    freeSeq();
    freeP();
    return 0;
}
