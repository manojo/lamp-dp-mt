#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#include <pthread.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "../common/cudalign.hpp"

#include <cutil_inline.h>

#define H_MAX (2*64*1024)

#define NUM_THREADS 2

#define PRINT (0)


typedef struct {
    int partition0;
    int partition1;

    int h0[H_MAX];
    int e0[H_MAX];

    int h1[H_MAX];
    int e1[H_MAX];

    Job* job;
    /* OUT */
    midpoint_t *out_pos;
} split_args_t;

static midpoint_t split(Sequence *seq0, Sequence *seq1, int i0, int j0, int i1, int j1, 
						int type_s, int type_e, int score_s, int score_e,
						int *h0, int *h1, int *e0, int *e1);
static midpoint_t ort_split(Sequence *seq0, Sequence *seq1, int i0, int j0, int i1, int j1, 
						int type_s, int type_e, int score_s, int score_e,
						int *h0, int *h1, int *e0, int *e1);
												
static void *split_thread(void *thread_arg) {
    static int inv_type[] = {0,2,1};

    split_args_t* args = (split_args_t*)thread_arg;

    Job* job = args->job;

    int i0, j0, i1, j1, start_type, prev_type, start_score, prev_score;

    int partition_id = args->partition0;
    i1 = job->midpoints[partition_id].i;
    j1 = job->midpoints[partition_id].j;
    prev_type = job->midpoints[partition_id].type;
	prev_score = job->midpoints[partition_id].score;

    float last_percent = 0;
    for (int k=args->partition0+1; k<args->partition1; k++) {
        float percent = 100.0f*(k-args->partition0)/(args->partition1-args->partition0);
        if (percent > last_percent+1) {
            printf("Split: %5.1f (%6d/%6d)\n", percent , k, job->midpoints.size());
            last_percent = percent;
        }
        partition_id++;
        i0 = job->midpoints[k].i;
        j0 = job->midpoints[k].j;
        start_type = job->midpoints[k].type;
        start_score = job->midpoints[k].score;

        int delta_i = i1-i0;
        int delta_j = j1-j0;

        int inverse = (delta_i < delta_j);
        if (inverse) {
			if (j0 < j1-job->stage4_maximum_partition_size) {
				midpoint_t out_tmp;
                if ( job->stage4_orthogonal_execution ) {
                    out_tmp = ort_split ( &job->seq[1], &job->seq[0], j0, i0, j1, i1,
                                          inv_type[start_type], inv_type[prev_type], start_score, prev_score,
                                          args->h0, args->h1, args->e0, args->e1 );
                } else {
                    out_tmp = split ( &job->seq[1], &job->seq[0], j0, i0, j1, i1,
                                      inv_type[start_type], inv_type[prev_type], start_score, prev_score,
                                      args->h0, args->h1, args->e0, args->e1 );
                }
                /*midpoint_t out_tmp2 = ort_split(&job->seq[1], &job->seq[0], j0, i0, j1, i1, 
										   inv_type[start_type], inv_type[prev_type], start_score, prev_score,
										   args->h0, args->h1, args->e0, args->e1);
				if (out_tmp.i != out_tmp2.i || out_tmp.j != out_tmp2.j  || out_tmp.type != out_tmp2.type || out_tmp.score != out_tmp2.score) {
					fprintf(stderr, "WARN: %d %d %d %d   /    %d %d %d %d\n",
						out_tmp.i, out_tmp.j, out_tmp.type, out_tmp.score,
						out_tmp2.i, out_tmp2.j, out_tmp2.type, out_tmp2.score);
				}*/
				args->out_pos[k].i = out_tmp.j;
                args->out_pos[k].j = out_tmp.i;
                args->out_pos[k].type = inv_type[out_tmp.type];
                args->out_pos[k].score = out_tmp.score;
            } else {
                args->out_pos[k].type = -1;
            }
        } else {
			if (i0 < i1-job->stage4_maximum_partition_size) {
				midpoint_t out_tmp;
                if ( job->stage4_orthogonal_execution ) {
                    out_tmp = ort_split ( &job->seq[0], &job->seq[1], i0, j0, i1, j1,
                                          start_type, prev_type, start_score, prev_score,
                                          args->h0, args->h1, args->e0, args->e1 );
                } else {
                    out_tmp = split ( &job->seq[0], &job->seq[1], i0, j0, i1, j1,
                                          start_type, prev_type, start_score, prev_score,
                                          args->h0, args->h1, args->e0, args->e1 );
                }
                /*midpoint_t out_tmp2 = ort_split(&job->seq[0], &job->seq[1], i0, j0, i1, j1, 
										 start_type, prev_type, start_score, prev_score,
										 args->h0, args->h1, args->e0, args->e1);
				if (out_tmp.i != out_tmp2.i || out_tmp.j != out_tmp2.j  || out_tmp.type != out_tmp2.type || out_tmp.score != out_tmp2.score) {
					fprintf(stderr, "WARN: %d %d %d %d   /    %d %d %d %d\n",
						out_tmp.i, out_tmp.j, out_tmp.type, out_tmp.score,
						out_tmp2.i, out_tmp2.j, out_tmp2.type, out_tmp2.score);
				}*/
										 
				args->out_pos[k] = out_tmp;
            } else {
                args->out_pos[k].type = -1;
            }
        }

        prev_type = start_type;
		prev_score = start_score;
        i1 = i0;
        j1 = j0;
    }

    pthread_exit(NULL);
}

