/*
 * File:   Job.hpp
 * Author: edans
 *
 * Created on April 8, 2010, 11:00 PM
 */
class Job;

#ifndef _JOB_HPP
#define	_JOB_HPP

#include <string>
#include <vector>
using namespace std;

#include "Sequence.hpp"
#include "SpecialRowReader.hpp"
#include "SpecialRowWriter.hpp"
#include "MidpointsFile.hpp"
#include "Alignment.hpp"
#include "buffer/Buffer.hpp"

#define STAGE_1   (1)
#define STAGE_2   (2)
#define STAGE_3   (3)
#define STAGE_4   (4)
#define STAGE_5   (5)
#define STAGE_6   (6)

class Job {
    public:
        int blocks;
        
        Sequence seq[2];

        vector<SpecialRowReader*>* special_lines1;
        vector<SpecialRowReader*>* special_lines2;
		
        vector<midpoint_t> midpoints;

        long long flush_limit;
        int flush_interval;
		
		string flush_column_url;
		string load_column_url;
		
		int gpu;
		
		long long cells_updates;

        int stage4_maximum_partition_size;
		bool stage4_orthogonal_execution;

		int stage6_output_format;
		Alignment* alignment;
		
        string alignment_binary_filename;
		string alignment_text_filename;
		string alignment_svg_filename;
		
        Job();
        Job ( const Job& orig );
        virtual ~Job();

		void createPath(string path);
        void setWorkPath ( string workPath );
        string getWorkPath ( );
        int initialize();

		Buffer* loadBufferFromURL(string url);
		
        void loadSpecialRows ( int stage_id );
        void loadMidpoints ( int id );
        void writeMidpoints ( int id = -1 );
        int getLargestMidpointSize ( int* max_i = NULL, int* max_j = NULL );
		int getLargestSpecialRowInterval ( int stage_id, int* max_i = NULL, int* max_j = NULL );

		SpecialRowWriter* fopenNewSpecialRow  ( int stage_id, int row, int col );
		SpecialRowReader* fopenNextSpecialRow ( int stage_id, int row, int col, int min_dist, int *id );
		FILE* fopenSpecialRow ( int stage_id, int row, int col, const char* mode );
        FILE* fopenFirstMidpoint();
		FILE* fopenStatistics ( int stage_id );
        MidpointsFile* fopenMidpointsFile ( int midpoint_id = -1 );
    private:
        string statistics_filename;
        string status_filename;
        string info_filename;
        string midpoints_path;

        FILE* fopenMidpoints ( int midpoint_id, const char* mode );
        int last_midpoint_id;

        string work_path;
        string special1_path;
        string special2_path;

        void initializeWorkPath();
};

#endif	/* _JOB_HPP */

