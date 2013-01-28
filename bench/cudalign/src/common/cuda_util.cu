#include <cutil_inline.h>

#include "cudalign.hpp"


#include <sys/time.h>
#include <sys/resource.h>

unsigned char* allocCudaSeq(Sequence* seq, int offset) {
	printf("%X\n", seq);
	int len = seq->getLen()-offset;
	printf("allocCudaSeq(...): %d\n", len+GRID_HEIGHT);
	unsigned char* out = (unsigned char*)allocCuda0(len+GRID_HEIGHT);
	printf("allocCudaSeq(...): %d: OK (%X)\n", len+GRID_HEIGHT, out);
	//cutilSafeCall( cudaMalloc((void**) &out, seq->getLen()+GRID_HEIGHT-offset));
	cutilSafeCall( cudaMemcpy(out, seq->forward_data+offset, len, cudaMemcpyHostToDevice));
    return out;
}

unsigned char* allocCudaSeq(Sequence* seq) {
    return allocCudaSeq(seq, 0);
}

/*unsigned char* allocCudaSeqRev(Sequence* seq, int offset) {
    unsigned char* out;
    printf("allocCudaSeqRev(...): %d\n", seq->getLen()+GRID_HEIGHT-offset);
    cutilSafeCall( cudaMalloc((void**) &out, seq->getLen()+GRID_HEIGHT-offset));
    cutilSafeCall( cudaMemcpy(out, seq->reverse_data+offset, seq->getLen()+GRID_HEIGHT-offset, cudaMemcpyHostToDevice));
    return out;
}

unsigned char* allocCudaSeqRev(Sequence* seq) {
    return allocCudaSeqRev(seq, 0);
}*/

void* allocCuda(void* in, int size) {
    unsigned char* out;
    printf("allocCuda(...,%d)\n", size);
    cutilSafeCall( cudaMalloc((void**) &out, size));
    cutilSafeCall( cudaMemcpy(out, in, size, cudaMemcpyHostToDevice));
    return out;
}

void* allocCuda0(int size) {
    void* out;
    printf("allocCuda0(...,%d)\n", size);
    cutilSafeCall( cudaMalloc((void**) &out, size));
    cutilSafeCall( cudaMemset(out, 0, size));
    return out;
}

void deallocCuda(void* var, int size, void* out) {
    cutilSafeCall(cudaMemcpy( out, var, size, cudaMemcpyDeviceToHost));
    cutilSafeCall(cudaFree(var));
}

int tempIntCuda(int* var) {
    int out;
    cutilSafeCall(cudaMemcpy(&out, var, sizeof(int), cudaMemcpyDeviceToHost));
    return out;
}

void printDevProp(cudaDeviceProp devProp, FILE* file) {
	fprintf(file, "Major revision number:         %d\n",  devProp.major);
	fprintf(file, "Minor revision number:         %d\n",  devProp.minor);
	fprintf(file, "Name:                          %s\n",  devProp.name);
	fprintf(file, "Total global memory:           %u\n",  devProp.totalGlobalMem);
	fprintf(file, "Total shared memory per block: %u\n",  devProp.sharedMemPerBlock);
	fprintf(file, "Total registers per block:     %d\n",  devProp.regsPerBlock);
	fprintf(file, "Warp size:                     %d\n",  devProp.warpSize);
	fprintf(file, "Maximum memory pitch:          %u\n",  devProp.memPitch);
	fprintf(file, "Maximum threads per block:     %d\n",  devProp.maxThreadsPerBlock);
	for (int i = 0; i < 3; ++i)
		fprintf(file, "Maximum dimension %d of block:  %d\n", i, devProp.maxThreadsDim[i]);
	for (int i = 0; i < 3; ++i)
		fprintf(file, "Maximum dimension %d of grid:   %d\n", i, devProp.maxGridSize[i]);
	fprintf(file, "Clock rate:                    %d\n",  devProp.clockRate);
	fprintf(file, "Total constant memory:         %u\n",  devProp.totalConstMem);
	fprintf(file, "Texture alignment:             %u\n",  devProp.textureAlignment);
	fprintf(file, "Concurrent copy and execution: %s\n",  (devProp.deviceOverlap ? "Yes" : "No"));
	fprintf(file, "Number of multiprocessors:     %d\n",  devProp.multiProcessorCount);
	fprintf(file, "Kernel execution timeout:      %s\n",  (devProp.kernelExecTimeoutEnabled ? "Yes" : "No"));
	return;
}

void printGPUDevices(FILE* file) {
    int count;
    cudaGetDeviceCount(&count);
    cudaDeviceProp devProp;
    fprintf(file, "Available GPUs:\n");
    fprintf(file, "ID: NAME (RAM)\n");
    fprintf(file, "---------------------------\n");
    for (int deviceId=0; deviceId<count; deviceId++) {
        cudaGetDeviceProperties(&devProp, deviceId);
        fprintf(file, "%2d: %s (%d MB) %s\n", deviceId, devProp.name,
                (int)ceil(devProp.totalGlobalMem/1024.0/1024.0),
                devProp.kernelExecTimeoutEnabled ? "(Timeout Enabled)":""
                );
    }
    fprintf(file, "\n");
}

int getGPUProportion(int* proportion, int n) {
    int count;
    cudaGetDeviceCount(&count);
    if (count > n-1) {
        count = n-1;
    }
    cudaDeviceProp devProp;
    int sum = 0;
    proportion[0] = 0;
    for (int deviceId=0; deviceId<count && deviceId < n; deviceId++) {
        cudaGetDeviceProperties(&devProp, deviceId);
        int speed = devProp.clockRate*devProp.multiProcessorCount;
        sum += speed;
        proportion[deviceId+1] = sum;
    }
    return count;
}


cudaDeviceProp selectGPU(int id, FILE* file) {
    int deviceId;
    if (id == -1) {
        deviceId = cutGetMaxGflopsDeviceId();
    } else {
        deviceId = id;
    }

    cutilSafeCall(cudaSetDevice( deviceId ));
    cutilCheckMsg("cudaSetDevice failed");
    
    cudaDeviceProp devProp;
    cutilSafeCall(cudaGetDeviceProperties(&devProp, deviceId));

    printDevProp(devProp, file);
    return devProp;
}


void printDevMem(FILE* file) {
	size_t freeMem;
	size_t totalMem;
	cuMemGetInfo(&freeMem, &totalMem);
	fprintf(file, " Free Mem: %u\n", freeMem/1024);
	fprintf(file, "Total Mem: %u\n", totalMem/1024);
	fprintf(file, " Used Mem: %u\n", (totalMem-freeMem)/1024);	
	
	
// 	char buf[30];
// 	snprintf(buf, 30, "/proc/%u/statm", (unsigned)getpid());
// 	FILE* pf = fopen(buf, "r");
// 	if (pf) {
// 		unsigned size; //       total program size
// 		unsigned resident;//   resident set size
// 		unsigned share;//      shared pages
// 		unsigned text;//       text (code)
// 		unsigned lib;//        library
// 		unsigned data;//       data/stack
// 		unsigned dt;//         dirty pages (unused in Linux 2.6)
// 		fscanf(pf, "%u" /* %u %u %u %u %u"*/, &size/*, &resident, &share, &text, &lib, &data*/);
// 		fprintf(file, "(?)Used RAM Mem: %u KB\n", size);
// 	}
	//fclose(pf);
	
	
	
	/*struct rusage usage; 
	int ret; 
	
	ret=getrusage(RUSAGE_SELF,&usage);
	fprintf(file, "(?)Used RAM Mem: %u (%d)\n", usage.ru_maxrss, ret);	*/
	
	
}