static void create_split_thread(split_args_t* args, pthread_t* pthread) {
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    int rc = pthread_create(pthread, &attr, split_thread, (void *)args);
    if (rc) {
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
    }
}


static midpoint_t ort_split(Sequence *seq0, Sequence *seq1, int i0, int j0, int i1, int j1, 
						int type_s, int type_e, int score_s, int score_e,
						int *h0, int *h1, int *e0, int *e1) {
	
	if (PRINT) printf("%d %d %d %d %d %d\n", i0, j0, i1, j1, type_s, type_e, score_s, score_e);
	
	int seq0_len = i1-i0;
	int seq1_len = j1-j0;
	
	if (seq1_len >= H_MAX) {
		fprintf(stderr, "Partition size is too large (%d > %d).\n", seq1_len, H_MAX);
		exit(1);
	}
	
	int mid = seq0_len/2;
	int mid0 = mid;
	int mid1 = seq0_len - mid;
	
	/* Forward */
	
	char* s0 = seq0->forward_data+(i0-1);
	char* s1 = seq1->forward_data+(j0-1);
	
	for (int j=1; j<=seq1_len; j++) {
		h0[j] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=2);
		e0[j] = -INF;
	}
	h0[0] = (type_s!=0)?-INF:0;
	e0[0] = (type_s!=1)?-INF:0;
	
	for (int i=1; i<=mid0; i++) {
		int h_tmp = h0[0];
		int h_next;
		h_next = h0[0] = e0[0] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=1);
		int f0 = -INF;
		const char s=s0[i];
		if (PRINT) printf("%2d/%2d ", h0[0], e0[0]);
		for (int j=1; j<=seq1_len; j++) {
			e0[j] = MAX(h0[j]-DNA_GAP_FIRST, e0[j]-DNA_GAP_EXT);
			f0 = MAX(h_next-DNA_GAP_FIRST, f0-DNA_GAP_EXT);
			h_next = MAX3(h_tmp+((s==s1[j])?DNA_MATCH:DNA_MISMATCH), e0[j], f0);
			h_tmp = h0[j];
			h0[j] = h_next;
			if (PRINT) printf("%2d/%2d ", h_next, e0[j]);
		}
		if (PRINT) printf("\n");
		//printf("FW: %d/%d\n", i, mid0);
	}
	
	
	if (PRINT) printf("---------\n");
	/* Reverse */
	
	
	
	//int diff = 	(score_e + (type_e == 1 ? DNA_GAP_OPEN : 0)) - (score_s + (type_s == 1 ? DNA_GAP_OPEN : 0));
	int diff = 	(score_e + (type_e == 0 ? 0 : DNA_GAP_OPEN)) - score_s;
	
	
	s0 = seq0->forward_data+(i1-1);
	s1 = seq1->forward_data+(j1-1);
	
	for (int i=1; i<=mid1; i++) {
		h1[i] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=1);
		e1[i] = -INF;
	}
	h1[0] = (type_e!=0)?-INF:0;
	e1[0] = (type_e!=2)?-INF:0;
	
	{
		int ff = -DNA_GAP_OPEN*(type_e!=1) - DNA_GAP_EXT*mid1;
		int hh = h1[mid1];
		if (PRINT) printf("%2d: %2d/%2d\n", (seq1_len-1) + j0, hh, ff);	
		
		int* _h0 = &h0[seq1_len];
		int* _e0 = &e0[seq1_len];
		
		int sum_match = _h0[0] + hh;
		int sum_gap = _e0[0] + ff + DNA_GAP_OPEN;
		
		if (sum_match == diff) {
			midpoint_t pt;
			pt.i = mid0+i0;
			pt.j = (seq1_len)+j0;
			pt.type = 0;
			pt.score = score_s + _h0[0];
			return pt;
		} else if (sum_gap == diff) {
			midpoint_t pt;
			pt.i = mid0+i0;
			pt.j = (seq1_len)+j0;
			pt.type = 1;
			pt.score = score_s + _e0[0];
			return pt;
		}
	}
	
	int* _h0 = &h0[seq1_len];
	int* _e0 = &e0[seq1_len];
	
	
	for (int j=1; j<=seq1_len; j++) {
		int h_tmp = h1[0];
		int h_next;
		h_next = h1[0] = e1[0] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=2);
		int f1 = -INF;
		const char s=s1[-(j-1)];
		if (PRINT) printf("%2d/%2d ", h1[0], e1[0]);
		for (int i=1; i<=mid1; i++) {
			e1[i] = MAX(h1[i]-DNA_GAP_FIRST, e1[i]-DNA_GAP_EXT);
			f1 = MAX(h_next-DNA_GAP_FIRST, f1-DNA_GAP_EXT);
			h_next = MAX3(h_tmp+((s==s0[-(i-1)])?DNA_MATCH:DNA_MISMATCH), e1[i], f1);
			h_tmp = h1[i];
			h1[i] = h_next;
			
			if (PRINT) printf("%2d/%2d ", h_next, e1[i]);
		}
		if (PRINT) printf("\n");
		
		int sum_match = _h0[-j] + h1[mid1];
		int sum_gap = _e0[-j] + f1 + DNA_GAP_OPEN;
		
		if (sum_match == diff) {
			midpoint_t pt;
			pt.i = mid0+i0;
			pt.j = (seq1_len-j)+j0;
			pt.type = 0;
			pt.score = score_s + _h0[-j];
			return pt;
		} else if (sum_gap == diff) {
			midpoint_t pt;
			pt.i = mid0+i0;
			pt.j = (seq1_len-j)+j0;
			pt.type = 1;
			pt.score = score_s + _e0[-j];
			return pt;
		}
			
			if (PRINT) printf("%2d: %2d/%2d   %2d/%2d    %2d\n", (seq1_len-j-1)+j0, h1[mid1], f1, sum_match, sum_gap, diff);	
	}
	
	if (PRINT) printf("NOT FOUND %d\n", diff);
	fprintf(stderr, "NOT FOUND %d\n", diff);
	/*{
		midpoint_t pt;
		pt.type = -1;
		return pt;
	}*/
	exit(1);
	
	
	
	/*
	s0 = seq0->forward_data+(i1-1);
	s1 = seq1->forward_data+(j1-1);
	
	for (int j=1; j<=seq1_len; j++) {
		h1[j] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=2);
		e1[j] = -INF;
	}
	h1[0] = (type_e!=0)?-INF:0;
	e1[0] = (type_e!=1)?-INF:0;
	
	for (int i=1; i<=mid1; i++) {
		int h_tmp = h1[0];
		int h_next;
		h_next = h1[0] = e1[0] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=1);
		int f1 = -INF;
		const char s=s0[-(i-1)];
		if (PRINT) printf("%2d/%2d ", h1[0], e1[0]);
		for (int j=1; j<=seq1_len; j++) {
			e1[j] = MAX(h1[j]-DNA_GAP_FIRST, e1[j]-DNA_GAP_EXT);
			f1 = MAX(h_next-DNA_GAP_FIRST, f1-DNA_GAP_EXT);
			h_next = MAX3(h_tmp+((s==s1[-(j-1)])?DNA_MATCH:DNA_MISMATCH), e1[j], f1);
			h_tmp = h1[j];
			h1[j] = h_next;
			
			if (PRINT) printf("%2d/%2d ", h_next, e1[j]);
		}
		if (PRINT) printf("\n");
		//printf("RV: %d/%d\n", i, mid0);
	}
	*/
	
	/* Compare */
	
	
	/*
	s0 = seq0->forward_data+(i0-1);
	s1 = seq1->forward_data+(j0-1);
	
	int ii, jj, tt, best, ss;
	best = -INF;
	//tt = -1;
	ii = mid0;
	char s = s0[ii];
	if (PRINT) printf("mid0: %d (%d)\n", mid0 , ii+i0);
	if (PRINT) printf("mid1: %d (%d)\n", mid1 , ii+i0);
	if (PRINT) printf("len: s0 %d   s1 %d\n", seq0_len, seq1_len);
	
	int* _h0 = h0;
	int* _e0 = e0;
	int* _h1 = &h1[seq1_len-(1-1)];
	int* _e1 = &e1[seq1_len-(1-1)];
	
	for (int j=seq1_len; j>=0; j--) { 
		int sum_match = _h0[j] + _h1[-j];
		int sum_gap = _e0[j] + _e1[-j] + DNA_GAP_OPEN;
		
		if (true || PRINT) printf("%4d: %c[%c]%c x %c[%c]%c   [%2d/%2d][%2d/%2d] %2d/%2d\n", 
			(j-1)+j0, s0[ii-1],s0[ii],s0[ii+1], s1[j-1],s1[j],s1[j+1],
						  _h0[j], _e0[j],
						  _h1[-j], _e1[-j], 
						  sum_match, sum_gap);
						  
						  if (sum_match > best) {
							  best = sum_match;
							  jj = j;
							  tt = 0;
							  ss = score_s + _h0[j];
						  } 
						  if (sum_gap > best) {
							  best = sum_gap;
							  jj = j;
							  tt = 1;
							  ss = score_s + _e0[j];// + DNA_GAP_OPEN;
							  						  } 
	}
	if (PRINT) printf("best: %d (score: %d  ss:%d)\n", best, score_s, ss);
	
	printf("DIFF: %d MAX: %d\n", diff, best);
	if (best != diff) fprintf(stderr, "DIFF: %d MAX: %d\n", diff, best);
	
	midpoint_t pt;
	pt.i = ii+i0;
	pt.j = jj+j0;
	pt.type = tt;
	pt.score = ss;
	if (PRINT) printf("pt: %d,%d,%d,%d\n", pt.i, pt.j, pt.type, pt.score);
	return pt;
	*/
}















