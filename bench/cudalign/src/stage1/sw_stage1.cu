#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include <sys/stat.h>
#include <sys/types.h>

#include "../common/cudalign.hpp"
#include "../common/buffer/Buffer.hpp"
#include "../common/buffer/FileBuffer.hpp"
#include "../common/buffer/SocketBuffer.hpp"

// includes, project
#include <cutil_inline.h>

#include <map>
using namespace std;

#define SW_BUS_FLUSH

typedef int2 bus_t;

typedef int cell_t;
typedef int2 cell2_t;
typedef int3 cell3_t;
typedef int4 cell4_t;


__shared__   int  s_colx [2][THREADS_COUNT]; // Could be THREADS_COUNT-1
__shared__   int  s_coly [2][THREADS_COUNT];

texture<unsigned int, 1, cudaReadModeElementType> t_seq0;
texture<unsigned char, 1, cudaReadModeElementType> t_seq1;
texture<        bus_t, 1, cudaReadModeElementType> t_busH;

__constant__ int d_split[BLOCKS_COUNT+1];

/**
 * Returns true only to the thread with the maximum value.
 *
 * @param idx the thread Id.
 * @param val the value that will be compared
 * @return true to the thread with the maximum value. False otherwise. If
 *              more than one thread has the maximum value, only one of them
 *              will return true.
 */
__device__ int findMax(int idx, int val) {
    __shared__ int s_max[THREADS_COUNT];
    __shared__ int s_idx;
    int count = THREADS_COUNT>>1;
    s_max[idx] = val;
    __syncthreads();

    while (count > 0) {
        if (idx < count) {
            if (s_max[idx] < s_max[idx+count]) {
                s_max[idx] = s_max[idx+count];
            }
        }
        count = count >> 1;
        __syncthreads();
    }
    if (s_max[0] == val) {
        s_idx = idx;
    }
    __syncthreads();
    return (s_idx == idx);
}

/**
 * Returns the maximum of two numbers.
 * @param a first value
 * @param b second value
 */
static __device__ int my_max(int a, int b) {
    return (a>b)?a:b;
}

