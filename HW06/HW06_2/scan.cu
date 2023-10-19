// scan.cu

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
#include "scan.cuh"

// reference: 
// https://kieber-emmons.medium.com/efficient-parallel-prefix-sum-in-metal-for-apple-m1-9e60b974d62


// FUnction to perform hillisSteeleScan
// Based on the code in lecture 14
__global__ void hillisSteeleScan(float *g_out, float *g_intput, float *g_sum, int n) 
{
    // Allocated on invocation
    extern volatile __shared__  float temp[];
    
    int thread_id = threadIdx.x;
    int index = blockIdx.x * blockDim.x + thread_id;
    int pout = 0, pin = 1;

    // Load elements to shared memory
    if (index >= n)
    { 

        // Pad with zeros if out of bounds
        temp[thread_id] = 0;

    }
    else 
    {

        // Load elements into shared memory
        temp[thread_id] = g_intput[index];
            
        // Synchronize threads
        __syncthreads();

        // Scanning within a thread group
        for (int offset = 1; offset < blockDim.x; offset *= 2)
        {

            // Swap double buffer indices
            pout = 1 - pout;
            pin = 1 - pout; 

            if ( thread_id >= offset){
                temp[pout * blockDim.x + thread_id] = temp[pin * blockDim.x + thread_id] + temp[pin * blockDim.x + thread_id - offset];
            }else{
                temp[pout * blockDim.x + thread_id] = temp[pin * blockDim.x + thread_id];
            }

            // Synchronize threads
            __syncthreads();   

        }
            
        // Store the result in output (exclusive scan)
        g_out[index] = temp[pout * n + thread_id];

         // Store the inclusive sum into the g_sum vector
        if (thread_id == blockDim.x - 1)
        { 
            g_sum[blockIdx.x] = temp[pout * n + thread_id];
        }

    }
}


// The scan function
__host__ void scan(const float* input, float* output, unsigned int n, unsigned int threads_per_block) 

{
    // Allocate cuda memory for input and ouput
    float *in; 
    float *out;

    // Allocate memory for input data
    cudaMalloc(&in, n * sizeof(float));
    // Copy input data from host to device
    cudaMemcpy(in, input, n * sizeof(float), cudaMemcpyHostToDevice);
    // Allocate memory for output data
    cudaMalloc(&out, n * sizeof(float));

    // Calculate the number of blocks
    int block_num = (n + threads_per_block - 1) / threads_per_block;
    
    float *sum;
    // Allocate CUDA memory for inclusive sum
    cudaMalloc(&sum, block_num * sizeof(float));

    // Call the hillisSteeleScan function
    hillisSteeleScan<<< block_num, threads_per_block, 2 * threads_per_block * sizeof(float) >>>(out, in, sum, n);

    float *scan_sum;
    float *temp_sum;
    // Allocate CUDA memory for inclusive scan for sum
    cudaMalloc(&scan_sum, block_num * sizeof(float));
    cudaMalloc(&temp_sum, block_num * sizeof(float));
    
    // Copy the output from the device to the host
    cudaMemcpy(output, out, n * sizeof(float), cudaMemcpyDeviceToHost);

    cudaDeviceSynchronize();
    
    // Free the memory
    cudaFree(in);
    cudaFree(sum);
    cudaFree(scan_sum);
    cudaFree(temp_sum);
    cudaFree(out);

}
