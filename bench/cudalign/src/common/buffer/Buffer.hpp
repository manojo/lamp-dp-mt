#ifndef BUFFER_H
#define BUFFER_H

#include <pthread.h>

class Buffer
{
public:
	Buffer();
	virtual ~Buffer();
	
	int readBuffer(char* data, int size, int nmemb);
	int writeBuffer(char* data, int size, int nmemb);
	
	void destroy();
	bool isDestroyed();

    virtual void autoFlushThread() = 0;
    virtual void autoLoadThread() = 0;
    
    virtual void initAutoFlush() = 0;
    virtual void initAutoLoad() = 0;

    
	void autoFlush();
	void autoLoad();
	
	private:
		pthread_mutex_t mutex;
		pthread_cond_t notFullCond;
		pthread_cond_t notEmptyCond;
		
		bool destroyed;
		
		char* buffer;
		int buffer_size;
		int buffer_start;
		int buffer_end;
		int buffer_max;

        pthread_t threadId;
        
		int circularLoad(char *dst, int len);
		int circularStore(char *src, int len);
		int sizeUsed();
		int sizeAvailable();

        static void* staticFlushThread(void *arg);
        static void* staticLoadThread(void *arg);

        void createAutoLoadThread();
        void createAutoFlushThread();
};

#endif // BUFFER_H