static __device__ int my_max4(int a, int b, int c, int d) {
    return my_max(my_max(a,b), my_max(c,d));
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
__device__ void kernel_sw(unsigned char s1, const int idx, const int i, const int j, bus_t* busH, const unsigned char ss, int *max, int2 *pos, cell_t *e00, cell_t *f00, const cell_t h01, const cell_t h11, const cell_t h10, cell_t *h00, const int inc, const bool store) {

    *e00 = my_max(h01-DNA_GAP_OPEN, *e00)-DNA_GAP_EXT;
    *f00 = my_max(h10-DNA_GAP_OPEN, *f00)-DNA_GAP_EXT;
    int v1 = h11+((ss!=s1)?DNA_MISMATCH:DNA_MATCH);
    *h00 = my_max4(0, v1, *e00, *f00);

    if (*max < *h00) {
        *max = *h00;
        pos->x = j;
        if (store) {
            pos->y = i+inc;
        } else {
            pos->y = inc;
        }
    }
}

__device__ void kernel_load(const int idx, const int bank, const int j, bus_t* busH, int *h, int *f, unsigned char *s) {
    *s = tex1Dfetch(t_seq1, j);
    if (idx) {
        *h = s_colx[bank][idx];
        *f = s_coly[bank][idx];
    } else {
        int2 temp = tex1Dfetch(t_busH,j);
        *h = temp.x;
        *f = temp.y;
    }
}

__device__ void kernel_flush(const int idx, const int bank, const int j, bus_t* busH, const int h, const int f) {
    if (idx == THREADS_COUNT-1) {
        int2 temp = make_int2(h, f);
        busH[j] = temp;
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
template <bool LOAD_VERTICAL_BUS, bool STORE_VERTICAL_BUS>
__device__ void kernel_check_bound(int seq0_len, int seq1_len, int *i, int *j,
        uchar4* ss, cell4_t *ee, cell_t *h10,  cell4_t *h00, int *jump,
		const int4* busInH, const int4* busInE, int4* busOutH, int4* busOutE, const int idx,
        const int H) {
    if (*j>=seq1_len) {
		if (STORE_VERTICAL_BUS) {
            busOutH[idx] = *h00;
            busOutE[idx] = *ee;
		}

		*j=0;
        *i+=H;
        *jump = (*i>=seq0_len);

		if (LOAD_VERTICAL_BUS) {
			*h10 = busInH[idx].w;
			*h00 = busInH[idx+1];
			*ee = busInE[idx];
		} else {
			*ee=make_int4(0,0,0,0);
			*h00=make_int4(0,0,0,0);
			*h10=0;
		}


        /*
		*ee=make_int4(0,0,0,0);
        *h00=make_int4(0,0,0,0);
        *h10=0;*/


        unsigned int k = tex1Dfetch(t_seq0,(*i)>>2);
        ss->x = k&0xFF; k >>= 8;
        ss->y = k&0xFF; k >>= 8;
        ss->z = k&0xFF; k >>= 8;
        ss->w = k&0xFF;
    }
}



template <bool LOAD_VERTICAL_BUS, bool STORE_VERTICAL_BUS>
__launch_bounds__(THREADS_COUNT,MIN_BLOCKS_PER_SM)
__global__ void kernel_sw_short_phase(const int seq0_len, const int seq1_len, const int step, int3 *blockResult,
						bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3, const int4* busInH, const int4* busInE, int4* busOutH, int4* busOutE)
{

    int bx = blockIdx.x;
    int by = step-bx;
    if (by < 0) return;

    int idx = threadIdx.x;


    const volatile int x0 = d_split[bx];
    const int xLen = d_split[bx+1] - x0;

    int i=(by*THREADS_COUNT)+idx;
    int j=x0-idx;
    int tidx = (i % (blockDim.x*gridDim.x));
    i <<= 2;
    if (j<=0) {
        j += seq1_len;
        i -= (blockDim.x*gridDim.x)*ALPHA;
    }
    s_colx[0][idx] = s_colx[1][idx] = busV3[tidx].x; // TODO poderia ser pego de busV1[tidx].w. Certo?
    s_coly[0][idx] = s_coly[1][idx] = busV3[tidx].y;

    __syncthreads();

    int2 max_pos;
    max_pos.x = blockResult[blockIdx.x].x;
    max_pos.y = blockResult[blockIdx.x].y;
    int max = blockResult[blockIdx.x].z;

    if (i < seq0_len) {
        cell_t h11;
        cell4_t h01;
        cell4_t ee;
		h01=busV1[tidx];
		ee =busV2[tidx];
		h11=busV3[tidx].z;

        uchar4 ss;
        unsigned int k = tex1Dfetch(t_seq0,(i>>2));
        ss.x = k&0xFF; k >>= 8;
        ss.y = k&0xFF; k >>= 8;
        ss.z = k&0xFF; k >>= 8;
        ss.w = k&0xFF;

        __syncthreads();

        int jump = (i<0);

		// We need THREADS_COUNT-1 Steps to complete the pending cells
        int _k = THREADS_COUNT>>1;
        for (; _k>1; _k--) {
            cell4_t h00;
            cell_t h10;
            cell_t f00;

			kernel_check_bound<LOAD_VERTICAL_BUS, STORE_VERTICAL_BUS>(seq0_len, seq1_len, &i, &j, &ss, &ee, &h11, &h01, &jump, busInH, busInE, busOutH, busOutE, idx, blockDim.x*gridDim.x*4);
			if (!jump) {
                unsigned char s1;
                kernel_load(idx, 1, j, busH, &h10, &f00, &s1);
                kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, 0, true);
                kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, 1, true);
                kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, 2, true);
                kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, 3, true);
                kernel_flush(idx, 0, j, busH, h00.w, f00);
            }
            j++;
            __syncthreads();

			kernel_check_bound<LOAD_VERTICAL_BUS, STORE_VERTICAL_BUS>(seq0_len, seq1_len, &i, &j, &ss, &ee, &h10, &h00, &jump, busInH, busInE, busOutH, busOutE, idx, blockDim.x*gridDim.x*4);
			if (!jump) {
                unsigned char s1;
                kernel_load(idx, 0, j, busH, &h11, &f00, &s1);
                kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h00.x, h10  , h11  , &h01.x, 0, true);
                kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h00.y, h00.x, h01.x, &h01.y, 1, true);
                kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h00.z, h00.y, h01.y, &h01.z, 2, true);
                kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h00.w, h00.z, h01.z, &h01.w, 3, true);
                kernel_flush(idx, 1, j, busH, h01.w, f00);
            }
            j++;
            __syncthreads();
        }

        {
            cell4_t h00;
            cell_t h10;
            cell_t f00;

			kernel_check_bound<LOAD_VERTICAL_BUS, STORE_VERTICAL_BUS>(seq0_len, seq1_len, &i, &j, &ss, &ee, &h11, &h01, &jump, busInH, busInE, busOutH, busOutE, idx, blockDim.x*gridDim.x*4);
			if (!jump) {
                unsigned char s1;
                kernel_load(idx, 1, j, busH, &h10, &f00, &s1);
                kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, 0, true);
                kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, 1, true);
                kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, 2, true);
                kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, 3, true);
                kernel_flush(idx, 0, j, busH, h00.w, f00);
            }
            j++;
            __syncthreads();

			kernel_check_bound<LOAD_VERTICAL_BUS, STORE_VERTICAL_BUS>(seq0_len, seq1_len, &i, &j, &ss, &ee, &h10, &h00, &jump, busInH, busInE, busOutH, busOutE, idx, blockDim.x*gridDim.x*4);

			busV1[tidx]=h00;
			busV2[tidx]=ee;
			busV3[tidx].x=s_colx[0][idx];
			busV3[tidx].y=s_coly[0][idx];
			busV3[tidx].z=h10;
        }
    }

    if (findMax(idx, max)) {
        blockResult[blockIdx.x].x = max_pos.x;
        blockResult[blockIdx.x].y = max_pos.y;
        blockResult[blockIdx.x].z = max;
    }
}

