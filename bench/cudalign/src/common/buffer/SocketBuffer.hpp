#ifndef SOCKETBUFFER_H
#define SOCKETBUFFER_H

#include "Buffer.hpp"
#include <string>
using namespace std;

class SocketBuffer : public Buffer
{
    public:
        SocketBuffer(string hostname, int port);
        virtual ~SocketBuffer();
        
        virtual void initAutoFlush();
        virtual void initAutoLoad();
        
        virtual void autoFlushThread();
        virtual void autoLoadThread();
        
    private:
        string hostname;
        int port;
        int socketfd;
};

#endif // SOCKETBUFFER_H
