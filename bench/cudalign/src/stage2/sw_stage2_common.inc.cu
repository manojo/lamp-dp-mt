#include "../common/cudalign.hpp"

// includes, project
#include <cutil_inline.h>


#define LOG(format, args...)  \
    printf( "%10.4f: ", cutGetTimerValue(timer)); \
    printf (format , ## args); \
    printf ("\n");  \
    cutilCheckError(cutResetTimer( timer )); \


#ifdef SW_NUCLEOTIDE
    typedef unsigned char letter_t;
#else
    typedef char* letter_t;
#endif


#define SW_BUS_FLUSH
#define FLUSH_STEP (2048/PHASE2_THREADS_COUNT)

typedef int2 bus_t;


typedef int cell_t;
typedef int2 cell2_t;
typedef int3 cell3_t;
typedef int4 cell4_t;


#define PRINT (0)

// TODO avaliar THREADS_COUNT
static __shared__   int  s_colx [2][PHASE2_THREADS_COUNT]; // Could be PHASE2_THREADS_COUNT-1
static __shared__   int  s_coly [2][PHASE2_THREADS_COUNT];

static texture<unsigned char, 1, cudaReadModeElementType> t_seq0;
static texture<unsigned char, 1, cudaReadModeElementType> t_seq1;
static texture<      bus_t, 1, cudaReadModeElementType> t_busH;

static __constant__ int d_split[PHASE2_BLOCKS_COUNT+1];








typedef struct {
	cell2_t* h_busOut;
	bus_t* h_busH;
	bus_t* h_busBase;
} host_structures_t;

typedef struct {
    unsigned char* d_seq0;
    unsigned char* d_seq1;
    bus_t* d_busH;
    cell4_t* d_busV1;
    cell4_t* d_busV2;
    cell3_t* d_busV3;
    bus_t *d_outV;
    int* d_out;
    bus_t *d_busBase;
    int4 *d_4out;
    int4 *d_match_out;
} cuda_structures_t;

static void allocHostStructures(Sequence* seq_vertical, Sequence* seq_horizontal, host_structures_t* host_structures) {
    const int seq0_len = seq_vertical->getLen();
    const int seq1_len = seq_horizontal->getLen();
    const int bus_size = seq1_len*sizeof(bus_t);
    const int busbase_size = seq0_len*sizeof(bus_t);

	host_structures->h_busH = (bus_t*)malloc(bus_size);
	host_structures->h_busOut = (cell2_t*)malloc(PHASE2_GRID_HEIGHT*ALPHA*sizeof(cell2_t));
	host_structures->h_busBase = (bus_t*)malloc(busbase_size);

	memset(host_structures->h_busOut, 0, PHASE2_GRID_HEIGHT*ALPHA*sizeof(cell2_t));
}

static void freeHostStructures(host_structures_t* host_structures) {
	free(host_structures->h_busH);
	free(host_structures->h_busOut);
	free(host_structures->h_busBase);
}

static void allocCudaStructures(Sequence* seq_vertical, Sequence* seq_horizontal,
        cuda_structures_t* cuda_structures) {
    const int seq0_len = seq_vertical->getLen();
    const int seq1_len = seq_horizontal->getLen();
    const int bus_size = seq1_len*sizeof(bus_t);
    const int busbase_size = seq0_len*sizeof(bus_t);

	cuda_structures->d_seq0 = allocCudaSeq(seq_vertical);
	cuda_structures->d_seq1 = allocCudaSeq(seq_horizontal);

    cutilSafeCall(cudaBindTexture(0, t_seq0, cuda_structures->d_seq0, seq0_len+PHASE2_GRID_HEIGHT));
    cutilSafeCall(cudaBindTexture(0, t_seq1, cuda_structures->d_seq1, seq1_len+PHASE2_GRID_HEIGHT));

    cuda_structures->d_busV1    = (cell4_t*)allocCuda0(PHASE2_GRID_HEIGHT*sizeof(cell4_t));
    cuda_structures->d_busV2    = (cell4_t*)allocCuda0(PHASE2_GRID_HEIGHT*sizeof(cell4_t));
    cuda_structures->d_busV3    = (cell3_t*)allocCuda0(PHASE2_GRID_HEIGHT*sizeof(cell3_t));
    cuda_structures->d_outV     =   (bus_t*)allocCuda0(busbase_size);
    cuda_structures->d_out      =     (int*)allocCuda0(sizeof(int));
    cuda_structures->d_busH     =   (bus_t*)allocCuda0(bus_size);
    cuda_structures->d_busBase  =   (bus_t*)allocCuda0((PHASE2_THREADS_COUNT*ALPHA+1)*sizeof(bus_t));
    cuda_structures->d_4out     =    (int4*)allocCuda0(PHASE2_BLOCKS_COUNT*sizeof(int4));
    cuda_structures->d_match_out =   (int4*)allocCuda0(ALPHA*sizeof(int4));
}

static void freeCudaStructures(cuda_structures_t* cuda) {
    cutilSafeCall(cudaFree(cuda->d_seq0));
    cutilSafeCall(cudaFree(cuda->d_seq1));
    cutilSafeCall(cudaUnbindTexture(t_seq1));
    cutilSafeCall(cudaUnbindTexture(t_seq0));
    cutilSafeCall(cudaFree(cuda->d_busV1));
    cutilSafeCall(cudaFree(cuda->d_busV2));
    cutilSafeCall(cudaFree(cuda->d_busV3));
    cutilSafeCall(cudaFree(cuda->d_outV));
    cutilSafeCall(cudaFree(cuda->d_out));
    cutilSafeCall(cudaFree(cuda->d_busH));
    cutilSafeCall(cudaFree(cuda->d_busBase));
    cutilSafeCall(cudaFree(cuda->d_4out));
    cutilSafeCall(cudaFree(cuda->d_match_out));

}

static void createSplitPositions(int j0, int xLen, int* h_split, int blocks) {
    for (int i = 0; i < blocks; i++) {
        int xMod = xLen % blocks;
        h_split[i] = j0 + ((xLen / blocks) * i + (xMod > i ? i : xMod));
    }
    h_split[blocks] = (j0+xLen) - 1;
}

static void printDebugMatch ( cuda_structures_t* cuda, int baseXr, int baseLen, int base0, int reverse, int i0r, int j0r, Sequence* seq_vertical, Sequence* seq_horizontal, int d, int blocks, int seq0_len, host_structures_t* host ) {
    cutilSafeCall ( cudaMemcpy ( host->h_busOut, cuda->d_outV + ( d - blocks ) * ALPHA*PHASE2_THREADS_COUNT, ALPHA * PHASE2_THREADS_COUNT * sizeof ( cell2_t ), cudaMemcpyDeviceToHost ) );

	printf ( "BUSOUT (%d %d %d):\n", j0r, ( d - blocks ) * ALPHA*PHASE2_THREADS_COUNT, PHASE2_THREADS_COUNT*ALPHA );
    for ( int i = 0; i < PHASE2_THREADS_COUNT * ALPHA; i++ ) {
        int my_i = i0r + ( i + ( d - blocks ) * PHASE2_THREADS_COUNT * ALPHA );
		int my_ir = baseLen - (my_i-base0) - 1;
        if ( my_i >= seq0_len ) break;

        int sum_match = host->h_busBase[my_ir-1].x + host->h_busOut[i].x;
        int sum_gap = host->h_busBase[my_ir-1].y + host->h_busOut[i].y + DNA_GAP_OPEN;

        printf ( "i:%8d(%8d) %.5s[%.1s]%.5s %.5s[%.1s]%.5s SW: %4d/%4d  BUS_H: (%4d/%4d)  SUM: %4d/%4d\n",
                 my_i, reverse? (seq0_len-my_i) : (my_i+1),
				 &seq_horizontal->forward_data[baseXr - 5], &seq_horizontal->forward_data[baseXr], &seq_horizontal->forward_data[baseXr + 1],
				 &seq_vertical->forward_data[my_i - 5], &seq_vertical->forward_data[my_i], &seq_vertical->forward_data[my_i +1],
                 host->h_busOut[i].x, host->h_busOut[i].y,
                 host->h_busBase[my_ir-1].x, host->h_busBase[my_ir-1].y,
                 sum_match, sum_gap );
    }

}




/**
 * Returns the maximum of two numbers.
 * @param a first value
 * @param b second value
 */
static __device__ int my_max(int a, int b) {
    return (a>b)?a:b;
}

static __device__ void kernel_load2(const int idx, const int bank, const int i, bus_t* busH, int *h, int *f, unsigned char *s) {
    *s = tex1Dfetch(t_seq1, i);
    if (idx) {
        *h = s_colx[bank][idx];
        *f = s_coly[bank][idx];
    } else {
        int2 temp = tex1Dfetch(t_busH,i);
        *h = temp.x;
        *f = temp.y;
    }
}

static __device__ void kernel_flush2(const int idx, const int bank, const int i, bus_t* busH, const int h, const int f) {
    if (idx == PHASE2_THREADS_COUNT-1) {
        int2 temp = make_int2(h, f);
        busH[i] = temp;
    } else {
        s_colx[bank][idx+1] = h;
        s_coly[bank][idx+1] = f;
    }
}

/**
 * After incrementing the column j, this procedure must be called to check if j overflows the limit of the sequence seq_1.
 * If this happens, we must set j to zero and continue the computation in the proper line and all registers must be
 * reinitialized in order to represent the first column of the matrix (only in this situation the output params will
 * be updated, otherwise the values will be kept).
 *
 * @param seq0_len size of the sequence seq0.
 * @param seq1_len size of the sequence seq1.
 * @param i [in/out] the row of the cell to be processed.
 * @param j [in/out] the column of the cell to be processed.
 * @param ss [in/out] the variable containing seq0[i] information. If DNA/RNA, ss is the nucleotide.
 *           otherwise ss is the substitution vector for aminoaciad seq0[i].
 * @param e00 [in/out] value of E(i,j-1)
 * @param h01 [in/out] value of H(i,j-1)
 * @param h11 [in/out] value of H(i-1,j-1)
 * @param jump [in/out] true if the line i, after update, is out of bound of seq_0.
 * @param H how many lines must be jumped if j overflows.
 */
//__device__ void kernel_check_bound2(int xLen, int j0, int *i, int *j, letter_t* ss, cell_t *e00, cell_t *h01, cell_t *h11, int *jump, int2* busOut, int2* busH, const int type_f, const int H) {
static __device__ void kernel_check_bound2(const int seq0_len, const int xLen, const int j0, const int i0, int *j, int *i,
        uchar4* ss, cell4_t *ee, cell_t *h10,  cell4_t *h00, int *jump, int2* busOut, const int type_f, const int H) {

    if (*j >= j0+xLen) {
        if (*i >= i0) {
            busOut[*i-i0].x = h00->x;
            busOut[*i-i0].y = ee->x;
            busOut[*i-i0+1].x = h00->y;
            busOut[*i-i0+1].y = ee->y;
            busOut[*i-i0+2].x = h00->z;
            busOut[*i-i0+2].y = ee->z;
            busOut[*i-i0+3].x = h00->w;
            busOut[*i-i0+3].y = ee->w;
        }
        *j=j0;
        *i+=H;
        *jump = (*i>=seq0_len); // TODO validar
        ee->x = -INF;
        ee->y = -INF;
        ee->z = -INF;
        ee->w = -INF;
        if (i0-*i == 0) {
            *h10 = (type_f==0?0:-INF);
        } else {
            *h10 = -(*i-i0)*DNA_GAP_EXT - DNA_GAP_OPEN*(type_f!=2);
        }
        h00->x = -(*i-i0+1)*DNA_GAP_EXT - DNA_GAP_OPEN*(type_f!=2);
        h00->y = -(*i-i0+2)*DNA_GAP_EXT - DNA_GAP_OPEN*(type_f!=2);
        h00->z = -(*i-i0+3)*DNA_GAP_EXT - DNA_GAP_OPEN*(type_f!=2);
        h00->w = -(*i-i0+4)*DNA_GAP_EXT - DNA_GAP_OPEN*(type_f!=2);

        // TODO violação i<0 !!!
        ss->x = tex1Dfetch(t_seq0,*i);
        ss->y = tex1Dfetch(t_seq0,*i+1);
        ss->z = tex1Dfetch(t_seq0,*i+2);
        ss->w = tex1Dfetch(t_seq0,*i+3);
    }
}



/**
 * This procedure makes the smith waterman computation for the cell (i,j).
 *
 * @param idx the Thread Id.
 * @param i line of the cell (0..|seq0|-1)
 * @param j column of the cell (0..|seq1|-1)
 * @param busH the last special row saved
 * @param ss the variable containing seq0[i] information. If DNA/RNA, ss is the nucleotide.
 *           otherwise ss is the substitution vector for aminoaciad seq0[i].
 * @param max the maximum score found until now.
 * @param pos the best score found for each block.
 * @param e00 Input: value of E(i,j-1). Output: value of E(i,j)
 * @param h01 Input: value of H(i,j-1). Output: value of H(i,j)
 * @param h11 Input: value of H(i-1,j-1)
 * @param h10 Output: value of H(i-1,j)
 * @param load index of s_col for read (s_col[load] is used for reading; s_col[1-load] is used for writing).
 */
template <bool CHECK_GOAL>
static __device__ void kernel_nw(unsigned char s1, const unsigned char ss, const int i, const int j, cell_t *e00, cell_t *f00, const cell_t h01, const cell_t h11, const cell_t h10, cell_t *h00, const int goal, int4* out) {

    *e00 = my_max(h01-DNA_GAP_FIRST, *e00-DNA_GAP_EXT);
    *f00 = my_max(h10-DNA_GAP_FIRST, *f00-DNA_GAP_EXT);
    int v1 = h11+((ss==s1)?DNA_MATCH:DNA_MISMATCH);
    *h00 = my_max(v1, my_max(*e00, *f00));

	if (CHECK_GOAL) {
    //#ifdef PHASE2_CHECK_GOAL
    if (*h00 == goal) {
        if (out->x == 0) {
            out->w = 0;
            out->z = 0;
            out->x = j;
            out->y = i;
        }
    }
    //#endif
	}
}

template <int THREADS, bool CHECK_GOAL>
static __global__ void kernel_nw_single_phase(const int i0, const int j0, const int baseX, const int seq0_len, const int seq1_len, const int goal, int4 *out, const int step,
        bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3, int2* busOut, int type_f)
{
    int idx = threadIdx.x;

    s_colx[0][idx] = s_colx[1][idx] = busV3[idx].x;
    s_coly[0][idx] = s_coly[1][idx] = busV3[idx].y;

    __syncthreads();

    const int xLen = baseX-j0; // exclusive baseY
    int by = step;
    int j_=xLen-idx;
	int i_=by*THREADS + idx - THREADS;
    i_ = i_*ALPHA;
    int j = j0+j_;
    int i = i0+i_;


    if (i < seq0_len) { // TODO estava i<seq0_len-1. Estava correto? já mudei.
        cell4_t h01=busV1[idx];
        cell4_t ee =busV2[idx];
        cell_t  h11=busV3[idx].z;

        // TODO otimizar retornando uchar4 = int
        uchar4 ss;

        ss.x = tex1Dfetch(t_seq0,i);
        ss.y = tex1Dfetch(t_seq0,i+1);
        ss.z = tex1Dfetch(t_seq0,i+2);
        ss.w = tex1Dfetch(t_seq0,i+3);

        __syncthreads();

        int jump = (i < i0);

        int _k = xLen;

        // TODO teste quando xlen é muito pequeno (i.e. xlen < NUM_THREADS)
        // REMOVER E VER SE GANHAMOS PERFORMANCE. CASO PERCA MUITO DESEMPENHO,
        // MELHOR TENTAR OUTRA ALTERNATIVA
        /*if (j_ <= 0) {
            _k+=1-j_;
        }*/

        if (_k&1) { // if odd
            cell4_t h00;
            cell_t h10;
            cell_t f00;

			kernel_check_bound2(seq0_len, xLen, j0, i0, &j, &i, &ss, &ee, &h11, &h01, &jump, busOut, type_f, THREADS*ALPHA);
            if (!jump) {
                unsigned char s1;

                kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, out);
                kernel_flush2(idx, 0, j, busH, h00.w, f00);

            }
            j++;
            __syncthreads();
            s_colx[1][idx] = s_colx[0][idx];
            s_coly[1][idx] = s_coly[0][idx];
            h11 = h10;
            h01 = h00;
            __syncthreads();
            _k--;
        }

        _k >>= 1;

        for (; _k; _k--) {
            cell4_t h00;
            cell_t h10;
            cell_t f00;

			kernel_check_bound2(seq0_len, xLen, j0, i0, &j, &i, &ss, &ee, &h11, &h01, &jump, busOut, type_f, THREADS*ALPHA); // TODO precisa?
            if (!jump) {
                unsigned char s1;
                kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, out);
                kernel_flush2(idx, 0, j, busH, h00.w, f00);
            }

            j++;
            __syncthreads();

			kernel_check_bound2(seq0_len, xLen, j0, i0, &j, &i, &ss, &ee, &h10, &h00, &jump, busOut, type_f, THREADS*ALPHA);// TODO precisa?
            if (!jump) {
                unsigned char s1;
                kernel_load2(idx, 0, j, busH, &h11, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i, j, &ee.x, &f00, h00.x, h10  , h11  , &h01.x, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h00.y, h00.x, h01.x, &h01.y, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h00.z, h00.y, h01.y, &h01.z, goal, out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h00.w, h00.z, h01.z, &h01.w, goal, out);
                kernel_flush2(idx, 1, j, busH, h01.w, f00);
            }

            j++;
            __syncthreads();
        }

        busV1[idx]=h01;
        busV2[idx]=ee;
        busV3[idx].x=s_colx[1][idx];
        busV3[idx].y=s_coly[1][idx];
        busV3[idx].z=h11;
    }
}