__launch_bounds__(THREADS_COUNT,MIN_BLOCKS_PER_SM)
__global__ void kernel_sw_long_phase(const int seq0_len, const int seq1_len, const int step, int3 *blockResult,
        bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3)
{
    int bx = blockIdx.x;
    int by = step-bx;
    if (by < 0) return;

    int idx = threadIdx.x;


    const int x0 = d_split[bx]+(THREADS_COUNT-1);
    const int xLen = d_split[bx+1] - x0;

    int i=(by*THREADS_COUNT)+idx;
    int j=x0-idx;
    int tidx = (i % (blockDim.x*gridDim.x));
    i <<= 2;

    s_colx[0][idx] = s_colx[1][idx] = busV3[tidx].x;
    s_coly[0][idx] = s_coly[1][idx] = busV3[tidx].y;

    __syncthreads();

    int2 max_pos;
    max_pos.x = -1;//blockResult[blockIdx.x].x;
    max_pos.y = -1;//blockResult[blockIdx.x].y;
    int max = blockResult[blockIdx.x].z;
    if (i < seq0_len) {
        /*cell4_t h01=tex1Dfetch(t_busV1,tidx);
        cell4_t ee =tex1Dfetch(t_busV2,tidx);*/
        cell4_t h01=busV1[tidx];
        cell4_t ee =busV2[tidx];
        cell_t  h11=busV3[tidx].z;

        uchar4 ss;
        unsigned int k = tex1Dfetch(t_seq0,(i>>2));
        ss.x = k&0xFF; k >>= 8;
        ss.y = k&0xFF; k >>= 8;
        ss.z = k&0xFF; k >>= 8;
        ss.w = k&0xFF;

        int _k = xLen;
        if (_k&1) { // if odd
            cell4_t h00;
            cell_t h10;
            cell_t f00;

            unsigned char s1;
            kernel_load(idx, 1, j, busH, &h10, &f00, &s1);
            kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, 0, false);
            kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, 1, false);
            kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, 2, false);
            kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, 3, false);
            kernel_flush(idx, 0, j, busH, h00.w, f00);
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
            kernel_load(idx, 1, j, busH, &h10, &f00, &s1);
            kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, 0, false);
            kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, 1, false);
            kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, 2, false);
            kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, 3, false);
            kernel_flush(idx, 0, j, busH, h00.w, f00);
            j++;
            __syncthreads();

            //s1 = tex1Dfetch(t_seq1, j); // TODO QUE EH ISSO???? REPETIU
            kernel_load(idx, 0, j, busH, &h11, &f00, &s1);
            kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h00.x, h10  , h11  , &h01.x, 0, false);
            kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h00.y, h00.x, h01.x, &h01.y, 1, false);
            kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h00.z, h00.y, h01.y, &h01.z, 2, false);
            kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h00.w, h00.z, h01.z, &h01.w, 3, false);
            kernel_flush(idx, 1, j, busH, h01.w, f00);
            j++;
            __syncthreads();

        }
        busV1[tidx]=h01;
        busV2[tidx]=ee;
        busV3[tidx].x=s_colx[1][idx];
        busV3[tidx].y=s_coly[1][idx];
        busV3[tidx].z=h11;
    }

    if (findMax(idx, max)) {
        if (max_pos.x != -1) {
            blockResult[blockIdx.x].x = max_pos.x;
            blockResult[blockIdx.x].y = max_pos.y+i;
            blockResult[blockIdx.x].z = max;
        }
    }
}


