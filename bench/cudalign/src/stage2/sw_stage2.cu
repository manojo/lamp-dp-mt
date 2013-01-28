#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include <sys/stat.h>
#include <sys/types.h>

#include "sw_stage2_common.inc.cu"


int4 goal_found(int4 *d_4out, int blocks) {
    static int4 h_4out[PHASE2_BLOCKS_COUNT];

	cutilSafeCall(cudaMemcpy(h_4out, d_4out, blocks*sizeof(int4), cudaMemcpyDeviceToHost));
	for (int k=0; k<blocks; k++) {
        //printf("%d: %d %d %d %d   : near goal\n", k, h_4out[k].x, h_4out[k].y, h_4out[k].w, h_4out[k].z);

        if (h_4out[k].x > 0) {
            printf("GOAL END!\n");
            return h_4out[k];
        }
    }
    return make_int4(0,0,0,0);
}

int4 match_found(int seq0_len, int4 *d_match_out, int j0r, int i0r, int goal, int baseXr, int step, bus_t* h_busBase, bus_t* d_busBase, bus_t* d_outV, int blocks) {
    static int4 h_match_out[ALPHA];
    dim3 grid(ALPHA, 1, 1);
    dim3 threads(PHASE2_THREADS_COUNT, 1, 1);
    int i_pos = (seq0_len-i0r) - ALPHA*PHASE2_THREADS_COUNT*(step-blocks+1)-2;  // TODO porque só funciona com -2 ??
    //printf("j_pos %d\n", j_pos);
    //printf("seq0_len{%d} - i0{%d} + (step - blocks){%d} * PHASE2_THREADS_COUNT * ALPHA = %d\n", seq0_len, i0, (step - blocks), seq0_len - i0 + (step - blocks) * PHASE2_THREADS_COUNT * ALPHA+1);
    int adjust = 0;
    if (i_pos < 0) {
        adjust = -i_pos; // Do not access negative offset memory at h_busBase
    }
    if (PRINT) printf("i_pos %d  (adjust: %d)\n", i_pos, adjust);

    // TODO FIXME acho que (ALPHA*PHASE2_THREADS_COUNT-adjust) deve ser (ALPHA*PHASE2_THREADS_COUNT) sem o - adjust
    cutilSafeCall( cudaMemcpy(d_busBase, &h_busBase[i_pos+adjust], (ALPHA*PHASE2_THREADS_COUNT+1)*sizeof(bus_t), cudaMemcpyHostToDevice));
    kernel_match <<< grid, threads, 0 >>>(seq0_len, d_match_out, i0r + (step - blocks) * PHASE2_THREADS_COUNT * ALPHA, goal, baseXr, d_busBase, d_outV + (step - blocks) * PHASE2_THREADS_COUNT * ALPHA);
    cutilSafeCall(cudaMemcpy(h_match_out, d_match_out, ALPHA * sizeof (int4), cudaMemcpyDeviceToHost));
    for (int k = 0; k < ALPHA; k++) {
		if (PRINT) printf("%d: %d %d %d %d   : goal: %d\n", k, h_match_out[k].x, h_match_out[k].y, h_match_out[k].w, h_match_out[k].z, goal);
        if (h_match_out[k].x != 0) {
            return h_match_out[k];
        }
    }
    return make_int4(0,0,0,0);
}

/*void init_score(const char* order_blosum, const char score_blosum[24][24], char out_score[128][128]) {
    memset(out_score, 0, sizeof(out_score));
    for (int i=0; order_blosum[i]; i++) {
        for (int j=0; order_blosum[j]; j++) {
            char c0 = order_blosum[i];
            char c1 = order_blosum[j];
            out_score[c0][c1] = score_blosum[i][j];
        }
    }
}*/

static map<int, SpecialRowWriter*> specialRows; // TODO colocar lá em cima

