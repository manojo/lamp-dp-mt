/* 
 * File:   SpecialLine.hpp
 * Author: edans
 *
 * Created on April 8, 2010, 10:42 PM
 */

#ifndef _SPECIALLINE_HPP
#define	_SPECIALLINE_HPP

#include <stdio.h>
#include <string>
#include <vector>
using namespace std;

class SpecialRowReader {
public:
    SpecialRowReader(string directory, int row, int col);
    SpecialRowReader(const SpecialRowReader& orig);
    virtual ~SpecialRowReader();

    int getCol() const;
    int getRow() const;

    void open(void* buf, int start=0);
    void close();
    int read(void* buf, int offset);
    int getCurrentPosition();

    static vector<SpecialRowReader*>* loadSpecialRows(string directory, int reverse);

private:
    int row;
    int col;
    string directory;
    FILE* file;
    int element_size;
    int start;
    int min_step;
    int current;
};

#endif	/* _SPECIALLINE_HPP */

