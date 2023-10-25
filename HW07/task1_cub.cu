// task1_cub.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

// Print CUDA runtime errors to console
#define CUB_STDERR

#include <iomanip>
#include <cstdio>
#include <ctime>
#include <iostream>
#include <random>
#include <chrono>
#include <cuda.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include <iostream>
#include <thrust/reduce.h>
#include <thrust/random.h>
#include <thrust/generate.h>
#include <thrust/functional.h>
#include <thrust/copy.h>
#include <stdio.h>
#include <cub/util_allocator.cuh>
#include <cub/device/device_reduce.cuh>
#include "cub/util_debug.cuh"
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

// Import the CUB library's namespace to access its elements
using namespace cub;

// Define a caching allocator for device memory
CachingDeviceAllocator  g_allocator(true);

int main(int argc, char** argv) {
    
    // Create the variables to receive the input number
    // n is used to decide the size of matrix
    int n = pow(2, atoi(argv[1]));

    // Create and populate a host vector with random numbers
    // Create a host vector of floats with size 'n'
    thrust::host_vector<float> h_in(n);
    // Create a random number generator engine
    thrust::default_random_engine rng;
    // Define a uniform distribution between -1.0 and 1.0
    thrust::uniform_real_distribution<float> dist(-1.0f, 1.0f);
    // Fill the vector with random numbers within the defined range
    thrust::generate(h_in.begin(), h_in.end(), [&]() { return dist(rng); });

    // Set up device arrays
    float* d_in = NULL;
    CubDebugExit(g_allocator.DeviceAllocate((void**)& d_in, sizeof(float) * n));

    // Initialize device input
    CubDebugExit(cudaMemcpy(d_in, h_in.data(), sizeof(float) * n, cudaMemcpyHostToDevice));
    
    // Setup device output array
    float* d_sum = NULL;
    CubDebugExit(g_allocator.DeviceAllocate((void**)& d_sum, sizeof(float) * 1));

    // Request and allocate temporary storage
    // Pointer to temporary storage
    void* d_temp_storage = NULL;
    // Variable to hold the size of temporary storage needed
    size_t temp_storage_bytes = 0;

    // Determine the required temporary storage size for the reduction
    CubDebugExit(DeviceReduce::Sum(d_temp_storage, temp_storage_bytes, d_in, d_sum, n));

    // Allocate device memory for the determined temporary storage
    CubDebugExit(g_allocator.DeviceAllocate(&d_temp_storage, temp_storage_bytes));

    // Create CUDA events for timing
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Start recording
    cudaEventRecord(start);

    // Do the actual reduce operation
    CubDebugExit(DeviceReduce::Sum(d_temp_storage, temp_storage_bytes, d_in, d_sum, n));
    float gpu_sum;
    CubDebugExit(cudaMemcpy(&gpu_sum, d_sum, sizeof(float) * 1, cudaMemcpyDeviceToHost));

    // Stop recording
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    // Calculate elapsed time
    float milliseconds = 0.0f;
    cudaEventElapsedTime(&milliseconds, start, stop);

    // Check for correctness
    printf("%f\n", gpu_sum);
    // Print the time taken in milliseconds
    printf("%.3f\n", milliseconds);

    // Cleanup
    if (d_in) CubDebugExit(g_allocator.DeviceFree(d_in));
    if (d_sum) CubDebugExit(g_allocator.DeviceFree(d_sum));
    if (d_temp_storage) CubDebugExit(g_allocator.DeviceFree(d_temp_storage));
    
    return 0;

}