static void unflush_bus(int i0r) {
    // show content:
    for (map<int, SpecialRowWriter*>::iterator it = specialRows.begin(); it != specialRows.end(); it++) {
        int i = (*it).first;
        SpecialRowWriter* row = (*it).second;
        printf("Unflush: %08X,%08X  (%X)\n", i0r, i, row);
        /*if (row == NULL) {
            printf("NULL row\n");
            continue;
        }*/
        if (i >= i0r) {
            row->cancel();
        } else {
            row->close();
        }
        delete row;
    }
    specialRows.clear();
}
static void flush_bus(int reverse, int blocks, int seq0_len, int seq1_len, int i0r, int j0r, Job* job, int step, int baseXr, int *h_split, bus_t* h_busH, bus_t* d_busH) {
#ifdef SW_BUS_FLUSH
    if (job->flush_interval > 0) {
        for (int k=0; k<blocks && k<=step; k++) {
            int bx = k;
            const int x0 = h_split[bx];
            const int xLen = h_split[bx+1] - x0;
            int by = step-bx;
            int i=i0r + by*PHASE2_THREADS_COUNT*ALPHA;

			if (by % job->flush_interval == 0 && by>0 && i<seq0_len) {
                cudaStreamSynchronize(0);
                //printf("offset:%X+%d len:%d\n", d_busH, x0, xLen*sizeof(cell2_t));
                cutilSafeCall(cudaMemcpy(h_busH+x0, d_busH+x0, xLen*sizeof(cell2_t), cudaMemcpyDeviceToHost));
                cudaStreamSynchronize(0);

                int rowId;
                int colId;
                if (reverse) {
                    rowId = seq1_len-j0r;
                    colId = seq0_len-i;
                } else {
                    rowId = i;
                    colId = j0r;
                }

                if (bx==0) {
                    SpecialRowWriter* row;
                    row = job->fopenNewSpecialRow(STAGE_2, rowId, colId);
                    specialRows[i] = row;
                    row->open();
                    printf("Flush: %08X,%08X    (aux %08X,%08X)\n", rowId, colId, baseXr, i);
                }
                /*bus_t dummy;
                dummy.x = 0x99999999;
                dummy.y = 0x99999999;*/
                //specialRows[i]->write(&dummy, 1);
                specialRows[i]->write(&h_busH[x0], xLen);
                //specialRows[i]->write(&dummy, 1);
                if (bx==blocks-1) {
                    //printf("Close: %08X,%08X\n", baseY, j0-i);
                    SpecialRowWriter* row = specialRows[i];
                    specialRows.erase(i);
                    row->close();
                    delete row;
                }

            }
        }
    }
#endif
}


int4 findNearGoal(Job* job, cuda_structures_t* cuda, int reverse, int blocks, int i0r, int j0r, int baseXr, int baseX, int* h_split, bus_t* h_busH, int seq0_len, int seq1_len, int goal, int d, int start_type) {
    printf("NEAR GOAL!!!\n");
	dim3 grid(blocks, 1, 1);
    dim3 threads(PHASE2_THREADS_COUNT, 1, 1);
	kernel_nw_short_phase<true><<< grid, threads, 0>>>(i0r, j0r, baseXr, seq0_len, seq1_len, goal, cuda->d_4out, d, cuda->d_busH, cuda->d_busV1, cuda->d_busV2, cuda->d_busV3, cuda->d_outV, start_type);
    flush_bus(reverse, blocks, seq0_len, seq1_len, i0r, j0r, job, d, baseX, h_split, h_busH, cuda->d_busH);
	kernel_nw_long_phase<true><<< grid, threads, 0>>>(i0r, j0r, baseXr, seq0_len, seq1_len, goal, cuda->d_4out, d, cuda->d_busH, cuda->d_busV1, cuda->d_busV2, cuda->d_busV3, cuda->d_outV, start_type);

    return goal_found(cuda->d_4out, blocks);
}

