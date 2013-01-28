#pragma once


/*
 * GPU      THREADS_LOG     BLOCKS_LOG
 * 8600GT      6                4
 * GTX260      6                10
 * GTX280      6                9
 */

//#define THREADS_LOG     6

#define MIN_BLOCKS_PER_SM 4

//#define THREADS_LOG     6
//#define THREADS_COUNT   (1<<THREADS_LOG) 
//#define THREADS_MASK    (THREADS_COUNT-1)
#define THREADS_COUNT 64

//#define BLOCKS_LOG      10
#define BLOCKS_COUNT    512//(27*8)//(1<<BLOCKS_LOG)
//#define BLOCKS_MASK     (BLOCKS_COUNT-1)

#define ALPHA (4)

#define GRID_HEIGHT     (THREADS_COUNT*BLOCKS_COUNT)
//#define GRID_MASK       (GRID_HEIGHT-1)

#define MULTIPROCESSORS	(27)

#define PHASE2_THREADS_COUNT   (128)
#define PHASE2_BLOCKS_COUNT  (MULTIPROCESSORS*4)

//#define PHASE2_THREADS_COUNT   (32)
//#define PHASE2_BLOCKS_COUNT  (27)

//#define PHASE2_THREADS_COUNT   (16)
//#define PHASE2_BLOCKS_COUNT  (4)

#define PHASE2_GRID_HEIGHT   (PHASE2_BLOCKS_COUNT*PHASE2_THREADS_COUNT)