template <bool LOAD_VERTICAL_BUS, bool STORE_VERTICAL_BUS>
__launch_bounds__(THREADS_COUNT,1)
__global__ void kernel_sw_single_phase(const int seq0_len, const int seq1_len, const int step, int3 *blockResult,
							 bus_t* busH, cell4_t* busV1, cell4_t* busV2, cell3_t* busV3, const int4* busInH, const int4* busInE, int4* busOutH, int4* busOutE)
{

    int idx = threadIdx.x;

    s_colx[0][idx] = s_colx[1][idx] = busV3[idx].x;
    s_coly[0][idx] = s_coly[1][idx] = busV3[idx].y;

    __syncthreads();

    const int xLen = seq1_len;
    int by = step;
    int j=-idx;
    int i=(by*THREADS_COUNT)+idx;
    i <<= 2;
    if (j<=0) {
        j+=seq1_len;
        i-=THREADS_COUNT*4;
    }

    int2 max_pos;
    max_pos.x = blockResult[0].x;
    max_pos.y = blockResult[0].y;
    int max = blockResult[0].z;
    if (i < seq0_len) {
        cell_t h11;
        cell4_t h01;
        cell4_t ee;

		h01=busV1[idx];
		ee =busV2[idx];
		h11=busV3[idx].z;

        uchar4 ss;
        unsigned int k = tex1Dfetch(t_seq0,(i>>2));
        ss.x = k&0xFF; k >>= 8;
        ss.y = k&0xFF; k >>= 8;
        ss.z = k&0xFF; k >>= 8;
        ss.w = k&0xFF;

        __syncthreads();

        int jump = (i<0);
        int _k = xLen;
        int index = 1;
        for (; _k; _k--) {
            cell4_t h00;
            cell_t h10;
            cell_t f00;
			kernel_check_bound<LOAD_VERTICAL_BUS, STORE_VERTICAL_BUS>(seq0_len, seq1_len, &i, &j, &ss, &ee, &h11, &h01, &jump, busInH, busInE, busOutH, busOutE, idx, THREADS_COUNT*4);
            if (!jump) {
                unsigned char s1;
                kernel_load(idx, index, j, busH, &h10, &f00, &s1);
                kernel_sw(s1, idx, i, j, busH, ss.x, &max, &max_pos, &ee.x, &f00, h01.x, h11  , h10  , &h00.x, 0, true);
                kernel_sw(s1, idx, i, j, busH, ss.y, &max, &max_pos, &ee.y, &f00, h01.y, h01.x, h00.x, &h00.y, 1, true);
                kernel_sw(s1, idx, i, j, busH, ss.z, &max, &max_pos, &ee.z, &f00, h01.z, h01.y, h00.y, &h00.z, 2, true);
                kernel_sw(s1, idx, i, j, busH, ss.w, &max, &max_pos, &ee.w, &f00, h01.w, h01.z, h00.z, &h00.w, 3, true);
                kernel_flush(idx, 1-index, j, busH, h00.w, f00);
            }
            index = 1-index;
            j++;
            h11 = h10;
            h01 = h00;
            __syncthreads();
        }
        busV1[idx]=h01;
        busV2[idx]=ee;
        busV3[idx].x=s_colx[index][idx];
        busV3[idx].y=s_coly[index][idx];
        busV3[idx].z=h11;
    }

    if (findMax(idx, max)) {
		blockResult[0].x = max_pos.x;
		blockResult[0].y = max_pos.y;
		blockResult[0].z = max;
    }
}

int3 find_best(int3 *d_blockResult, int size) {
    int3 result[BLOCKS_COUNT];
    cutilSafeCall(cudaMemcpy(&result, d_blockResult, sizeof(uint3)*size, cudaMemcpyDeviceToHost));
    int best = 0;
    if (size > 1) {
        for (int i=1; i< size; i++) {
            //printf("%2d ", result[i].z);
            if (result[best].z < result[i].z) {
                best = i;
            }
        }
        //printf("\n");
    }
    return result[best];
}

void init_score(const char* order_blosum, const char score_blosum[24][24], char out_score[32][32]) {
    memset(out_score, 0, sizeof(out_score));
    for (int i=0; order_blosum[i]; i++) {
        for (int j=0; order_blosum[j]; j++) {
            char c0 = order_blosum[i];
            char c1 = order_blosum[j];
            out_score[c0-'A'][c1-'A'] = score_blosum[i][j];
        }
    }
}

static void flush_bus(Job* job, int step, int baseY, int *h_split, bus_t* h_busH, bus_t* d_busH) {
    static map<int, SpecialRowWriter*> specialRows;

    if (job->flush_interval > 0) {
        for (int k=0; k<job->blocks && k<=step; k++) {
            int bx = k;
            const int x0 = h_split[bx];
            const int xLen = h_split[bx+1] - x0;
            int by = step-bx;
            int i=(by*THREADS_COUNT)*ALPHA;
            if (by % job->flush_interval == 0 && by>0 && i<job->seq[0].getLen()) {
                cudaStreamSynchronize(0);
                cutilSafeCall(cudaMemcpy(h_busH+x0, d_busH+x0, xLen*sizeof(cell2_t), cudaMemcpyDeviceToHost));
                cudaStreamSynchronize(0);

                if (bx==0) {
                    SpecialRowWriter* row = job->fopenNewSpecialRow(STAGE_1, i+baseY, 0);
                    specialRows[i+baseY] = row;
                    row->open();
                    //printf("Flush: %d\n", i+baseY);
                }
                specialRows[i+baseY]->write(&h_busH[x0], xLen);
                if (bx==job->blocks-1) {
                    SpecialRowWriter* row = specialRows[i+baseY];
                    specialRows.erase(i+baseY);
                    row->close();
                    delete row;
                }
            }
        }
    }
}




typedef struct {
	//cell2_t* h_busOut;
	bus_t* h_busH;
	//bus_t* h_busBase;
	int4* h_busOutH;
	int4* h_busOutE;
	int* h_busOut;
	int4* h_busInH;
	int4* h_busInE;
	int* h_busIn;
} host_structures_t;

