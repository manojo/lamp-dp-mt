#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#include <sys/stat.h>
#include <sys/types.h>

#include "../common/cudalign.hpp"

/*#include "../common/sw_configs.hpp"
#include "../common/cuda_configs.hpp"
#include "../common/macros.hpp"

#include "../common/sequence.c"*/ // TODO resolver isso!!

//seq_t seq[2];

#define H_MAX (1*1024)
#define W_MAX (1*1024)

static int h[W_MAX][H_MAX];
static int e[W_MAX][H_MAX];
static int f[W_MAX][H_MAX];



#define PRINT (0)


static void dot(Alignment* alignment, Sequence *seq0, Sequence *seq1, int i, int j, int type) {
    //int pt;
    char* s0 = seq0->forward_data-1;
    char* s1 = seq1->forward_data-1;
    if (PRINT) printf("(%5d,%5d) ", i, j);
    if (type == 0) {
        if (PRINT) printf("%c%s%c [                 ]", s0[i], s0[i]==s1[j]?"-":" ", s1[j]);
    } else if (type == 1) {
        if (PRINT) printf("%c - [ add(1, %7d) ]", s0[i], j);
        alignment->addGapInSeq1(j);
    } else if (type == 2) {
        if (PRINT) printf("- %c [ add(0, %7d) ]", s1[j], i);
        alignment->addGapInSeq0(i);
    }
}