/*
*/

static midpoint_t split(Sequence *seq0, Sequence *seq1, int i0, int j0, int i1, int j1, 
						int type_s, int type_e, int score_s, int score_e,
						int *h0, int *h1, int *e0, int *e1) {

	if (PRINT) printf("%d %d %d %d %d %d\n", i0, j0, i1, j1, type_s, type_e, score_s, score_e);

    int seq0_len = i1-i0;
    int seq1_len = j1-j0;

    if (seq1_len >= H_MAX) {
        fprintf(stderr, "Partition size is too large (%d > %d).\n", seq1_len, H_MAX);
        exit(1);
    }

    int mid = seq0_len/2;
    int mid0 = mid;
    int mid1 = seq0_len - mid;


    /* Forward */

    char* s0 = seq0->forward_data+(i0-1);
    char* s1 = seq1->forward_data+(j0-1);

    for (int j=1; j<=seq1_len; j++) {
        h0[j] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=2);
        e0[j] = -INF;
    }
    h0[0] = (type_s!=0)?-INF:0;
    e0[0] = (type_s!=1)?-INF:0;

    for (int i=1; i<=mid0; i++) {
        int h_tmp = h0[0];
        int h_next;
        h_next = h0[0] = e0[0] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=1);
        int f0 = -INF;
        const char s=s0[i];
        if (PRINT) printf("%2d/%2d ", h0[0], e0[0]);
        for (int j=1; j<=seq1_len; j++) {
            e0[j] = MAX(h0[j]-DNA_GAP_FIRST, e0[j]-DNA_GAP_EXT);
            f0 = MAX(h_next-DNA_GAP_FIRST, f0-DNA_GAP_EXT);
            h_next = MAX3(h_tmp+((s==s1[j])?DNA_MATCH:DNA_MISMATCH), e0[j], f0);
            h_tmp = h0[j];
            h0[j] = h_next;
            if (PRINT) printf("%2d/%2d ", h_next, e0[j]);
        }
        if (PRINT) printf("\n");
        //printf("FW: %d/%d\n", i, mid0);
    }


    if (PRINT) printf("---------\n");
    /* Reverse */


    s0 = seq0->forward_data+(i1-1);
    s1 = seq1->forward_data+(j1-1);

    for (int j=1; j<=seq1_len; j++) {
        h1[j] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=2);
        e1[j] = -INF;
    }
    h1[0] = (type_e!=0)?-INF:0;
    e1[0] = (type_e!=1)?-INF:0;

    for (int i=1; i<=mid1; i++) {
        int h_tmp = h1[0];
        int h_next;
        h_next = h1[0] = e1[0] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_e!=1);
        int f1 = -INF;
        const char s=s0[-(i-1)];
        if (PRINT) printf("%2d/%2d ", h1[0], e1[0]);
        for (int j=1; j<=seq1_len; j++) {
            e1[j] = MAX(h1[j]-DNA_GAP_FIRST, e1[j]-DNA_GAP_EXT);
            f1 = MAX(h_next-DNA_GAP_FIRST, f1-DNA_GAP_EXT);
            h_next = MAX3(h_tmp+((s==s1[-(j-1)])?DNA_MATCH:DNA_MISMATCH), e1[j], f1);
            h_tmp = h1[j];
            h1[j] = h_next;

            if (PRINT) printf("%2d/%2d ", h_next, e1[j]);
        }
        if (PRINT) printf("\n");
        //printf("RV: %d/%d\n", i, mid0);
    }


    /* Compare */



    s0 = seq0->forward_data+(i0-1);
    s1 = seq1->forward_data+(j0-1);

    int ii, jj, tt, best, ss;
    best = -INF;
    //tt = -1;
    ii = mid0;
    char s = s0[ii];
    if (PRINT) printf("mid0: %d (%d)\n", mid0 , ii+i0);
    if (PRINT) printf("mid1: %d (%d)\n", mid1 , ii+i0);
    if (PRINT) printf("len: s0 %d   s1 %d\n", seq0_len, seq1_len);

    int* _h0 = h0;
    int* _e0 = e0;
    int* _h1 = &h1[seq1_len-(1-1)];
    int* _e1 = &e1[seq1_len-(1-1)];

	for (int j=seq1_len; j>=0; j--) { 
        int sum_match = _h0[j] + _h1[-j];
        int sum_gap = _e0[j] + _e1[-j] + DNA_GAP_OPEN;

        if (PRINT) printf("%4d: %c[%c]%c x %c[%c]%c   [%2d/%2d][%2d/%2d] %2d/%2d\n", 
                (j-1)+j0, s0[ii-1],s0[ii],s0[ii+1], s1[j-1],s1[j],s1[j+1],
                _h0[j], _e0[j],
                _h1[-j], _e1[-j], 
                sum_match, sum_gap);

        if (sum_match > best) {
            best = sum_match;
            jj = j;
            tt = 0;
            ss = score_s + _h0[j];
        } 
        if (sum_gap > best) {
            best = sum_gap;
            jj = j;
            tt = 1;
            ss = score_s + _e0[j];// + DNA_GAP_OPEN;
            /*if (j==0) {
                printf("FULL GAP\n");
            }*/
        } 
    }
    if (PRINT) printf("best: %d (score: %d  ss:%d)\n", best, score_s, ss);
    midpoint_t pt;
    pt.i = ii+i0;
    pt.j = jj+j0;
    pt.type = tt;
    pt.score = ss;
    if (PRINT) printf("pt: %d,%d,%d,%d\n", pt.i, pt.j, pt.type, pt.score);
    return pt;
}

