#include "FileBuffer.hpp"

#include <stdlib.h>


FileBuffer::FileBuffer(string filename) {
    this->filename = filename;
}

FileBuffer::~FileBuffer() {
    if (file != NULL) {
        Buffer::destroy();
        fclose(file);
        file == NULL;
    }
}

void FileBuffer::autoFlushThread() {
    char data[16*1024];
    
    while (!isDestroyed()) {
        int len = readBuffer(data, 1, sizeof(data));
        fwrite(data, 1, len, file);
    }
}

void FileBuffer::autoLoadThread() {
    char data[512];
    
    while (!isDestroyed()) {
        int len = fread(data, 1, sizeof(data), file);
        if (len <= 0) break;
        writeBuffer(data, 1, len);
    }
}

void FileBuffer::initAutoLoad() {
    file = fopen(filename.c_str(), "r");
    if (file == NULL) {
        fprintf(stderr, "File not found (%s).", filename.c_str());
        exit(1);
    }
}

void FileBuffer::initAutoFlush() {
    file = fopen(filename.c_str(), "w");
    if (file == NULL) {
        fprintf(stderr, "File not found (%s).", filename.c_str());
        exit(1);
    }
}

