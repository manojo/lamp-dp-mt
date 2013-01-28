#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


#include "Buffer.h"
#include "PipedBuffer.h"
#include "CircularBuffer.h"

Buffer* b = NULL;


pthread_mutex_t fakeMutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t fakeCond = PTHREAD_COND_INITIALIZER;

void mywait(int timeInSec)
{
	struct timespec timeToWait;
	struct timeval now;
	int rt;
	
	gettimeofday(&now,NULL);
	
	timeToWait.tv_sec = now.tv_sec + timeInSec;
	timeToWait.tv_nsec = now.tv_usec*1000;
	
	pthread_mutex_lock(&fakeMutex);
	rt = pthread_cond_timedwait(&fakeCond, &fakeMutex, &timeToWait);
	pthread_mutex_unlock(&fakeMutex);
	//printf("Done\n");
}



void *writeThread(void *arg)
{
	Buffer* b = (Buffer*)arg;
	const int c = 16;
	char buf[c];
	for (int i=0; i<c; i++) {
		buf[i] = i%100;
	}
	
	for (int j=0; j<1000; j++) {
		int rc = b->writeBuffer(buf, c);
		printf ("WRITE(%d): %d\n", j*c, rc);
	}
	
	pthread_exit(NULL);
}

void *readThread(void *arg)
{
	Buffer* b = (Buffer*)arg;
	const int c = 11;
	char buf[c];
	
	int k=0;
	
	for (int j=0; j<1000; j++) {
		int rc = b->readBuffer(buf, c);
		printf ("READ(%d): %d\n", j*c, rc);
		for (int i=0; i<c; i++) {
			if (buf[i]!=(k%16)%100) {
				printf("%d %d = %s\n", buf[i], (k%16)%100, "ERRO");
			} else {
				//printf("%d %d = %s\n", buf[i], (k%16)%100, ".");
			}
			k++;
		}
		printf("\n");
		mywait(1);
	}
	
	pthread_exit(NULL);
}

int main (int argc, char *argv[])
{
	Buffer* b = new CircularBuffer();
	pthread_t threads[2];
	int rc;
	long t;
	
	rc = pthread_create(&threads[0], NULL, writeThread, (void *)b);
	if (rc){
		printf("ERROR; return code from pthread_create() is %d\n", rc);
		exit(-1);
	}
	rc = pthread_create(&threads[1], NULL, readThread, (void *)b);
	if (rc){
		printf("ERROR; return code from pthread_create() is %d\n", rc);
		exit(-1);
	}
	
	void* status;
	rc = pthread_join(threads[0], &status);
	rc = pthread_join(threads[1], &status);
	
	delete b;
	
	pthread_exit(NULL);
}