template <bool CHECK_GOAL>
static __global__ void kernel_nw_short_phase(const int i0, const int j0, const int baseX, const int seq0_len, const int seq1_len, const int goal, int4 *blockResult, const int step,
        bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3, int2* busOut, const int type_f)
{
    int bx = blockIdx.x;
    int by = step-bx;
    if (by < 0) return;

    int idx = threadIdx.x;

    //int i0_ = d_split[0];
    const int totalLen = baseX-j0; // exclusive baseY

    const volatile int x0 = d_split[bx]-j0;
    const int xLen = d_split[bx+1] - d_split[bx];

	int i_=(by*blockDim.x)+idx;
    int j_=x0-idx;
	int tidx = (i_ % (gridDim.x*blockDim.x));
    i_ = i_*ALPHA;
    if (j_<=0) {
        j_ += totalLen;
		i_ -= (gridDim.x*blockDim.x)*ALPHA;
    }
    int j = j0+j_;
    int i = i0+i_;

    s_colx[0][idx] = s_colx[1][idx] = busV3[tidx].x;
    s_coly[0][idx] = s_coly[1][idx] = busV3[tidx].y;
    __syncthreads();

    int4 out = make_int4(0,0,0,0);

    if (i < seq0_len) { // TODO estava i<seq0_len-1. Estava correto? já mudei.
        cell4_t h01=busV1[tidx];
        cell4_t ee =busV2[tidx];
        cell_t  h11=busV3[tidx].z;

        // TODO otimizar retornando uchar4 = int
        uchar4 ss;

        ss.x = tex1Dfetch(t_seq0,i);
        ss.y = tex1Dfetch(t_seq0,i+1);
        ss.z = tex1Dfetch(t_seq0,i+2);
        ss.w = tex1Dfetch(t_seq0,i+3);

        __syncthreads();

        int jump = (i < i0);
		int _k = blockDim.x >> 1;
        // We need N-1 Steps to complete the pending cells
        for (; _k>1; _k--) {
            cell4_t h00;
            cell_t h10;
            cell_t f00;
            kernel_check_bound2(seq0_len, totalLen, j0, i0, &j, &i, &ss, &ee, &h11, &h01, &jump, busOut, type_f, blockDim.x*gridDim.x*ALPHA);
            if (!jump) {
                unsigned char s1;
                kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, &out);
                kernel_flush2(idx, 0, j, busH, h00.w, f00);
            }

            j++;
            __syncthreads();

			kernel_check_bound2(seq0_len, totalLen, j0, i0, &j, &i, &ss, &ee, &h10, &h00, &jump, busOut, type_f, blockDim.x*gridDim.x*ALPHA);
            if (!jump) {
                unsigned char s1;
                kernel_load2(idx, 0, j, busH, &h11, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h00.x, h10  , h11  , &h01.x, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h00.y, h00.x, h01.x, &h01.y, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h00.z, h00.y, h01.y, &h01.z, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h00.w, h00.z, h01.z, &h01.w, goal, &out);
                kernel_flush2(idx, 1, j, busH, h01.w, f00);
            }

            j++;
            __syncthreads();
        }
        {
            cell4_t h00;
            cell_t h10;
            cell_t f00;
			kernel_check_bound2(seq0_len, totalLen, j0, i0, &j, &i, &ss, &ee, &h11, &h01, &jump, busOut, type_f, blockDim.x*gridDim.x*ALPHA);
            if (!jump) {
                unsigned char s1;
                kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
				kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, &out);
				kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, &out);
                kernel_flush2(idx, 0, j, busH, h00.w, f00);
            }

            j++;
            __syncthreads();

			kernel_check_bound2(seq0_len, totalLen, j0, i0, &j, &i, &ss, &ee, &h10, &h00, &jump, busOut, type_f, blockDim.x*gridDim.x*ALPHA);
            if (!jump) { // TODO pode remover esse jump?
                busV1[tidx]=h00;
                busV2[tidx]=ee;
                busV3[tidx].x=s_colx[0][idx];
                busV3[tidx].y=s_coly[0][idx];
                busV3[tidx].z=h10;
            }

        }
    }

    int out_idx = -1;
    if (out.x > 0) {
        out_idx = idx;
    }
    __syncthreads();
    if (out_idx == idx) {
        blockResult[blockIdx.x] = out;
    }
}


