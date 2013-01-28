/*
 * File:   Timer.hpp
 * Author: edans
 *
 * Created on April 12, 2010, 12:51 AM
 */

#ifndef _TIMER_HPP
#define	_TIMER_HPP

#include <vector>
#include <map>
#include <string>
using namespace std;
#include <cuda_runtime_api.h>

class Timer {
public:
    Timer();
    Timer(const Timer& orig);
    virtual ~Timer();

    cudaEvent_t createEvent(string name);
	float eventRecord(cudaEvent_t event, cudaStream_t stream=0);
    float printStatistics(FILE* file=stdout);
	float totalTime(int stream=0);
    bool intervalElapsed ( float interval );
private:
    struct stat_t {
        string name;
        float sum;
        int count;
    };
	bool hasEvent;
    cudaEvent_t lastEvent;
    cudaEvent_t repeatedEvent;
	cudaEvent_t intervalEvent;
	cudaEvent_t startEvent;

    vector<cudaEvent_t> events;
    map<cudaEvent_t, stat_t> stats;
};

#endif	/* _TIMER_HPP */