void findFarGoal(Job* job, cuda_structures_t* cuda, int reverse, int blocks, int i0r, int j0r, int baseXr, int baseX, int* h_split, bus_t* h_busH, int seq0_len, int seq1_len, int goal, int d, int start_type) {
	dim3 grid(blocks, 1, 1);
    dim3 threads(PHASE2_THREADS_COUNT, 1, 1);
	//printf("KERNEL_NW_LARGE_QUICK(%d) xLen: %d  xLen/B: %d  height: %d\n", d, xLen, xLen/blocks, PHASE2_GRID_HEIGHT);
	kernel_nw_short_phase<false><<< grid, threads, 0>>>(i0r, j0r, baseXr, seq0_len, seq1_len, goal, cuda->d_4out, d, cuda->d_busH, cuda->d_busV1, cuda->d_busV2, cuda->d_busV3, cuda->d_outV, start_type);
	flush_bus(reverse, blocks, seq0_len, seq1_len, i0r, j0r, job, d, baseXr, h_split, h_busH, cuda->d_busH);
	kernel_nw_long_phase<false><<< grid, threads, 0>>>(i0r, j0r, baseXr, seq0_len, seq1_len, goal, cuda->d_4out, d, cuda->d_busH, cuda->d_busV1, cuda->d_busV2, cuda->d_busV3, cuda->d_outV, start_type);
}