int merge_partitions(Job* job, midpoint_t *new_positions) {
    vector<midpoint_t> merged_partitions;
    merged_partitions.clear();
    merged_partitions.push_back(job->midpoints[0]);
    int has_new_pos = 0;
    for (int i=1; i<job->midpoints.size(); i++) {
        bool diff_pos = (new_positions[i].i!=job->midpoints[i-1].i || new_positions[i].j!=job->midpoints[i-1].j);
        if (new_positions[i].type != -1 && diff_pos) {
            has_new_pos = 1;
            merged_partitions.push_back(new_positions[i]);
        }
        merged_partitions.push_back(job->midpoints[i]);
    }
    if (has_new_pos) {
        job->midpoints = merged_partitions;
    }
    return has_new_pos;
}

int reduce_partitions(Job* job) {
    int i0, j0, i1, j1, start_type, prev_type, prev_score;

    int partition_id = 0;
    i1 = job->midpoints[partition_id].i;
    j1 = job->midpoints[partition_id].j;
    prev_type = job->midpoints[partition_id].type;
    prev_score = job->midpoints[partition_id].score;

    split_args_t args[NUM_THREADS];
    pthread_t thread[NUM_THREADS];

    midpoint_t *new_partitions = (midpoint_t *)malloc(job->midpoints.size()*sizeof(midpoint_t));
    for (int i=0; i<NUM_THREADS; i++) {
        args[i].job = job;
        args[i].out_pos = new_partitions;
        args[i].partition0 = job->midpoints.size()*i/NUM_THREADS;
        args[i].partition1 = job->midpoints.size()*(i+1)/NUM_THREADS;
        if (i>0) {
            args[i].partition0--;
        }
        //printf("%d: %d-%d  (%d)\n", i, args[i].partition0, args[i].partition1, job->partitions_count);
        create_split_thread(&args[i], &thread[i]);
    }
    for (int i=0; i<NUM_THREADS; i++) {
        int rc = pthread_join(thread[i], NULL);
        if (rc) {
            printf("ERROR; return code from pthread_join() is %d\n", rc);
            exit(-1);
        }
    }
    int has_new_partitions = merge_partitions(job, new_partitions);
    return has_new_partitions;
}


