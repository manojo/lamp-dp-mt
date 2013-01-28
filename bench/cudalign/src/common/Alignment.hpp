/* 
 * File:   Alignment.hpp
 * Author: edans
 *
 * Created on April 11, 2010, 6:51 PM
 */
class Alignment;

#ifndef _ALIGNMENT_HPP
#define	_ALIGNMENT_HPP

#include <string>
using namespace std;

#include "Job.hpp"

struct gap_sequence_t {
	int i0;
	int j0;
	int i1;
	int j1;
	int type() {
		if (i0==i1) return 1;
		if (j0==j1) return 2;
		return 0; //TODO ERROR
	}
	
	int len() {
		return (i1-i0)+(j1-j0);
	}
};	

struct gap_t {
	int pos;
	int len;
};

class Alignment {
public:
	int i0;
	int j0;
	int i1;
	int j1;
	
    Alignment(Job* job);
    Alignment(const Alignment& orig);
    virtual ~Alignment();

    void addGapInSeq0(int i);
    void addGapInSeq1(int j);
    void finalize(int i0, int j0, int i1, int j1);
	bool isFinalized();

    void printBinary(string filename);
	void loadBinary(string filename);
	
	vector<gap_sequence_t>* getGapSequences();
	vector<gap_t> getGapsInSeq0(){return gaps[0];}
	vector<gap_t> getGapsInSeq1(){return gaps[1];}
	
private:

	
	bool alignmentFinalized;
    Job* job;

    vector<gap_t> gaps[2];
	vector<gap_sequence_t> gap_sequences;

    void addGap(int seq, int i);
    void fwrite_str(const char* str, FILE* file);
    void fread_str(string str, FILE* file);
    void fwrite_gaps(vector<gap_t>* gaps, FILE* file);
	void fread_gaps(vector<gap_t>* gaps, FILE* file);
};

#endif	/* _ALIGNMENT_HPP */