template <bool CHECK_GOAL>
static __global__ void kernel_nw_long_phase(const int i0, const int j0, const int baseX, const int seq0_len, const int seq1_len, const int goal, int4 *blockResult, const int step,
        bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3, int2* busOut, int type_f)
{
    int bx = blockIdx.x;
    int by = step-bx;
    if (by < 0) return;

    int idx = threadIdx.x;

    //const int totalLen = baseX-j0; // exclusive baseY

	const volatile int x0 = (d_split[bx]-j0) + (blockDim.x-1);
	const int xLen = d_split[bx+1] - d_split[bx] - (blockDim.x-1);

	int i_=(by*blockDim.x)+idx;
    int j_=x0-idx;
	int tidx = (i_ % (gridDim.x*blockDim.x));
    i_ = i_*ALPHA;
    /*if (i<=0) {
        i += totalLen;
        j -= N_GRID_HEIGHT*ALPHA;
    }*/
    int j = j0+j_;
    int i = i0+i_;

    s_colx[0][idx] = s_colx[1][idx] = busV3[tidx].x;
    s_coly[0][idx] = s_coly[1][idx] = busV3[tidx].y;
    __syncthreads();

    int4 out = make_int4(0,0,0,0);

    if (i < seq0_len) { // TODO estava i<seq0_len-1. Estava correto? já mudei.
        cell4_t h01=busV1[tidx];
        cell4_t ee =busV2[tidx];
        cell_t  h11=busV3[tidx].z;

        // TODO otimizar retornando uchar4 = int
        uchar4 ss;

        ss.x = tex1Dfetch(t_seq0,i);
        ss.y = tex1Dfetch(t_seq0,i+1);
        ss.z = tex1Dfetch(t_seq0,i+2);
        ss.w = tex1Dfetch(t_seq0,i+3);

        __syncthreads();

        int _k = xLen;

        if (_k&1) { // if odd
            cell4_t h00;
            cell_t h10;
            cell_t f00;

            unsigned char s1;

            kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
			kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, &out);
            kernel_flush2(idx, 0, j, busH, h00.w, f00);

            j++;
            __syncthreads();
            s_colx[1][idx] = s_colx[0][idx];
            s_coly[1][idx] = s_coly[0][idx];
            h11 = h10;
            h01 = h00;
            __syncthreads();
            _k--;
        }

        _k >>= 1;

        for (; _k; _k--) {
            cell4_t h00;
            cell_t h10;
            cell_t f00;

            unsigned char s1;
            kernel_load2(idx, 1, j, busH, &h10, &f00, &s1);
			kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, goal, &out);
            kernel_flush2(idx, 0, j, busH, h00.w, f00);

            j++;
            __syncthreads();

            kernel_load2(idx, 0, j, busH, &h11, &f00, &s1);
			kernel_nw<CHECK_GOAL>(s1, ss.x, i,   j, &ee.x, &f00, h00.x, h10  , h11  , &h01.x, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.y, i+1, j, &ee.y, &f00, h00.y, h00.x, h01.x, &h01.y, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.z, i+2, j, &ee.z, &f00, h00.z, h00.y, h01.y, &h01.z, goal, &out);
			kernel_nw<CHECK_GOAL>(s1, ss.w, i+3, j, &ee.w, &f00, h00.w, h00.z, h01.z, &h01.w, goal, &out);
            kernel_flush2(idx, 1, j, busH, h01.w, f00);

            j++;
            __syncthreads();
        }

        busV1[tidx]=h01;
        busV2[tidx]=ee;
        busV3[tidx].x=s_colx[1][idx];
        busV3[tidx].y=s_coly[1][idx];
        busV3[tidx].z=h11;
    }
    int out_idx = -1;
    if (out.x > 0) {
        out_idx = idx;
    }
    __syncthreads();
    if (out_idx == idx) {
        blockResult[blockIdx.x] = out;
    }
}