static int sw(Alignment* alignment, Sequence *seq0, Sequence *seq1, int i0, int j0, int i1, int j1, int type_s, int type_e) {
    i0++;
    j0++;

    // TODO conferir
    if (type_e == 0) {
        j1++;
        i1++;
    } else if (type_e == 1) {
        //j1++;
    }

    if (PRINT) printf("%d %d %d %d %d %d\n", i0, j0, i1, j1, type_s, type_e);

    int seq0_len = i1-i0+1;
    int seq1_len = j1-j0+1;


    char* s0 = seq0->forward_data+(i0-1);
    char* s1 = seq1->forward_data+(j0-1);

    for (int j=1; j<=seq1_len; j++) {
        h[0][j] = -j*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=2);
        e[0][j] = -INF;
    }
    h[0][0] = (type_s!=0?-INF:0);
    e[0][0] = (type_s!=1?-INF:0);

    for (int i=1; i<=seq0_len; i++) {
        h[i][0] = -i*DNA_GAP_EXT - DNA_GAP_OPEN*(type_s!=1);
        f[i][0] = -INF;
        const char s=s0[i-1];

        int* h0 = h[i];
        int* h1 = h[i-1];
        int* e0 = e[i];
        int* e1 = e[i-1];
        int* f0 = f[i];
        for (int j=1; j<=seq1_len; j++) {
            e0[j] = MAX(h1[j]-DNA_GAP_FIRST, e1[j]-DNA_GAP_EXT);
            f0[j] = MAX(h0[j-1]-DNA_GAP_FIRST, f0[j-1]-DNA_GAP_EXT);
            h0[j] = MAX3(h1[j-1]+((s==s1[j-1])?DNA_MATCH:DNA_MISMATCH), e0[j], f0[j]);
        }
        //printf("\nj:%4d %c SW: %4d\n", j1-j, s1[j-1], h[j][seq0_len]);
    }

    if (false && PRINT) {
        printf("%8s:\t.\t", "HEADER");
        for (int j=0; j<=seq1_len; j++) {
            printf("%c(%2d)\t", j==0?'*':s1[j-1], (j+j0-1)%100);
        }
        printf("\n");
        for (int i=0; i<=seq0_len; i++) {
            printf("%8d:\t%c\t", i+i0-1, i==0?'*':s0[i-1]);
            for (int j=0; j<=seq1_len; j++) {
                int v=h[i][j];
                if (v <= -INF) {
                    printf("%5s\t", "INF");
                } else {
                    printf("%5d\t", v);
                }
            }
            printf("\n");
        }
    }


    int sum = 0;
    int i=seq0_len;
    int j=seq1_len;
    int score;
    int c;
    
    score = h[seq0_len][seq1_len];
    if (type_e==0) {
        i--;
        j--;
        c=0;
    } else if (type_e==1) {
        score -= DNA_GAP_OPEN;
        int ss = e[seq0_len][seq1_len];
        if (true || ss >= score) { // TODO validar esse if
            score = ss;
            c=1;
        } else {
            c=0;
        }
    } else if (type_e==2) {
        score -= DNA_GAP_OPEN;
        int ss = f[seq0_len][seq1_len];
        if (true || ss > score) { // TODO validar esse if
            score = ss;
            c=2;
        } else {
            c=0;
        }
    }

    if (PRINT) printf ("Score: %5d %d%d\n", score, type_s, type_e);

    while (i>0 && j>0) {

        int dir;

        int _eh = h[i-1][j]-DNA_GAP_FIRST;
        int _fh = h[i][j-1]-DNA_GAP_FIRST;
        int _h11 = h[i-1][j-1]+((s0[i-1]==s1[j-1])?DNA_MATCH:DNA_MISMATCH);
        int _h10 = e[i][j];
        int _h01 = f[i][j];
        int _h00 = h[i][j];

        if (c==0) {
            if (_h00 == _h11) {
                dir = 0;
                c = 0;
            } else if (_h00 == _h10) {
                dir = 1;
                if (_h10==_eh) {
                    c = 0;
                } else {
                    c = 1;
                }
            } else if (_h00 == _h01) {
                dir = 2;
                if (_h01==_fh) {
                    c = 0;
                } else {
                    c = 2;
                }
            }             
        } else if (c==1) {
            dir = 1;
            if (_h10==_eh) {
                c = 0;
            } else {
                c = 1;
            }
        } else if (c==2) {
            dir = 2;
            if (_h01==_fh) {
                c = 0;
            } else {
                c = 2;
            }
        }

        if (i<=0) {
            dir = 2;
            c=2; // necessario somente para debug (pt)
            //printf("??? 2\n");
        }
        if (j<=0) {
            dir = 1;
            c=1; // necessario somente para debug (pt)
            //printf("??? 1\n");
        }

        int pt=0;


        dot(alignment, seq0, seq1, i0+(i-1), j0+(j-1), dir);
        if (dir == 0) {
            pt = ((s0[i-1]==s1[j-1])?DNA_MATCH:DNA_MISMATCH);
            i--;
            j--;
        } else if (dir == 1) {
            pt = c==0?-DNA_GAP_FIRST:-DNA_GAP_EXT;
            i--;
        } else if (dir == 2) {
            pt = c==0?-DNA_GAP_FIRST:-DNA_GAP_EXT;
            j--;
        }
        sum += pt;
        if (PRINT) printf("   %2d %5d {c:%d, dir:%d} (%d,%d)\n", pt, sum, c, dir, i, j);

    }
    while (i>0) {
        dot(alignment, seq0, seq1, i0+(i-1), j0+(j-1), 1);
		int pt = -DNA_GAP_EXT;
		i--;
        c=1;
        sum += pt;
        if (PRINT) printf("   %2d %5d {c:%d, dir:%d} (%d,%d)*\n", pt, sum, c, 2, i, j);
    }
    while (j>0) {
        dot(alignment, seq0, seq1, i0+(i-1), j0+(j-1), 2);
		int pt = -DNA_GAP_EXT;
		j--;
        c=2;
        sum += pt;
        if (PRINT) printf("   %2d %5d {c:%d, dir:%d} (%d,%d)*\n", pt, sum, c, 2, i, j);
    }
	if (type_s==0 && c!=0) {
		sum -= (DNA_GAP_OPEN);
	}
	return sum;
}


