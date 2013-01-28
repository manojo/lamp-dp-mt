/*
 * File:   SpecialRowWriter.cpp
 * Author: edans
 *
 * Created on April 9, 2010, 11:59 PM
 */

#include "SpecialRowWriter.hpp"

#include <stdio.h>
#include <string.h>
#include <cuda_runtime_api.h>

SpecialRowWriter::SpecialRowWriter(string _directory, int _row, int _col)
        : directory(_directory), row(_row), col(_col){
}

SpecialRowWriter::SpecialRowWriter(const SpecialRowWriter& orig) {
}

SpecialRowWriter::~SpecialRowWriter() {
    close();
}

int SpecialRowWriter::getCol() const {
    return col;
}

int SpecialRowWriter::getRow() const {
    return row;
}

void SpecialRowWriter::open() {
    this->element_size = sizeof(int2);

    char str[500];
    sprintf(str, "%s/tmp.%08X.%08X", directory.c_str(), row, col);
    //printf("%s\n", str);
    this->file = fopen(str, "wb");
}

void SpecialRowWriter::close() {
    if (file != NULL) {
        fclose(file);
        file = NULL;

        char old_path[500];
        char new_path[500];
        sprintf(old_path, "%s/tmp.%08X.%08X", directory.c_str(), row, col);
        sprintf(new_path, "%s/%08X.%08X", directory.c_str(), row, col);
        rename(old_path, new_path);
    }
}

void SpecialRowWriter::cancel() {
    if (file != NULL) {
        fclose(file);
        file = NULL;

        char old_path[500];
        sprintf(old_path, "%s/tmp.%08X.%08X", directory.c_str(), row, col);
        printf("Removing... %s\n", old_path);
        remove(old_path);
        printf("Removed %s\n", old_path);
    }
}

int SpecialRowWriter::write(void* buf, int nmemb) {
    //printf("write(%X, %d)  %X\n", buf, nmemb, file);
    fwrite(buf, element_size, nmemb, file);
}