static void allocHostStructures(Sequence* seq_vertical, Sequence* seq_horizontal, host_structures_t* host_structures) {
	const int seq0_len = seq_vertical->getLen();
	const int seq1_len = seq_horizontal->getLen();
	const int bus_size = seq1_len*sizeof(bus_t);

	host_structures->h_busH = (bus_t*)malloc(bus_size + sizeof(bus_t)); // extra padding for first read at openning
	host_structures->h_busOutH = (int4*)malloc(THREADS_COUNT*sizeof(int4));
	host_structures->h_busOutE = (int4*)malloc(THREADS_COUNT*sizeof(int4));
	host_structures->h_busOut = (int*)malloc(2*THREADS_COUNT*sizeof(int4));
	host_structures->h_busInH = (int4*)malloc((THREADS_COUNT + 1)*sizeof(int4));
	host_structures->h_busInE = (int4*)malloc((THREADS_COUNT + 1)*sizeof(int4));
	host_structures->h_busIn = (int*)malloc(2*(THREADS_COUNT+1)*sizeof(int4));
}

static void freeHostStructures(host_structures_t* host_structures) {
	free(host_structures->h_busH);
    free(host_structures->h_busIn);
    free(host_structures->h_busInH);
    free(host_structures->h_busInE);
    free(host_structures->h_busOut);
    free(host_structures->h_busOutH);
    free(host_structures->h_busOutE);
}


typedef struct {
	unsigned char* d_seq0;
	unsigned char* d_seq1;
	bus_t* d_busH;
	cell4_t* d_busV1;
	cell4_t* d_busV2;
	cell3_t* d_busV3;
	int3* d_blockResult;
	int4* d_busOutH;
	int4* d_busOutE;
	int4* d_busInH;
	int4* d_busInE;
} cuda_structures_t;

static void allocCudaStructures(Sequence* seq_vertical, Sequence* seq_horizontal,
						 cuda_structures_t* cuda_structures) {
	const int seq0_len = seq_vertical->getLen();
	const int seq1_len = seq_horizontal->getLen();
	const int bus_size = seq1_len*sizeof(bus_t);

	cuda_structures->d_seq0 = allocCudaSeq(seq_vertical);
	cuda_structures->d_seq1 = allocCudaSeq(seq_horizontal);

	cutilSafeCall(cudaBindTexture(0, t_seq0, cuda_structures->d_seq0, seq0_len+GRID_HEIGHT));
	cutilSafeCall(cudaBindTexture(0, t_seq1, cuda_structures->d_seq1, seq1_len+GRID_HEIGHT));

	cuda_structures->d_busV1    = (cell4_t*)allocCuda0(GRID_HEIGHT*sizeof(cell4_t));
	cuda_structures->d_busV2    = (cell4_t*)allocCuda0(GRID_HEIGHT*sizeof(cell4_t));
	cuda_structures->d_busV3    = (cell3_t*)allocCuda0(GRID_HEIGHT*sizeof(cell3_t));
	cuda_structures->d_blockResult = (int3*)allocCuda0(BLOCKS_COUNT*sizeof(int3));
	cuda_structures->d_busH     =   (bus_t*)allocCuda0(bus_size);
	cuda_structures->d_busInH    = (int4*)allocCuda0((THREADS_COUNT+1)*sizeof(int4));
	cuda_structures->d_busInE    = (int4*)allocCuda0((THREADS_COUNT+1)*sizeof(int4));
	cuda_structures->d_busOutH    = (int4*)allocCuda0(THREADS_COUNT*sizeof(int4));
	cuda_structures->d_busOutE    = (int4*)allocCuda0(THREADS_COUNT*sizeof(int4));
}

static void freeCudaStructures(cuda_structures_t* cuda) {
	cutilSafeCall(cudaFree(cuda->d_seq0));
	cutilSafeCall(cudaFree(cuda->d_seq1));
	cutilSafeCall(cudaUnbindTexture(t_seq1));
	cutilSafeCall(cudaUnbindTexture(t_seq0));
	cutilSafeCall(cudaFree(cuda->d_busV1));
	cutilSafeCall(cudaFree(cuda->d_busV2));
	cutilSafeCall(cudaFree(cuda->d_busV3));
	cutilSafeCall(cudaFree(cuda->d_blockResult));
	cutilSafeCall(cudaFree(cuda->d_busH));
	cutilSafeCall(cudaFree(cuda->d_busInH));
	cutilSafeCall(cudaFree(cuda->d_busInE));
	cutilSafeCall(cudaFree(cuda->d_busOutH));
	cutilSafeCall(cudaFree(cuda->d_busOutE));
}



