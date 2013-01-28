#ifndef FILEBUFFER_H
#define FILEBUFFER_H

#include "Buffer.hpp"
#include <stdio.h>
#include <string>
using namespace std;

class FileBuffer : public Buffer
{

    public:
        FileBuffer(string filename);
        virtual ~FileBuffer();
        
        virtual void initAutoFlush();
        virtual void initAutoLoad();

        virtual void autoFlushThread();
        virtual void autoLoadThread();

    private:
        string filename;
        FILE* file;

};

#endif // FILEBUFFER_H
