/* 
 * File:   PartitionsFile.cpp
 * Author: edans
 * 
 * Created on June 8, 2010, 8:34 AM
 */

#include "MidpointsFile.hpp"

MidpointsFile::MidpointsFile(string _directory, int _id) 
        : directory(_directory), id(_id) {
    open();
}

MidpointsFile::MidpointsFile(const MidpointsFile& orig) {
}

MidpointsFile::~MidpointsFile() {
}

void MidpointsFile::open() {
    char str[500];
    sprintf(str, "%s/tmp.midpoint_%02d", directory.c_str(), id);
    //printf("%s\n", str);
    file = fopen(str, "wb");

    fprintf(stderr, "START\n");
    fprintf(file, "START\n");
}

void MidpointsFile::close() {
    if (file != NULL) {
        fprintf(stderr, "END\n");
        fprintf(file, "END\n");

        fclose(file);
        file = NULL;

        char old_path[500];
        char new_path[500];
		sprintf(old_path, "%s/tmp.midpoint_%02d", directory.c_str(), id);
		sprintf(new_path, "%s/midpoint_%02d", directory.c_str(), id);
        rename(old_path, new_path);
    }
}

void MidpointsFile::write(int i, int j, int score, int type) {
    fprintf(file, "%d,%d,%d,%d\n", type, i, j, score);
    fprintf(stderr, "%d,%d,%d,%d\n", type, i, j, score);
    fflush(file);
}