static void flush_column(Job* job, Buffer* buffer, int step, host_structures_t &host, cuda_structures_t &cuda) {
	if (buffer == NULL) return;
	int i = step*THREADS_COUNT;
	if (i >= 0) {
		int len = THREADS_COUNT;
		/*if ((i+len)*ALPHA > job->seq[0].getLen()) {
			len = (job->seq[0].getLen()+(ALPHA-1))/ALPHA - i;
		}*/
		if (len > 0) {
			cutilSafeCall(cudaMemcpy(host.h_busOutH, cuda.d_busOutH, len*sizeof(int4), cudaMemcpyDeviceToHost));
			cutilSafeCall(cudaMemcpy(host.h_busOutE, cuda.d_busOutE, len*sizeof(int4), cudaMemcpyDeviceToHost));
			//buffer->writeBuffer((char*)host.h_busOutH, sizeof(int4), len);
			for (int i=0; i<len; i++) {
				host.h_busOut[i*8] = host.h_busOutH[i].x;
				host.h_busOut[i*8+1] = host.h_busOutE[i].x;
				host.h_busOut[i*8+2] = host.h_busOutH[i].y;
				host.h_busOut[i*8+3] = host.h_busOutE[i].y;
				host.h_busOut[i*8+4] = host.h_busOutH[i].z;
				host.h_busOut[i*8+5] = host.h_busOutE[i].z;
				host.h_busOut[i*8+6] = host.h_busOutH[i].w;
				host.h_busOut[i*8+7] = host.h_busOutE[i].w;
			}
			buffer->writeBuffer((char*)host.h_busOut, sizeof(int), 8*len);
		}
	}
}

static void load_column(Job* job, Buffer* buffer, int step, host_structures_t &host, cuda_structures_t &cuda) {
    if (buffer == NULL) return;
    int i = step*THREADS_COUNT;
    int len = THREADS_COUNT;
    if ((i+len)*ALPHA > job->seq[0].getLen()) {
        len = 0;
        //len = (job->seq[0].getLen()+(ALPHA-1))/ALPHA - i;
    }
    if (len > 0) {
        if (step == 0) {
            host.h_busInH[0] = make_int4(0,0,0,0);
            host.h_busInE[0] = make_int4(0,0,0,0);
        } else {
            host.h_busInH[0] = host.h_busInH[THREADS_COUNT];
            host.h_busInE[0] = host.h_busInE[THREADS_COUNT];
        }
        int rc = buffer->readBuffer((char*)(host.h_busIn+8), sizeof(int), 8*len);
        for (int i=1; i<=len; i++) {
            host.h_busInH[i].x = host.h_busIn[i*8];
            host.h_busInE[i].x = host.h_busIn[i*8+1];
            host.h_busInH[i].y = host.h_busIn[i*8+2];
            host.h_busInE[i].y = host.h_busIn[i*8+3];
            host.h_busInH[i].z = host.h_busIn[i*8+4];
            host.h_busInE[i].z = host.h_busIn[i*8+5];
            host.h_busInH[i].w = host.h_busIn[i*8+6];
            host.h_busInE[i].w = host.h_busIn[i*8+7];
        }

        cutilSafeCall(cudaMemcpy(cuda.d_busInH, host.h_busInH, (len+1)*sizeof(int4), cudaMemcpyHostToDevice));
        cutilSafeCall(cudaMemcpy(cuda.d_busInE, host.h_busInE, (len+1)*sizeof(int4), cudaMemcpyHostToDevice));
    }
}


void processExternalDiagonal(Job* job, Sequence* seq_vertical, Sequence* seq_horizontal, int d, int baseY, bool smallAlgorithm, cuda_structures_t &cuda, host_structures_t &host, int* h_split, Buffer* readBuffer, Buffer* writeBuffer) {
	const int seq0_len = seq_vertical->getLen();
	const int seq1_len = seq_horizontal->getLen();
	static dim3 threads( THREADS_COUNT, 1, 1);
	static dim3 one(1, 1, 1);

	//bool output = 1;
	if (smallAlgorithm) {
		load_column(job, readBuffer, d, host, cuda);
		kernel_sw_single_phase<true, true><<< one, threads, 0>>>(seq0_len, seq1_len, d, cuda.d_blockResult, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_busInH, cuda.d_busInE, cuda.d_busOutH, cuda.d_busOutE);
		flush_column(job, writeBuffer, d-1, host, cuda);
	} else {
		load_column(job, readBuffer, d, host, cuda);

		dim3  grid( job->blocks, 1, 1);
		kernel_sw_short_phase<true, true><<< grid, threads, 0>>>(seq0_len, seq1_len, d, cuda.d_blockResult, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_busInH, cuda.d_busInE, cuda.d_busOutH, cuda.d_busOutE);

		#ifdef SW_BUS_FLUSH
		flush_bus(job, d, baseY, h_split, host.h_busH, cuda.d_busH);
		#endif

		flush_column(job, writeBuffer, d-job->blocks, host, cuda);

		kernel_sw_long_phase<<< grid, threads, 0>>>(seq0_len, seq1_len, d, cuda.d_blockResult, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3);
	}
	cutilCheckMsg("Kernel execution failed");
}