void stage4(Job* job) {
	FILE* stats = job->fopenStatistics(STAGE_4);

	fprintf(stats, "SW PARAM: %d/%d/%d/%d\n", DNA_MATCH, DNA_MISMATCH, DNA_GAP_FIRST, DNA_GAP_EXT);
	
	fprintf(stats, "--Alignment sequences:\n", job);
	fprintf(stats, ">%s (%d)\n", job->seq[0].name.c_str(), job->seq[0].getLen());
	fprintf(stats, ">%s (%d)\n", job->seq[1].name.c_str(), job->seq[1].getLen());	
	
	fprintf(stats, "MAXIMUM PARTITION SIZE: %d\n", job->stage4_maximum_partition_size);
	fprintf(stats, "ORTHOGONAL EXECUTION: %s\n", job->stage4_orthogonal_execution?"YES":"NO");
	
	Timer timer2;
	
	cudaEvent_t ev_step = timer2.createEvent("STEP");
	cudaEvent_t ev_start = timer2.createEvent("START");
	cudaEvent_t ev_end = timer2.createEvent("END");
	cudaEvent_t ev_crosspoints = timer2.createEvent("CROSSPOINTS");
	cudaEvent_t ev_write = timer2.createEvent("WRITE");
	
	timer2.eventRecord(ev_start);
	
	job->loadMidpoints(-1);
	
	timer2.eventRecord(ev_crosspoints);
	
	int must_write_partitions = 0;
	int step = 1;
	int max_i, max_j;
	float step_sum = 0;
	while (job->getLargestMidpointSize(&max_i, &max_j) > job->stage4_maximum_partition_size) {
		int midpoints_count = job->midpoints.size();
		if (step == 1) {
			fprintf(stats, "-step %2d  max size: %5dx%5d crosspoints: %8d   time: %.4f   sum:%.4f\n", 
					0, max_i, max_j, midpoints_count, 0, 0);
			fflush(stats);
		}
		if (!reduce_partitions(job)) {
            // TODO tratar erro? não houve redução!
            break;
        }
        must_write_partitions = 1;
		float step_diff = timer2.eventRecord(ev_step);
		step_sum += step_diff;
		fprintf(stats, " step %2d  max size: %5dx%5d crosspoints: %8d   time: %.4f   sum:%.4f\n", 
				step, max_i, max_j, midpoints_count, step_diff, step_sum);
		fflush(stats);
		//job->writeMidpoints(1000+step);
		//timer2.eventRecord(ev_write);
		step++;
	}
	float step_diff = timer2.eventRecord(ev_step);
	step_sum += step_diff;
	fprintf(stats, "-step %2d  max size: %5dx%5d crosspoints: %8d   time: %.4f   sum:%.4f\n", 
			step, max_i, max_j, job->midpoints.size(), step_diff, step_sum);
	fflush(stats);
	timer2.eventRecord(ev_start);
	
    if (must_write_partitions) {
        job->writeMidpoints();
    }
	timer2.eventRecord(ev_write);
	
    if (PRINT) printf("\n");
	timer2.eventRecord(ev_end);
	
	fprintf(stats, "CUDA times:\n");
	float diff = timer2.printStatistics(stats);
	
	fprintf(stats, "        total: %.4f\n", diff);
	fclose(stats);
}