midpoint_t find_next_midpoint(Job* job, Sequence* seq_vertical, Sequence* seq_horizontal, int reverse, midpoint_t midpoint, host_structures_t &host, cuda_structures_t &cuda, SpecialRowReader* specialRow) {
	midpoint_t next_midpoint;
	const int seq0_len = seq_vertical->getLen();
	const int seq1_len = seq_horizontal->getLen();
	const int bus_size = seq1_len*sizeof(bus_t);
	const int baseX = specialRow==NULL?0:specialRow->getRow();

	/*if (specialRow != NULL) {
		baseX = specialRow->getRow();
	} else {
		baseX = 0;
	}*/
	
	int i0r;
	int j0r;
	int baseXr;
	
	if (reverse) {
		i0r = seq0_len - midpoint.i;
		j0r = seq1_len - midpoint.j;
		baseXr = seq1_len - baseX;
		if (baseXr > seq1_len) baseXr = seq1_len;
	} else {
		i0r = midpoint.i-1; // TODO VALIDAR
		j0r = midpoint.j-1; // TODO VALIDAR
		baseXr = baseX;
	}
	
	cutilSafeCall( cudaMemset(cuda.d_4out, 0, sizeof(int4)));
	
	const int xLen = baseXr-j0r+1; // inclusive baseX
	{
		dim3 threads(512,1,1);
		dim3 blocks(PHASE2_BLOCKS_COUNT,1,1);
		printf("kernel_initialize_busH<<<%d, %d>>>(..., j0r:%d, xLen:%d   midpoint.type:%d)\n", threads.x, blocks.x, j0r, xLen, midpoint.type);
		kernel_initialize_busH<<<threads, blocks>>>(cuda.d_busH, j0r, xLen, midpoint.type);
		cutilCheckMsg("Kernel execution failed");
		
		/*cutilSafeCall ( cudaMemcpy ( host.h_busH, cuda.d_busH+j0r, xLen * sizeof ( cell2_t ), cudaMemcpyDeviceToHost ) );
		for (int i=0; i<xLen; i++) {
			printf("%02d ", host.h_busH[i]);
			if (i%10 == 0) printf("\n");
		}
		printf("\n");*/
			
		
	}
	
	cutilSafeCall(cudaBindTexture(0, t_busH, cuda.d_busH, bus_size));
	
	int blocks = MULTIPROCESSORS*2;
	if ( xLen <= 2*blocks*PHASE2_THREADS_COUNT ) {
		blocks = xLen/2/PHASE2_THREADS_COUNT;
		if (blocks > MULTIPROCESSORS) {
			blocks = (blocks/MULTIPROCESSORS)*MULTIPROCESSORS;
		}
		if (blocks <= 1) {
			blocks = 1;
		}
	}
	
	printf ( "SIZES xLen: %d  B: %d  xLen/B: %d  2*height: %d   %s\n",
			 xLen, blocks, xLen/blocks, 2*PHASE2_THREADS_COUNT, blocks==1?"ERROR":"OK" );
			 
	
	int h = ( midpoint.i/PHASE2_THREADS_COUNT/ALPHA+blocks+1 ); // TODO validar

	int pend1;
	if (specialRow != NULL) {	
		specialRow->open ( host.h_busBase, midpoint.i );
		pend1 = specialRow->read ( host.h_busBase, midpoint.i - ALPHA*PHASE2_THREADS_COUNT );
	} else {
		// TODO memset?
	}


    int h_split[PHASE2_BLOCKS_COUNT + 1];
    createSplitPositions ( j0r, xLen, h_split, blocks );
    cutilSafeCall ( cudaMemcpyToSymbol ( d_split, h_split, sizeof ( h_split ) ) );




    // TODO analisar casos limitrofes. ex.: (i0,j0)=(1,1) - perfect match
    int d;
	dim3  threads( PHASE2_THREADS_COUNT, 1, 1);
	printf ( "i0r: %d   , j0r: %d,  baseXr: %d\n", i0r, j0r, baseXr );
	printf ( "i0r: %d   , j0r: %d,  baseXr: %d\n", seq0_len-i0r-1, seq1_len-j0r-1, seq1_len-baseXr-1 );
	for ( d=0; d<h; d++ ) {
        if ( blocks == 1 ) {
            dim3  grid ( 1, 1, 1 );
            if ( midpoint.score <= xLen*DNA_MATCH ) {
				kernel_nw_single_phase<PHASE2_THREADS_COUNT, true><<< grid, threads, 0>>> ( i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, cuda.d_4out, d, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_outV, midpoint.type );
                int4 found = goal_found ( cuda.d_4out , blocks);
                if ( found.x > 0 ) {
					next_midpoint.i = seq0_len-found.y-1;
					next_midpoint.j = seq1_len-found.x-1;
					next_midpoint.score = found.w;
					next_midpoint.type = found.z;
					printf ( "GOAL END (%d,%d)!\n", next_midpoint.i, next_midpoint.j );
                    break;
                }
            } else {
				kernel_nw_single_phase<PHASE2_THREADS_COUNT, false><<< grid, threads, 0>>> ( i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, cuda.d_4out, d, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_outV, midpoint.type );
            }
        } else {
            //printf ( "GOAL: %d    MAX: %d\n", midpoint.score, ( xLen+1 ) *DNA_MATCH );
            if ( midpoint.score <= ( xLen+1 ) *DNA_MATCH ) {
				int4 found = findNearGoal ( job, &cuda, reverse, blocks, i0r, j0r, baseXr, baseX, h_split, host.h_busH, seq0_len, seq1_len, midpoint.score, d, midpoint.type );
                if ( found.x > 0 ) {
					next_midpoint.i = seq0_len-found.y-1;
					next_midpoint.j = seq1_len-found.x-1;
					next_midpoint.score = found.w;
					next_midpoint.type = found.z;
					printf ( "GOAL END (%d,%d)!\n", next_midpoint.i, next_midpoint.j );
                    break;
                }

            } else {
				findFarGoal ( job, &cuda, reverse, blocks, i0r, j0r, baseXr, baseX, h_split, host.h_busH, seq0_len, seq1_len, midpoint.score, d, midpoint.type );
            }
        }

		if (specialRow != NULL) {	
			pend1 = specialRow->read ( host.h_busBase, midpoint.i - ALPHA*PHASE2_THREADS_COUNT* ( d+2 ) -1 ); // TODO precisa do -1?
		} else {
			// TODO memset?
		}

        //int blocks = PHASE2_BLOCKS_COUNT;
        if ( d >= blocks ) {

            cudaStreamSynchronize ( 0 );
            if ( PRINT ) {
                printDebugMatch ( &cuda, baseXr, seq0_len, 0, reverse, i0r, j0r, seq_vertical, seq_horizontal, d, blocks, seq0_len, &host );
            }
            // TODO não precisa testar se baseX==0, pois ele já deveria encontrar no metodo goal_found
            int4 found = match_found ( seq0_len, cuda.d_match_out, j0r, i0r, midpoint.score, baseXr, d, host.h_busBase, cuda.d_busBase, cuda.d_outV, blocks );
            if ( found.x < 0 ) {
                fprintf ( stderr, "ERROR: Backtrace lost! Can't continue." );
                exit ( 1 );
            } else if ( found.x > 0 ) {
				next_midpoint.i = seq0_len-found.y;
				next_midpoint.j = seq1_len-found.x;
				next_midpoint.score = found.w;
				next_midpoint.type = found.z;
                break;
            }
        }
    }

	long long cells_updates = 0;
	for (int i=1; i<=d && i<=blocks; i++) {
		long long delta_h = h_split[i]-h_split[0];
		cells_updates += delta_h * ALPHA * PHASE2_THREADS_COUNT;
	}
	if (d >= blocks) {
		long long delta_h = h_split[blocks]-h_split[0];
		cells_updates += (d-blocks+1)*delta_h * ALPHA * PHASE2_THREADS_COUNT;
	}
	job->cells_updates += cells_updates;
	fprintf ( stdout, "D:%d BLOCKS:%d xLen: %d   cells: %lld    total(%.f mi)\n", d,blocks,xLen, cells_updates, job->cells_updates/1000000.0f);
	
    if ( d == h ) {
        fprintf ( stderr, "ERROR: Backtrace lost! End of matrix reached." );
        exit ( 1 );
    }
	
	
	//cutilSafeCall(cudaUnbindTexture(t_busH)); // TODO necessario?
	
	return next_midpoint;
}


