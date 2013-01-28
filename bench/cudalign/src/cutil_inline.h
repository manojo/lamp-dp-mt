#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

#ifndef CUTIL_INLINE
#define CUTIL_INLINE

// PORTED FROM CUDA 4.0 C/common/inc/cuda_inline.h

#define cutilSafeCall(err)           __cudaSafeCall      (err, __FILE__, __LINE__)
#define cutilCheckMsg(msg)           __cutilGetLastError (msg, __FILE__, __LINE__)



inline void __cudaSafeCall( cudaError err, const char *file, const int line ) {
	if( cudaSuccess != err) {
		fprintf(stderr, "%s(%i) : cudaSafeCall() Runtime API error %d: %s.\n",
					file, line, (int)err, cudaGetErrorString( err ) );
		exit(-1);
	}
}

inline void __cutilGetLastError( const char *errorMessage, const char *file, const int line ) {
	cudaError_t err = cudaGetLastError();
	if( cudaSuccess != err) {
		fprintf(stderr, "%s(%i) : cutilCheckMsg() CUTIL CUDA error : %s : (%d) %s.\n",
					file, line, errorMessage, (int)err, cudaGetErrorString( err ));
		exit(-1);
	}
}

/*
#undef max
#undef min
#define MIN(a,b) ((a < b) ? a : b)
*/
#ifndef MAX
#define MAX(a,b) ((a > b) ? a : b)
#endif

// Beginning of GPU Architecture definitions
inline int _ConvertSMVer2Cores_local(int major, int minor)
{
	// Defines for GPU Architecture types (using the SM version to determine the # of cores per SM
	typedef struct {
		int SM; // 0xMm (hexidecimal notation), M = SM Major version, and m = SM minor version
		int Cores;
	} sSMtoCores;

	sSMtoCores nGpuArchCoresPerSM[] =
	{ { 0x10,  8 }, // Tesla Generation (SM 1.0) G80 class
		{ 0x11,  8 }, // Tesla Generation (SM 1.1) G8x class
		{ 0x12,  8 }, // Tesla Generation (SM 1.2) G9x class
		{ 0x13,  8 }, // Tesla Generation (SM 1.3) GT200 class
		{ 0x20, 32 }, // Fermi Generation (SM 2.0) GF100 class
		{ 0x21, 48 }, // Fermi Generation (SM 2.1) GF10x class
		{ 0x30, 192}, // Fermi Generation (SM 3.0) GK10x class
		{   -1, -1 }
	};

	int index = 0;
	while (nGpuArchCoresPerSM[index].SM != -1) {
		if (nGpuArchCoresPerSM[index].SM == ((major << 4) + minor) ) {
			return nGpuArchCoresPerSM[index].Cores;
		}
		index++;
	}
	printf("MapSMtoCores undefined SMversion %d.%d!\n", major, minor);
	return -1;
}
// end of GPU Architecture definitions

// This function returns the best GPU (with maximum GFLOPS)
inline int cutGetMaxGflopsDeviceId()
{
	int current_device   = 0, sm_per_multiproc = 0;
	int max_compute_perf = 0, max_perf_device  = 0;
	int device_count     = 0, best_SM_arch     = 0;
	cudaDeviceProp deviceProp;

	cudaGetDeviceCount( &device_count );
	// Find the best major SM Architecture GPU device
	while ( current_device < device_count ) {
		cudaGetDeviceProperties( &deviceProp, current_device );
		if (deviceProp.major > 0 && deviceProp.major < 9999) {
			best_SM_arch = MAX(best_SM_arch, deviceProp.major);
		}
		current_device++;
	}

	// Find the best CUDA capable GPU device
	current_device = 0;
	while( current_device < device_count ) {
		cudaGetDeviceProperties( &deviceProp, current_device );
		if (deviceProp.major == 9999 && deviceProp.minor == 9999) {
			sm_per_multiproc = 1;
		} else {
			sm_per_multiproc = _ConvertSMVer2Cores_local(deviceProp.major, deviceProp.minor);
		}

		int compute_perf  = deviceProp.multiProcessorCount * sm_per_multiproc * deviceProp.clockRate;
		if( compute_perf  > max_compute_perf ) {
			// If we find GPU with SM major > 2, search only these
			if ( best_SM_arch > 2 ) {
				// If our device==dest_SM_arch, choose this, or else pass
				if (deviceProp.major == best_SM_arch) {
					max_compute_perf  = compute_perf;
					max_perf_device   = current_device;
				}
			} else {
				max_compute_perf  = compute_perf;
				max_perf_device   = current_device;
			}
		}
		++current_device;
	}
	return max_perf_device;
}

#endif
