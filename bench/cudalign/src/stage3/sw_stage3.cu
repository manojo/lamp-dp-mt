#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include <sys/stat.h>
#include <sys/types.h>

#include "../stage2/sw_stage2_common.inc.cu"

int4 match_found22(int seq0_len, int yLen, int4 *d_match_out, int j0r, int i0r, int goal, int baseXr, int step, bus_t* h_busBase, bus_t* d_busBase, bus_t* d_outV, int blocks) {
    static int4 h_match_out[ALPHA];
    dim3 grid(ALPHA, 1, 1);
    dim3 threads(PHASE2_THREADS_COUNT, 1, 1);
    int i_pos = yLen - ALPHA*PHASE2_THREADS_COUNT*(step-blocks+1)-2; // TODO por que -2??
    //printf("seq0_len - i_pos - PHASE2_THREADS_COUNT*ALPHA = %d\n", (seq0_len - i_pos - PHASE2_THREADS_COUNT*ALPHA));
    int adjust = 0;
    if (i_pos < 0) {
        adjust = -i_pos; // Do not access negative offset memory at h_busBase
    }
    //printf("i_pos %d  (adjust: %d)\n", i_pos, adjust);
    // ALPHA*PHASE2_THREADS_COUNT+1 -> +1 because we need extra cell for (m-1)
    for (int i=0; i<(ALPHA*PHASE2_THREADS_COUNT+1); i++) {
        //printf("%d/%d ", h_busBase[i_pos+adjust+i].x, h_busBase[i_pos+adjust+i].y);
    }
    printf("\n");
    cutilSafeCall( cudaMemcpy(d_busBase+adjust, &h_busBase[i_pos+adjust], (ALPHA*PHASE2_THREADS_COUNT+1-adjust)*sizeof(bus_t), cudaMemcpyHostToDevice));
    kernel_match <<< grid, threads, 0 >>>(i0r+yLen, d_match_out, i0r + (step - blocks) * PHASE2_THREADS_COUNT * ALPHA, goal, baseXr, d_busBase, d_outV + (step - blocks) * PHASE2_THREADS_COUNT * ALPHA);
    cutilSafeCall(cudaMemcpy(h_match_out, d_match_out, ALPHA * sizeof (int4), cudaMemcpyDeviceToHost));
    for (int k = 0; k < ALPHA; k++) {
        if (h_match_out[k].x != 0) {
			printf("%d: %d %d %d %d   : goal: %d\n", k, h_match_out[k].x, h_match_out[k].y, h_match_out[k].w, h_match_out[k].z, goal);
			return h_match_out[k];
        }
    }
    return make_int4(0,0,0,0);
}

