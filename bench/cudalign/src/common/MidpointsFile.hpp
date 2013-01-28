/*
 * File:   MidpointsFile.hpp
 * Author: edans
 *
 * Created on June 8, 2010, 8:34 AM
 */

#ifndef _MIDPOINTSFILE_HPP
#define	_MIDPOINTSFILE_HPP

#include <stdio.h>
#include <vector>
#include <string>
using namespace std;

typedef struct {
    int i;
    int j;
    int type;
    int score;
	
	void reverse(int seq0_len, int seq1_len) {
		int aux = i;
		i = seq0_len-j;
		j = seq1_len-aux;
	}
} midpoint_t;

class MidpointsFile {
    public:
        MidpointsFile ( string _directory, int _id );
        MidpointsFile ( const MidpointsFile& orig );
        virtual ~MidpointsFile();
        void close();
        void write ( int i, int j, int score, int type );
    private:
        int id;
        string directory;
        vector<midpoint_t> midpoints;
        void open();
        FILE* file;
};

#endif	/* _MIDPOINTSFILE_HPP */

