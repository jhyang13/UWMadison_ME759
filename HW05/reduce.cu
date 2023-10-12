// reduce.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iomanip>
#include <cstdio>
#include <ctime>
#include <iostream>
#include <random>
#include <chrono>
#include <cuda.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include "reduce.cuh"

#define threadsPerBlock 1024

// Implements the 'first add during global load' parallel reduction method
__global__ void reduce_kernel(float *g_idata, float *g_odata, unsigned int n){

    // Create shared memory for caching s_data
    __shared__ int s_data[threadsPerBlock];
    unsigned int tid = threadIdx.x;
    // Now the block size is reduced by half
    unsigned int i = threadIdx.x + blockIdx.x * (blockDim.x * 2);

    // Execute the original first iteration independently
    // The rest of the code remains unchanged
    if (i < n) {

        s_data[tid] = g_idata[i] + g_idata[i + blockDim.x];

    }

    // Synchronize threads to ensure data is loaded
    __syncthreads();

    for (int s = blockDim.x / 2; s > 0; s >>= 1) {

        if (tid < s && i + s < n) {

            s_data[tid] += s_data[tid + s];

        }

        // Synchronize threads to ensure data is loaded
        __syncthreads();
    }

    if (tid == 0) {
        g_odata[blockIdx.x] = s_data[0];
    }

}


__host__ void reduce(float **input, float **output, unsigned int N, unsigned int threads_per_block){

    // Assign the number of blocks
    unsigned int num_blocks = (N + 2 * threads_per_block - 1) / (2 * threads_per_block);

    // The first time to use reduce_kernel
    reduce_kernel<<<num_blocks, threads_per_block>>>(*input, *output, N);

    // Tell the host waits for the kernel 
    // to finish printing before returning from main
    cudaDeviceSynchronize();

}