void stage2(Job* job) {
	FILE* stats = job->fopenStatistics(STAGE_2);
	stats = stderr;
	
	job->loadMidpoints(0);
	job->loadSpecialRows(STAGE_1);
	job->cells_updates = 0;
	
	int reverse = 1;

	
    Sequence* seq_vertical;
    Sequence* seq_horizontal;
    if (reverse) {
        seq_vertical = new Sequence(job->seq[1], reverse);
		seq_horizontal = new Sequence(job->seq[0], reverse);
    } else {
		seq_vertical = new Sequence(job->seq[0], reverse);
		seq_horizontal = new Sequence(job->seq[1], reverse);
    }
	/*printf("A: %X\n", seq_vertical);
	printf("B: %d\n", seq_vertical->getLen());
	printf("C: %c %d\n", seq_vertical->forward_data[0], strlen(seq_vertical->forward_data));
	printf("D:  %.5s\n", seq_vertical->forward_data+seq_vertical->getLen()-5);
	printf("seq_vertical: (%d) %.5s ... %.5s\n", seq_vertical->getLen(), seq_vertical->forward_data, seq_vertical->forward_data+seq_vertical->getLen()-6);
	printf("seq_horizontal: (%d) %.5s ... %.5s\n", seq_horizontal->getLen(), seq_horizontal->forward_data, seq_horizontal->forward_data+seq_horizontal->getLen()-5);*/
	

    int seq0_len = seq_vertical->getLen();
    int seq1_len = seq_horizontal->getLen();

    MidpointsFile* midpointsFile = job->fopenMidpointsFile(1);

	midpoint_t midpoint = job->midpoints.back();

    if (reverse) {
		int aux = midpoint.i;
		midpoint.i = midpoint.j;
		midpoint.j = aux;
    } else {
		//midpoint.i = job->phase2_i0;
		//midpoint.j = job->phase2_j0;
    }
    //midpoint.score = job->phase2_max;
	//midpoint.type = 0;

	if (job->flush_limit > 0) {
		int max_i;
		int max_j;
		job->getLargestSpecialRowInterval(STAGE_1, &max_i, &max_j);

		// Necessary if we do not have any special row.
		if (max_i == 0) {
			max_i = midpoint.i;
		}
		
		int max_len = midpoint.j;
		
		int maximum_recomended_flush_interval = max_i/4/(THREADS_COUNT*ALPHA);
		fprintf(stats, "Maximum special row distance: %lld\n", max_i);
		fprintf(stats, "Maximum recomended flush interval: %lld\n", maximum_recomended_flush_interval);
		
		//job->flush_interval = 6;
		job->flush_interval = (max_len*8LL/(job->flush_limit/max_i))/(THREADS_COUNT*ALPHA)+1; // TODO constante no lugar de 8
		if (job->flush_interval > maximum_recomended_flush_interval) {
			fprintf(stats, "Reducing Flush Interval from %lld to %lld\n", job->flush_interval, maximum_recomended_flush_interval);
			
			// TODO comentei para nao influenciar os testes
			//job->flush_interval = maximum_recomended_flush_interval;
			
			// TODO tratar com um warning, com exit? como ajuste? como erro? verificar
			// TODO fazer o mesmo na fase 1?
		}
		
		long long special_lines_count = (max_len/(THREADS_COUNT*ALPHA*job->flush_interval));
		fprintf(stats, "Special columns: %lld\n", special_lines_count);
		fprintf(stats, "Total size: %lld\n", special_lines_count*max_i*8LL);  // TODO 8*/
	} else {
		job->flush_interval = 0;
		job->flush_limit = 0;
	}
	fprintf(stats, "Flush Interval: %d\n", job->flush_interval);
	fprintf(stats, "Flush limit: %lld\n", job->flush_limit);
	
	fprintf(stats, "SW PARAM: %d/%d/%d/%d\n", DNA_MATCH, DNA_MISMATCH, DNA_GAP_FIRST, DNA_GAP_EXT);
	
	fprintf(stats, "--Alignment sequences:\n", job);
	fprintf(stats, ">%s (%d)\n", job->seq[0].name.c_str(), seq0_len);
	fprintf(stats, ">%s (%d)\n", job->seq[1].name.c_str(), seq1_len);	
	fflush(stats);

    selectGPU(job->gpu, stats);

    Timer timer2;

    cudaEvent_t ev_step = timer2.createEvent("STEP");
    cudaEvent_t ev_start = timer2.createEvent("START");
    cudaEvent_t ev_end = timer2.createEvent("END");
    cudaEvent_t ev_copy = timer2.createEvent("COPY");
    cudaEvent_t ev_alloc = timer2.createEvent("ALLOC");
    cudaEvent_t ev_kernel = timer2.createEvent("KERNEL");
    cudaEvent_t ev_writeback = timer2.createEvent("WRITEBACK");

	printDevMem(stats);
	
    timer2.eventRecord(ev_start);

	host_structures_t host;
	cuda_structures_t cuda;
	allocHostStructures(seq_vertical, seq_horizontal, &host);
    allocCudaStructures(seq_vertical, seq_horizontal, &cuda);

    timer2.eventRecord(ev_copy);
    timer2.eventRecord(ev_alloc);

    int line_index=0;

	midpointsFile->write(midpoint.j, midpoint.i, midpoint.score, midpoint.type);
	while (midpoint.score > 0) {
		fprintf(stdout, ">> %d %d %d\n", midpoint.j, midpoint.i, midpoint.score);
		fprintf(stdout, "Millions Cells Updates: %.3f\n", job->cells_updates/1000000.0f);
		
		SpecialRowReader* specialRow = job->fopenNextSpecialRow(STAGE_1, midpoint.j, midpoint.i, PHASE2_THREADS_COUNT, &line_index); // TODO inverter j0 com i0?
		midpoint = find_next_midpoint(job, seq_vertical, seq_horizontal, reverse, midpoint, host, cuda, specialRow);
        if (specialRow != NULL) specialRow->close();
#ifdef SW_BUS_FLUSH
        unflush_bus(seq0_len-midpoint.i-1);
#endif

		midpointsFile->write(midpoint.j, midpoint.i, midpoint.score- (midpoint.type==0?0:DNA_GAP_OPEN), midpoint.type);
    }

//////////

    timer2.eventRecord(ev_kernel);
    midpointsFile->close();

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
	
	fclose(stats);
	cudaThreadExit();
	cutilCheckMsg("cudaThreadExit failed");
}

//#include "sw_stage3.cu"