static __global__ void kernel_initialize_busH(bus_t* busH, int i0, int len, int type) {
    int tidx = blockIdx.x*blockDim.x + threadIdx.x;
    while (tidx <= len) {
		busH[i0+tidx].x = -(tidx+1)*DNA_GAP_EXT - DNA_GAP_OPEN*(type!=1);
        busH[i0+tidx].y = -INF;

		tidx += blockDim.x*gridDim.x;
    }
}

static __global__ void kernel_match(int seq0_len, int4* out, const int i0, const int goal, const int baseXr, bus_t* busBase, bus_t* busOut) {
    int idx = blockIdx.x*PHASE2_THREADS_COUNT + threadIdx.x;
    int ii=i0+idx+1;
    //int m=seq1_len-j0_-j;
    int m=PHASE2_THREADS_COUNT*ALPHA-idx;

    if (ii>=seq0_len) return; // TODO check this

    int sum_match = busBase[m].x + busOut[idx].x;
    int sum_gap = busBase[m].y + busOut[idx].y + DNA_GAP_OPEN;


    __shared__ int out_idx;
    out_idx = 0x7FFFFFFF;
    int4 local_out = make_int4(0,0,0,0);
    out[blockIdx.x] = local_out;
    __syncthreads();

    // TODO somente funciona se usar atomicMin(&out_idx, idx);
    // isso aparentemente se deve por causa da ocorrencia do type=2.
    // precisa ser provado!!! so tenho uma intuicao que esta certo


    if (sum_match > goal || sum_gap > goal) {
            local_out.w = busOut[idx].x;
            local_out.z = m;
            local_out.x = -1;
            local_out.y = sum_match;
            //atomicMin(&out_idx, idx);
            out_idx = idx;
    }
    else
    if (sum_gap == goal) {
            local_out.w = busBase[m].y + DNA_GAP_OPEN;
            local_out.z = 1;
            local_out.x = baseXr;
            local_out.y = ii;
            //atomicMin(&out_idx, idx);
            out_idx = idx;
    }
    else
    if (sum_match == goal) {
            local_out.w = busBase[m].x;
            local_out.z = 0;
            local_out.x = baseXr;
            local_out.y = ii;
            //atomicMin(&out_idx, idx);
            out_idx = idx;
   }

    __syncthreads();
    if (out_idx == idx) {
        out[blockIdx.x] = local_out;
    }
}

