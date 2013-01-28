/* 
 * File:   SpecialRowWriter.hpp
 * Author: edans
 *
 * Created on April 9, 2010, 11:59 PM
 */

#ifndef _SPECIALROWWRITER_HPP
#define	_SPECIALROWWRITER_HPP

#include <stdio.h>
#include <string>
using namespace std;

class SpecialRowWriter {
public:
    SpecialRowWriter(string directory, int row, int col);
    SpecialRowWriter(const SpecialRowWriter& orig);
    virtual ~SpecialRowWriter();

    int getCol() const;
    int getRow() const;

    void open();
    void close();
    void cancel();

    int write(void* buf, int len);
private:
    int row;
    int col;
    string directory;
    FILE* file;
    int element_size;
};

#endif	/* _SPECIALROWWRITER_HPP */

