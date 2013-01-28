#include "Buffer.hpp"

#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//#include <sys/time.h>


Buffer::Buffer() {
    buffer_max = 8*1024*1024;
    buffer_size = buffer_max+5;
    buffer_start = 0;
    buffer_end = 0;
    buffer = (char*)malloc(buffer_size);
    destroyed = false;

	pthread_mutex_init(&mutex,NULL);
	pthread_cond_init(&notFullCond,NULL);
    pthread_cond_init(&notEmptyCond,NULL);
}

Buffer::~Buffer() {
    fprintf(stderr, "Destruct Buffer...\n");
    free(buffer);
}

void Buffer::destroy() {
    destroyed = true;
    pthread_cond_signal(&notFullCond);
    pthread_cond_signal(&notEmptyCond);
    pthread_join(threadId, NULL);
}

bool Buffer::isDestroyed() {
    return destroyed;
}

int Buffer::circularLoad(char *dst, int len) {

    if (buffer_start+len < buffer_size) {
        memcpy(dst, buffer+buffer_start, len);
        //memset(buffer+buffer_start, 0, len); // TODO remover
        buffer_start += len;
    } else {
        memcpy(dst, buffer+buffer_start, buffer_size-buffer_start);
        memcpy(dst+(buffer_size-buffer_start), buffer, len-(buffer_size-buffer_start));
        buffer_start = len-(buffer_size-buffer_start);
    }
    if (len > 0) {
        pthread_cond_signal(&notFullCond);
    }
    return len;
}

int Buffer::circularStore(char *src, int len) {
    if (buffer_end+len < buffer_size) {
        memcpy(buffer+buffer_end, src, len);
        buffer_end += len;
    } else {
        memcpy(buffer+buffer_end, src, buffer_size-buffer_end);
        memcpy(buffer, src+(buffer_size-buffer_end), len - (buffer_size-buffer_end));
        buffer_end = len - (buffer_size-buffer_end);
    }
    if (len > 0) {
        pthread_cond_signal(&notEmptyCond);
    }
    return len;
}

int Buffer::sizeAvailable() {
    return buffer_max - sizeUsed();
}

int Buffer::sizeUsed() {
    if (buffer_end >= buffer_start) {
        return buffer_end - buffer_start;
    } else {
        return buffer_end - buffer_start + buffer_size;
    }
}

int Buffer::readBuffer(char* data, int size, int nmemb)
{
    pthread_mutex_lock(&mutex);
    int size_total = size*nmemb;
    int size_left = size_total;
    while ((sizeUsed() < size_left) && !destroyed) {
        size_left -= circularLoad((char*)data+(size_total-size_left), sizeUsed());
        pthread_cond_wait (&notEmptyCond, &mutex);
    }
    if (!destroyed) {
        size_left -= circularLoad((char*)data+(size_total-size_left), size_left);
    }
    pthread_mutex_unlock(&mutex);

    if (size_left != 0) fprintf(stderr, "readBuffer: diff len: %d %d\n", size_total-size_left, size_total);

    return size_total-size_left;
}

int Buffer::writeBuffer(char* data, int size, int nmemb)
{
    pthread_mutex_lock(&mutex);
    int size_total = size*nmemb;
    int size_left = size_total;
    while ((sizeAvailable() < size_left) && !destroyed) {
        size_left -= circularStore(data+(size_total-size_left), sizeAvailable());
        pthread_cond_wait (&notFullCond, &mutex);
    }
    if (!destroyed) {
        size_left -= circularStore(data+(size_total-size_left), size_left);
    }
    pthread_mutex_unlock(&mutex);
    if (size_left != 0) fprintf(stderr, "writeBuffer: diff len: %d %d\n", size_total-size_left, size_total);
    return size_total-size_left;
}

void Buffer::autoFlush() {
    initAutoFlush();
    createAutoFlushThread();
}

void Buffer::autoLoad() {
    initAutoLoad();
    createAutoLoadThread();
}



void Buffer::createAutoLoadThread() {
    int rc = pthread_create(&threadId, NULL, staticLoadThread, (void *)this);
    if (rc){
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
    }
}

void Buffer::createAutoFlushThread() {
    int rc = pthread_create(&threadId, NULL, staticFlushThread, (void *)this);
    if (rc){
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
    }
}

void *Buffer::staticFlushThread(void *arg) {
    Buffer* buffer = (Buffer*)arg;
    buffer->autoFlushThread();
}

void *Buffer::staticLoadThread(void *arg) {
    Buffer* buffer = (Buffer*)arg;
    buffer->autoLoadThread();
}
