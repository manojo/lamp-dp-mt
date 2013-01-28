/*
 * File:   SpecialLine.cpp
 * Author: edans
 *
 * Created on April 8, 2010, 10:42 PM
 */

#include "SpecialRowReader.hpp"

#include <string.h>
#include <cuda_runtime_api.h>

#include <algorithm>
using namespace std;

#include <dirent.h>


SpecialRowReader::SpecialRowReader(string _directory, int _row, int _col)
        : directory(_directory), row(_row), col(_col){
}

SpecialRowReader::SpecialRowReader(const SpecialRowReader& orig) {
}

SpecialRowReader::~SpecialRowReader() {
    close();
}

int SpecialRowReader::getCol() const {
    return col;
}

int SpecialRowReader::getRow() const {
    return row;
}

void SpecialRowReader::open(void* buf, int start) {
    this->start = start;
    this->current = start;
    this->min_step = 2*1024;
    this->element_size = sizeof(int2);
    memset((char*)buf+start*element_size, 0x80, element_size);//TODO why???

    char str[500];
    sprintf(str, "%s/%08X.%08X", directory.c_str(), row, col);
    printf("%s\n", str);
    this->file = fopen(str, "rb");
    if (file == NULL) {
        printf("Null file: %s\n", str);
    }
}

void SpecialRowReader::close() {
    if (file != NULL) {
        printf("File Close: %p\n", file);
        fclose(file);
        file = NULL;
    }
}

int SpecialRowReader::getCurrentPosition() {
    return current;
}

int SpecialRowReader::read(void* buf, int offset) {
    if (offset < current) {
        int diff = current-offset;
        if (diff < min_step) {
            diff = min_step;
        }
        int p0 = current-diff;
        if (p0<0) p0=0;
        diff = current-p0;
        if (file == NULL) {
            memset((char*)buf+p0*element_size, 0, diff*element_size);
        } else {
            fseek(file, p0*element_size, SEEK_SET);
            int r=0;
            while (r<diff) {
                int ret = fread((char*)buf+(p0+r)*element_size, element_size, diff, file);
                //if (ret == 0) break;
                r += ret;
                //printf("%d/%d/%d/%d/%d\n", ret, r, diff, p0, current);
            }
            //printf("READ [%d..%d]   pos: %d\n", p0, p0+diff, offset);
        }
        current = p0;
        return diff;
    }
    return 0;
}

static int sortf_fwd(SpecialRowReader* a, SpecialRowReader* b) {
    if (a->getRow() != b->getRow()) {
        return a->getRow() < b->getRow();
    } else {
        return a->getCol() < b->getCol();
    }
}

static int sortf_rev(SpecialRowReader* a, SpecialRowReader* b) {
    if (a->getRow() != b->getRow()) {
        return a->getRow() > b->getRow();
    } else {
        return a->getCol() > b->getCol();
    }
}

/* static */
vector<SpecialRowReader*>* SpecialRowReader::loadSpecialRows(string directory, int reverse) {
    DIR *dir = NULL;

    dir = opendir (directory.c_str());
    struct dirent *dp;          /* returned from readdir() */

    if (dir == NULL) {
        exit(1); // TODO mensagem de erro
        /* opendir() failed */
    }

    vector<SpecialRowReader*>* specialRowReaders = new vector<SpecialRowReader*>();
    while ((dp = readdir (dir)) != NULL) {
        //printf("%s\n", dp->d_name);
        int row;
        int col;
        if (sscanf(dp->d_name, "%X.%X", &row, &col) == 2) {
            //printf("%s: (%d,%d)\n", dp->d_name, pos.i, pos.j);
            specialRowReaders->push_back(new SpecialRowReader(directory, row, col));
        }
    }
    specialRowReaders->push_back(new SpecialRowReader(directory, 0, 0));

    closedir (dir);
    if (reverse) {
        sort(specialRowReaders->begin(), specialRowReaders->end(), sortf_rev);
    } else {
        sort(specialRowReaders->begin(), specialRowReaders->end(), sortf_fwd);
    }


    vector<SpecialRowReader*>::iterator it;
    for (it=specialRowReaders->begin() ; it < specialRowReaders->end(); it++) {
        printf ("(%08X.%08X)\n", (*it)->getRow(), (*it)->getCol());
    }
    return specialRowReaders;
}