void stage5(Job* job) {
	FILE* stats = job->fopenStatistics(STAGE_5);
	
	fprintf(stats, "SW PARAM: %d/%d/%d/%d\n", DNA_MATCH, DNA_MISMATCH, DNA_GAP_FIRST, DNA_GAP_EXT);
	
	fprintf(stats, "--Alignment sequences:\n", job);
	fprintf(stats, ">%s (%d)\n", job->seq[0].name.c_str(), job->seq[0].getLen());
	fprintf(stats, ">%s (%d)\n", job->seq[1].name.c_str(), job->seq[1].getLen());	
	
	job->loadMidpoints(-1);
	
    //Alignment alignment(job);
	Alignment* alignment = job->alignment;
    
    int i0, j0, i1, j1, start_type, prev_type;
    midpoint_t prev = job->midpoints.front();

    int partition_id = 1;
    /*i1 = job->partitions[partition_id].i;
    j1 = job->partitions[partition_id].j;
    prev_type = job->partitions[partition_id].type;*/

    /*int ii = i1;
    int jj = j1;*/

    int max_size = job->getLargestMidpointSize();
    if (max_size > W_MAX || max_size > H_MAX) {
        fprintf(stderr, "ERROR: MAX SIZE: %d\n", max_size);
        exit(1);
    }
    fprintf(stats, "Largest Block: %d\n", max_size);

	Timer timer2;
	
	cudaEvent_t ev_step = timer2.createEvent("STEP");
	cudaEvent_t ev_start = timer2.createEvent("START");
	cudaEvent_t ev_finalize = timer2.createEvent("FINALIZE");
	cudaEvent_t ev_write_binary = timer2.createEvent("WRITE_BINARY");
	cudaEvent_t ev_write_text = timer2.createEvent("WRITE_TEXT");
	cudaEvent_t ev_end = timer2.createEvent("END");
	
	timer2.eventRecord(ev_start);
	
    int score = 0;
    for (; partition_id<job->midpoints.size(); partition_id++) {
        //if (partition_id<job->partitions.size()-1) partition_id++;
        //if (partition_id<job->partitions.size()-1) partition_id++;

    //while (1) {
        midpoint_t curr = job->midpoints[partition_id];
        /*i0 = job->partitions[partition_id].i;
        j0 = job->partitions[partition_id].j;
        start_type = job->partitions[partition_id].type;*/

        if (curr.i == 0 && curr.j == 0) break;

        //printf("ID: %d   %d x %d\n", partition_id, prev.i-curr->i, prev.j-curr->j);
        //dot(&alignment, &job->seq[0], &job->seq[1], prev.i, prev.j, prev.type);
        
        int sum = sw(alignment, &job->seq[0], &job->seq[1], curr.i, curr.j, prev.i, prev.j, curr.type, prev.type);
		
        score += sum;
        if (PRINT) printf("> SW   %5d/%d\n", sum, score);
        if (true || PRINT) {
			int goal_diff = (prev.score)-
					(curr.score);
            if (goal_diff!=sum) {
                fprintf(stderr, "[%s] GOAL DIFF: %8d   SUM: %8d   (%d,%d,%d)-(%d,%d,%d)\n", goal_diff==sum?"OK":"ERROR", goal_diff, sum,
                        curr.i, curr.j, curr.type, prev.i, prev.j, prev.type);
            }
        }

        if (PRINT) printf("\n");

		//timer2.eventRecord(ev_step);
		
        /*prev_type = start_type;
        i1 = i0;
        j1 = j0;*/
        prev = curr; 
    }
	timer2.eventRecord(ev_step);
	
    midpoint_t first = job->midpoints.front();
    midpoint_t last = job->midpoints.back();
    //dot(&alignment, &job->seq[0], &job->seq[1], last.i, last.j, last.type);

    if (PRINT) printf("\n");

    fprintf(stats, "(%d,%d)\n", last.type, first.type);
	fprintf(stats, "(%d,%d)->(%d,%d)\n", last.i, last.j, first.i, first.j);

	alignment->finalize(last.i, last.j, first.i, first.j);
	timer2.eventRecord(ev_finalize);
	
	alignment->printBinary(job->alignment_binary_filename);
	timer2.eventRecord(ev_write_binary);
	
	
	/*alignment->printText(job->alignment_filename);
	timer2.eventRecord(ev_write_text);*/
	
	//alignment.drawAlignment("alignment.svg");
    
    fprintf(stats, "Goal Diff: %d\n", first.score-last.score);
	
	timer2.eventRecord(ev_end);
	
	fprintf(stats, "CUDA times:\n");
	float diff = timer2.printStatistics(stats);
	
	fprintf(stats, "        total: %.4f\n", diff);
	fclose(stats);
	
}