midpoint_t find_next_midpoint22 ( Job* job, Sequence* seq_vertical, Sequence* seq_horizontal, int reverse, midpoint_t midpoint, midpoint_t midpoint1, host_structures_t &host, cuda_structures_t &cuda, SpecialRowReader* specialRow/*, int &line_index*/ ) {
    midpoint_t next_midpoint;
    const int seq0_len = seq_vertical->getLen();
    const int seq1_len = seq_horizontal->getLen();
    const int bus_size = seq1_len*sizeof ( bus_t );
    const int baseX = specialRow->getCol() +1;
	const int start_type = midpoint.type;

    int i0r;
    int j0r;
    int baseXr;

    if ( reverse ) {
        i0r = seq0_len - midpoint.i;
        j0r = seq1_len - midpoint.j;
        baseXr = seq1_len - baseX - 1;
    } else {
        i0r = midpoint.i-1; // TODO VALIDAR
        j0r = midpoint.j-1; // TODO VALIDAR
        baseXr = baseX-1;
    }

	i0r++;
	j0r++;

    /*if (midpoint0.type == 0) {
    if (seq_horizontal->data[midpoint0.j-1] == seq_vertical->data[i0-1]) {
    	printf("DNA_MATCH (%c x %c)\n", seq_horizontal->data[midpoint0.j-1], seq_vertical->data[i0-1]);
    	goal = goal - DNA_MATCH;
    } else {
    printf("DNA_MISMATCH (%c x %c)\n", seq_horizontal->data[midpoint0.j-1], seq_vertical->data[i0-1]);
    goal = goal - DNA_MISMATCH;
    }
    }*/




    printf ( "baseXr = %d\n", baseXr );
    printf ( "j0r = %d\n", j0r );
    printf ( "i0r = %d\n", i0r );
    printf ( "midpoint1.j = %d\n", midpoint1.j );
    printf ( "midpoint1.i = %d\n", midpoint1.i );
    if ( specialRow->getRow() > midpoint1.i ) {
        printf ( "Partition Finished\n" );
		next_midpoint = midpoint1;
		/*next_midpoint.i = job->midpoints[partition_id].i;
		next_midpoint.j = job->midpoints[partition_id].j;
		next_midpoint.type = job->midpoints[partition_id].type;*/
		next_midpoint.score = 0;
        //line_index--;

        return next_midpoint;
    } else {
        printf ( "Partition Continue (%d <= %d)\n", specialRow->getRow(), midpoint1.i );
    }
    //printf("%X %d\n", file, 0);

    //fread(h_busBase, job->seq[1].len, sizeof(bus_t), file);
    //int p = midpoint0.j;


    cutilSafeCall ( cudaMemset ( cuda.d_4out, 0, sizeof ( int4 ) ) );

    const int xLen = baseXr-j0r+1; // exclusive baseX
    printf ( "xLen = %d-%d=%d\n", baseXr, j0r, baseXr-j0r );
    {
        dim3 threads ( 512,1,1 );
        dim3 blocks ( xLen/threads.x+1,1,1 );
        kernel_initialize_busH<<<threads, blocks>>> ( cuda.d_busH, j0r, xLen, start_type );
    }

    const int yLen = specialRow->getRow()-midpoint.i;
    printf ( "yLen: %d\n", yLen );

    cutilSafeCall ( cudaBindTexture ( 0, t_busH, cuda.d_busH, bus_size ) );

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
			 
	int h = ( yLen/PHASE2_THREADS_COUNT/ALPHA+blocks+1 ); // TODO validar
    printf ( "READ\n" );
    specialRow->open ( host.h_busBase, yLen );
    int pend1 = specialRow->read ( host.h_busBase, yLen - ALPHA*PHASE2_THREADS_COUNT-3 ); // TODO + em vez de -

	
    int h_split[PHASE2_BLOCKS_COUNT + 1];
	createSplitPositions(j0r, xLen, h_split, blocks);
	
    cutilSafeCall ( cudaMemcpyToSymbol ( d_split, h_split, sizeof ( h_split ) ) );
    //is_too_small = true;


    printf ( "(%d,%d)\n", xLen*DNA_GAP_EXT, host.h_busBase[yLen-1].y );
    printf ( "full_gap: %d\n", ( xLen-1 ) *-DNA_GAP_EXT + host.h_busBase[yLen-1].y + DNA_GAP_OPEN );
    // TODO validar
    int full_gap = 0;
    if ( start_type==1 && ( ( xLen-1 ) *-DNA_GAP_EXT + host.h_busBase[yLen-1].y + DNA_GAP_OPEN == midpoint.score ) ) {
        full_gap = 1;
		next_midpoint.i = midpoint.i;
		next_midpoint.j = baseXr;
		next_midpoint.score = host.h_busBase[yLen-1].y + DNA_GAP_OPEN;
		next_midpoint.type = start_type;
		printf ( "FULL GAP: %d %d %d %d\n", midpoint.i, midpoint.j, start_type, midpoint.score );
    }


    // TODO analisar casos limitrofes. ex.: (i0,j0)=(1,1) - perfect match
    int d;
    dim3  threads ( PHASE2_THREADS_COUNT/*THREADS_COUNT*/, 1, 1 );
    for ( d=0; d<h; d++ ) {
        if ( full_gap ) break;

        if ( blocks == 1 ) {
            dim3  grid ( 1, 1, 1 );
			printf ("KERNEL_NW_SMALL_QUICK(%d,%d,%d,%d,%d,%d,...,%d)\n",i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, d );
			kernel_nw_single_phase<PHASE2_THREADS_COUNT, false><<< grid, threads, 0>>> ( i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, cuda.d_4out, d, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_outV, start_type );
        } else {
			dim3  grid ( blocks, 1, 1 );
            //printf("KERNEL_NW_LARGE_QUICK(%d) xLen: %d  xLen/B: %d  height: %d\n", d, xLen, xLen/N_BLOCKS_COUNT, N_GRID_HEIGHT);
			kernel_nw_short_phase<false><<< grid, threads, 0>>> ( i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, cuda.d_4out, d, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_outV, start_type );
			kernel_nw_long_phase<false><<< grid, threads, 0>>> ( i0r, j0r, baseXr, seq0_len, seq1_len, midpoint.score, cuda.d_4out, d, cuda.d_busH, cuda.d_busV1, cuda.d_busV2, cuda.d_busV3, cuda.d_outV, start_type );
        }

        //printf ( "pos: %d-%d=%d\n", yLen, ALPHA*PHASE2_THREADS_COUNT* ( d+2 ), yLen-ALPHA*PHASE2_THREADS_COUNT* ( d+2 ) );
        pend1 = specialRow->read ( host.h_busBase, yLen-ALPHA*PHASE2_THREADS_COUNT* ( d+2 )-5 );

        if ( d >= blocks ) {

            cudaStreamSynchronize ( 0 );
			if ( 1 && PRINT ) {
				printDebugMatch ( &cuda, baseXr, yLen, i0r, reverse, i0r, j0r, seq_vertical, seq_horizontal, d, blocks, seq0_len, &host );
			}

            int4 found = match_found22 ( seq0_len, yLen, cuda.d_match_out, j0r, i0r, midpoint.score, baseXr, d, host.h_busBase, cuda.d_busBase, cuda.d_outV, blocks );
            if ( found.x < 0 ) {
                fprintf ( stderr, "ERROR: Backtrace lost! Can't continue." );
                exit ( 1 );
            } else if ( found.x > 0 ) {
				next_midpoint.i = found.y;
				next_midpoint.j = found.x;
				next_midpoint.score = found.w;// - ((seq_horizontal_data[baseXr] == seq_vertical_data[midpoint0.i-1]) ? 0 : 4);
				next_midpoint.type = found.z;//inv_type[found.z];
                break;
            }
        }

        /*cutilSafeCall(cudaMemcpy(h_busH, d_busH, (midpoint0.i-baseY+1)*sizeof(cell2_t), cudaMemcpyDeviceToHost));
        for (int i=(midpoint0.i-baseY+1)-10; i<(midpoint0.i-baseY+1); i++) {
         		   printf("%d: %5d %5d\n", i, h_busH[i].x, h_busH[i].y);
        }
        printf("\n");*/

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

    return next_midpoint;
}


void stage3(Job* job) {
	FILE* stats = job->fopenStatistics(STAGE_3);
	
	job->loadMidpoints(1);
	job->loadSpecialRows(STAGE_2);
	job->cells_updates = 0;
	
	int reverse = 0;

	Sequence* seq_vertical;
	Sequence* seq_horizontal;
	if (reverse) {
		seq_vertical = new Sequence(job->seq[1], reverse);
		seq_horizontal = new Sequence(job->seq[0], reverse);
	} else {
		seq_vertical = new Sequence(job->seq[0], reverse);
		seq_horizontal = new Sequence(job->seq[1], reverse);
	}
	
	int seq0_len = seq_vertical->getLen();
	int seq1_len = seq_horizontal->getLen();
	
    MidpointsFile* midpointsFile = job->fopenMidpointsFile(2);

    /*if (reverse) {
        midpoint0.i = job->phase2_j0;
        midpoint0.j = job->phase2_i0;
    } else {
        midpoint0.i = job->phase2_i0;
        midpoint0.j = job->phase2_j0;
    }
    max = job->phase2_max;*/


	fprintf(stats, "SW PARAM: %d/%d/%d/%d\n", DNA_MATCH, DNA_MISMATCH, DNA_GAP_FIRST, DNA_GAP_EXT);
	
	fprintf(stats, "--Alignment sequences:\n", job);
	fprintf(stats, ">%s (%d)\n", job->seq[0].name.c_str(), seq0_len);
	fprintf(stats, ">%s (%d)\n", job->seq[1].name.c_str(), seq1_len);	
	
    selectGPU(job->gpu, stats);

    Timer timer2;

    cudaEvent_t ev_step = timer2.createEvent("STEP");
    cudaEvent_t ev_start = timer2.createEvent("START");
    cudaEvent_t ev_end = timer2.createEvent("END");
    cudaEvent_t ev_copy = timer2.createEvent("COPY");
    cudaEvent_t ev_alloc = timer2.createEvent("ALLOC");
    cudaEvent_t ev_kernel = timer2.createEvent("KERNEL");
    cudaEvent_t ev_writeback = timer2.createEvent("WRITEBACK");

	host_structures_t host;
	cuda_structures_t cuda;
	allocHostStructures(seq_vertical, seq_horizontal, &host);
	allocCudaStructures(seq_vertical, seq_horizontal, &cuda);

	printDevMem(stats);
	
    timer2.eventRecord(ev_start);

    timer2.eventRecord(ev_copy);

    timer2.eventRecord(ev_alloc);



    // setup execution parameters
    dim3  threads_alpha( ALPHA*PHASE2_THREADS_COUNT, 1, 1);

    // execute the kernel
    //int* d_out = (int*)allocCuda0(sizeof(int));
    uint2* d_pos = (uint2*)allocCuda0(sizeof(uint2)*PHASE2_BLOCKS_COUNT);
	
    int line_index=0;//job->special_lines1.size()-1;

	midpoint_t midpoint0;
	midpoint_t midpoint1;
	
	int partition_id = job->midpoints.size()-1;
    //partition_id -= 1;
	midpoint1.i = job->midpoints[partition_id].i;
    midpoint1.j = job->midpoints[partition_id].j;
    midpoint1.type = job->midpoints[partition_id].type;
    midpoint1.score = job->midpoints[partition_id].score;

    while ( partition_id > 0 ) {
        partition_id--;
        midpoint0 = midpoint1;
        midpoint1 = job->midpoints[partition_id];
        midpoint_t midpoint = midpoint0;

		//midpoint.score = midpoint1.score - midpoint0.score;
		midpoint.score = (midpoint1.score + (midpoint1.type == 1 ? DNA_GAP_OPEN : 0)) 
				- (midpoint0.score + (midpoint0.type == 1 ? DNA_GAP_OPEN : 0));
        printf ( "MAX: (%d) %d-%d = %d\n", partition_id, midpoint0.score, midpoint1.score, midpoint.score );
		fprintf(stdout, "Millions Cells Updates: %.3f\n", job->cells_updates/1000000.0f);
		
        /*if ( midpoint0.type == 1 ) {
            if ( midpoint1.type == 0 ) {
                fprintf ( stderr, "PREV_TYPE 1\n" );
                midpoint.score -= DNA_GAP_OPEN;
            }
        }
        if ( midpoint1.type == 1 ) {
            if ( midpoint0.type == 0 ) {
                fprintf ( stderr, "CURR_TYPE 1\n" );
                midpoint.score += DNA_GAP_OPEN;
            }
        }
        if ( midpoint1.type == 1 && midpoint0.type == 1 ) {
            fprintf ( stderr, "CURR_TYPE PREV_TYPE 1\n" );
        }*/
		/*if ( midpoint0.type == 1 ) {
			fprintf ( stderr, "PREV_TYPE 1\n" );
			midpoint.score -= DNA_GAP_OPEN;
		}
		if ( midpoint1.type == 1 ) {
			fprintf ( stderr, "CURR_TYPE 1\n" );
			midpoint.score += DNA_GAP_OPEN;
		}*/
		
/////////


        midpointsFile->write ( midpoint0.i, midpoint0.j, midpoint0.score, midpoint0.type );

        while ( true ) { // todo era pra ser goal != -INF?
            fprintf ( stdout, ">> %d %d %d\n", midpoint.i, midpoint.j, midpoint.score );
            fprintf ( stdout, ">> %08X %08X %d\n", midpoint.i, midpoint.j, midpoint.score );
            SpecialRowReader* specialRow = job->fopenNextSpecialRow ( STAGE_2, midpoint.i, midpoint.j, PHASE2_THREADS_COUNT, &line_index );
            if ( specialRow == NULL ) {
                printf ( "No more special Rows.. (?)\n" );
                midpoint = midpoint1;
                midpoint.score = 0;
                break;
            }
            midpoint = find_next_midpoint22 ( job, seq_vertical, seq_horizontal, reverse, midpoint, midpoint1, host, cuda, specialRow );
            if ( midpoint.score==0 ) break;
            //cutilSafeCall(cudaUnbindTexture(t_busH)); // TODO necessario?

            specialRow->close();
#ifdef SW_BUS_FLUSH
            //unflush_bus(baseX);
#endif
            int goal_adj = midpoint1.score - midpoint.score + ( midpoint1.type==0?0:DNA_GAP_OPEN );
            static int inv_type[] = {0,2,1};
            int type_adj = inv_type[midpoint.type];
            midpointsFile->write ( midpoint.i, midpoint.j, goal_adj, type_adj );
        }
    }

//////////

    timer2.eventRecord(ev_kernel);
    //cudaEventRecord(ev_kernel,0);
    /*fprintf(stderr, "%d,%d,%d,%d\n", midpoint1.type, midpoint1.i, midpoint1.j, midpoint1.score);
    fprintf(partitions_file, "%d,%d,%d,%d\n", midpoint1.type, midpoint1.i, midpoint1.j, midpoint1.score);*/
    /*fprintf(stderr, "START\n");
    fprintf(partitions_file, "START\n");
    fclose(partitions_file);*/
    midpointsFile->write(midpoint1.i, midpoint1.j, midpoint1.score, midpoint1.type);
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
