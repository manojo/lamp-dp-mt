/*
 * File:   Sequence.hpp
 * Author: edans
 *
 * Created on April 11, 2010, 3:22 AM
 */

#ifndef _SEQUENCE_HPP
#define	_SEQUENCE_HPP

#include <vector>
#include <string>
using namespace std;

#define FLAG_CLEAR_N	0x0004
#define FLAG_COMPLEMENT	0x0002
#define FLAG_REVERSE	0x0001

class Sequence {
    public:
        Sequence();
        Sequence ( const Sequence& orig, int reverse );
        virtual ~Sequence();
		void readFile ( char* filename, const int flags=0);
		void trim (int delta0, int delta1);
		void untrim();
		void reverse();
        int getLen() const;
        string name;
        char* forward_data;
        char* reverse_data;
		string accession;
    private:
		int offset0;
		int offset1;
		int len;
        vector<char> data_vector;
        int original_len;
        char* original_forward_data;
        char* original_reverse_data;
};

#endif	/* _SEQUENCE_HPP */

