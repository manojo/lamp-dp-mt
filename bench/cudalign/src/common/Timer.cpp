/* 
 * File:   Timer.cpp
 * Author: edans
 * 
 * Created on April 12, 2010, 12:51 AM
 */

#include "Timer.hpp"

Timer::Timer() {
    /*unsigned int timer = 0;
    cutilCheckError( cutCreateTimer( &timer));
    cutilCheckError( cutStartTimer( timer));*/
	hasEvent = 0;

    cudaEventCreate(&repeatedEvent);
	cudaEventCreate(&startEvent);
	cudaEventCreate(&intervalEvent);
	cudaEventRecord(startEvent, 0);
	cudaEventRecord(intervalEvent, 0);
}

Timer::Timer(const Timer& orig) {
}

Timer::~Timer() {
}

cudaEvent_t Timer::createEvent(string name) {
    cudaEvent_t event;
    cudaEventCreate(&event);
    events.push_back(event);
    stat_t stat;
    stat.name = name;
    stat.sum = 0;
    stat.count = 0;
    stats[event] = stat;
    printf("Create Event: %d %s\n", event, name.c_str());
	
    return event;

}


float Timer::eventRecord(cudaEvent_t event, cudaStream_t stream) {
    float diff = 0;
    cudaEvent_t currentEvent;
    if (lastEvent == event) {
        currentEvent = repeatedEvent;
    } else {
        currentEvent = event;
    }
    cudaEventRecord(currentEvent, stream);
    cudaStreamSynchronize(stream);
	if (hasEvent) {
        cudaEventElapsedTime(&diff, lastEvent, currentEvent);
        stats[event].sum += diff;
        stats[event].count++;
    }
    //printf("Event Record: %d %d %f (%d)\n", currentEvent, lastEvent, diff, stream);
    lastEvent = currentEvent;
	hasEvent = true;
    return diff;
}

float Timer::totalTime(int stream) {
	float diff;
	cudaEventElapsedTime(&diff, startEvent, lastEvent);
	return diff/1000;
}

bool Timer::intervalElapsed ( float interval ) {
	float diff;
	cudaEventElapsedTime(&diff, intervalEvent, lastEvent);
	if (diff/1000 >= interval) {
		//printf("OK||||||\n");
		cudaEventRecord(intervalEvent, 0);
		return true;
	} else {
		//printf("%f - %f\n", diff/1000, interval);
		return false;
	}
}


float Timer::printStatistics(FILE* file) {
    vector<cudaEvent_t>::iterator it;

    float sum = 0;
    for (it=events.begin() ; it != events.end(); it++) {
        stat_t stat = stats[*it];
		fprintf(file, "%15s: %12.4f (%4d)  avg.: %8.4f\n", stat.name.c_str(), stat.sum, stat.count, stat.sum/stat.count);
        sum += stat.sum;
    }
	fprintf(file, "%15s: %12.4f\n", "TOTAL", sum);
    return sum;
}