static void createSplitPositions(int j0, int xLen, int* h_split, int blocks) {
	for (int i = 0; i < blocks; i++) {
		int xMod = xLen % blocks;
		h_split[i] = j0 + ((xLen / blocks) * i + (xMod > i ? i : xMod));
	}
	h_split[blocks] = (j0+xLen) - 1;
}


void stage1(Job* job) {
	FILE* stats = job->fopenStatistics(STAGE_1);
	job->loadSpecialRows(STAGE_1);

	Sequence* seq_vertical = new Sequence(job->seq[0], false);
	Sequence* seq_horizontal = new Sequence(job->seq[1], false);

	int seq0_len = seq_vertical->getLen();
	int seq1_len = seq_horizontal->getLen();

	if (job->flush_limit > 0) {
		job->flush_interval = (seq0_len*8/(job->flush_limit/seq1_len))/(THREADS_COUNT*ALPHA)+1; // TODO constante no lugar de 8
		long long special_lines_count = (seq0_len/(THREADS_COUNT*ALPHA*job->flush_interval));
		fprintf(stats, "special lines: %lld\n", special_lines_count);
		fprintf(stats, "total size: %lld\n", special_lines_count*seq1_len*8LL);  // TODO 8
	} else {
		job->flush_interval = 0;
		job->flush_limit = 0;
	}
	fprintf(stats, "Flush Interval: %d\n", job->flush_interval);
	fprintf(stats, "Flush limit: %lld\n", job->flush_limit);

	fprintf(stats, "SW PARAM: %d/%d/%d/%d\n", DNA_MATCH, DNA_MISMATCH, DNA_GAP_FIRST, DNA_GAP_EXT);

	fprintf(stats, "--Alignment sequences:\n", job);
	fprintf(stats, ">%s (%d)\n", seq_vertical->name.c_str(), seq0_len);
	fprintf(stats, ">%s (%d)\n", seq_horizontal->name.c_str(), seq1_len);
	fflush(stats);

    cudaDeviceProp prop = selectGPU(job->gpu, stats);
    if (job->blocks <= 0) {
        job->blocks = prop.multiProcessorCount*8;
    }

	Timer timer2;

	cudaEvent_t ev_step = timer2.createEvent("STEP");
	cudaEvent_t ev_start = timer2.createEvent("START");
	cudaEvent_t ev_end = timer2.createEvent("END");
	cudaEvent_t ev_copy = timer2.createEvent("COPY");
	cudaEvent_t ev_alloc = timer2.createEvent("ALLOC");
	cudaEvent_t ev_kernel = timer2.createEvent("KERNEL");
	cudaEvent_t ev_writeback = timer2.createEvent("WRITEBACK");

	timer2.eventRecord(ev_start);

	printDevMem(stats);

	SpecialRowReader* lastSpecialRow = job->special_lines1->front();
	int baseY = lastSpecialRow->getRow();

	int baseX = 0;
	/*static SpecialRowWriter* specialColumn = job->fopenNewSpecialColumn(STAGE_1, 0, seq1_len);
	specialColumn->open();*/

	Buffer* writeColumn;
	writeColumn = job->loadBufferFromURL(job->flush_column_url);
	if (writeColumn != NULL) {
		writeColumn->autoFlush();
	}
	//writeColumn = new SocketBuffer("", 32111);
	//writeColumn.writeToFile("column.bin");
	//((SocketBuffer*)writeColumn)->writeToSocket();


	seq_vertical->trim(baseY+1, -1);


	host_structures_t host;
	cuda_structures_t cuda;
	allocHostStructures(seq_vertical, seq_horizontal, &host);
	allocCudaStructures(seq_vertical, seq_horizontal, &cuda); // todo retirar baseY

	const int bus_size = seq1_len*sizeof(bus_t);
	//bus_t* h_busH = (bus_t*)malloc(bus_size+sizeof(bus_t)); // extra padding for first read at openning
	if (baseY > 0)  {
		lastSpecialRow->open(host.h_busH, seq1_len); // TODO fazer leitura direta também, em vez de invertida
		int r = lastSpecialRow->read(host.h_busH, 0);
		printf("%d\n", r);
		lastSpecialRow->close();

		cutilSafeCall( cudaMemcpy(cuda.d_busH, host.h_busH, bus_size, cudaMemcpyHostToDevice));

		printf("Last checkpoint restored (%X)\n", baseY);
		// TODO TODO TODO FIXME restaurar valores de "bestValue" de todos os blocos, senão pode
		// ocorrer de perdermos o melhor score e o best_position.
	}

	timer2.eventRecord(ev_copy);
    cutilSafeCall(cudaBindTexture(0, t_busH, cuda.d_busH, bus_size));

	int h_split[BLOCKS_COUNT + 1];
	createSplitPositions ( 0, seq1_len+1, h_split, job->blocks );
	cutilSafeCall ( cudaMemcpyToSymbol ( d_split, h_split, sizeof ( h_split ) ) );

	timer2.eventRecord(ev_alloc);

    // execute the kernel
    //int3* d_blockResult = (int3*)allocCuda0(sizeof(int3)*BLOCKS_COUNT);
    int h=((seq0_len-baseY)/THREADS_COUNT/4+1);
    float total, left;
	job->cells_updates = ((long long)seq0_len)*seq1_len;
	float mcells = job->cells_updates/1000000.0f;
    int sum = 0;
    int steps;
    int smallAlgorithm;
    if (seq1_len < 2*job->blocks*THREADS_COUNT) {
        smallAlgorithm = 1;
        steps = h+1; // Precisa do +1?
        printf("SMALL\n");
    } else {
        smallAlgorithm = 0;
        steps = job->blocks+h+1; // Precisa do +1?
    }

    int3 best = make_int3(0,0,0);
    printf("START: %d steps\n", steps);
	FILE* statusFile = fopen("status.out", "wt");
	Buffer* readColumn = NULL;
	readColumn = job->loadBufferFromURL(job->load_column_url);
	if (readColumn != NULL) {
		readColumn->autoLoad();
	}
	/*readColumn = new SocketBuffer("localhost", 32111);
	((SocketBuffer*)readColumn)->readFromSocket();*/

	//readColumn.readFromFile("column.bin");
	for (int d=0; d<steps; d++) {
		//printf("PROGRESS: %d/%d\n", d, steps);
		bool output = (d==steps-1);

		processExternalDiagonal(job, seq_vertical, seq_horizontal, d, baseY, smallAlgorithm, cuda, host, h_split, readColumn, writeColumn);
		if (output) best = find_best(cuda.d_blockResult, smallAlgorithm ? 1:job->blocks);

		timer2.eventRecord(ev_step);
		cudaStreamSynchronize(0);

		if (timer2.intervalElapsed(2.0) || (d==steps-1)) {
			best = find_best(cuda.d_blockResult, smallAlgorithm ? 1:job->blocks);
			fprintf(statusFile, "%d,%d,%d,%d\n", 0, best.x, best.y, best.z);
			fflush(statusFile);

			float t = timer2.totalTime();
			int hour = (int)(t/3600);
			int min = (int)(t - hour*3600)/60;
			int sec = (int)(t - hour*3600 - min*60);
			fprintf(stderr, "(%dh%02dm%02ds) PROGRESS: %4d/%4d  best:(%d,%d,%d)\n",
					hour, min, sec, d+1, steps, best.x, best.y, best.z);

			output = true;
		}

		/*if (output) {
			total = timer2.totalTime();
			left = total*(((float)steps)/(d+1))-total;
			sum += d<BLOCKS_COUNT?(d+1):BLOCKS_COUNT;
			printf("STEP %05d/%05d: MCUPS: %5.0f (Elapsed: %2d:%02d  Left: %2d:%02d) ",
			d+1, steps, total>0?sum*mcells/(BLOCKS_COUNT*h)/total:0.0f,
			(int)(total/60), (int)(fmod(total,60)), (int)(left/60), (int)(fmod(left,60)));

			printf("MAX: %d (%d,%d)\n", best.z, best.y+1, best.x+1+baseY);
		} */

    }
	fclose(statusFile);
	if (readColumn != NULL) {
		delete readColumn;
		readColumn = NULL;
	}
	if (writeColumn != NULL) {
		delete writeColumn;
		writeColumn = NULL;
	}
	timer2.eventRecord(ev_kernel);

    // check if kernel execution generated and error
    cutilCheckMsg("Kernel execution failed");

	timer2.eventRecord(ev_end);

    cudaStreamSynchronize(0);

	fprintf(stats, "Best Score: %d\n", best.z);
	fprintf(stats, "Best Position: (%d,%d)\n", best.y+1+baseY, best.x+1);
	fprintf(stats, "CUDA times:\n");
	float diff = timer2.printStatistics(stats);

	fprintf(stats, "        total: %.4f\n", diff);
	fprintf(stats, "     Mi.Cells: %.4e\n", (float)job->cells_updates);
	fprintf(stats, "        MCUPS: %.4f\n", job->cells_updates/1000000.0f/(diff/1000.0f));

	printDevMem(stats);
	fprintf(stats, " FreeCudaStructures\n");
	freeCudaStructures(&cuda);
	freeHostStructures(&host);
	printDevMem(stats);

	MidpointsFile* midpointsFile = job->fopenMidpointsFile(0);
	midpointsFile->write(best.y+1+baseY, best.x+1, best.z, 0);
	midpointsFile->close();
    /*job->phase2_i0 = best.y+1;
    job->phase2_j0 = best.x+1+baseY;
    job->phase2_max = best.z;*/

	fclose(stats);
	cudaThreadExit();
	cutilCheckMsg("cudaThreadExit failed");
}
