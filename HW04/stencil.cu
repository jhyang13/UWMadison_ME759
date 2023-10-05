// stencil.cuh

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
#include "stencil.cuh"


// Without using shared memory
/*
__global__ void stencil_kernel(const float* image, const float* mask, float* output, unsigned int n, unsigned int R) {
    
	// Calculate the element in the result matrix 
	// that the current thread is processing
    	int i = blockIdx.x * blockDim.x + threadIdx.x;

    	// Check if the thread is within that block
    	if (i < n) {

        	// Create a variable to save the result
        	float result = 0.0f;

        	// Loop to calculate the convolution
        	for (int j = -R; j <= R; ++j) {

            		if (i + j >= 0 && i + j < n) {

                		result += image[i + j] * mask[j + R];

            		} else {

                		// When i + j < 0 or i + j > n - 1, image[i] = 1
                		result += 1.0f * mask[j + R];
            		}
        	}

        	// Assign value to output
        	output[i] = result;
    	}
}
*/


__global__ void stencil_kernel(const float* image, const float* mask, float* output, unsigned int n, unsigned int R) {
    
    	// Shared memory declaration
    	__shared__ float shared_image[1024]; // THREADS_PER_BLOCK = 1024
    
    	// Calculate the element in the result matrix 
	// that the current thread is processing
    	int i = blockIdx.x * blockDim.x + threadIdx.x;

    	// Add image to the shared memory
    	if (threadIdx.x < n) {
        	shared_image[threadIdx.x] = image[i];
    	}

    	// Wait for all threads to complete shared memory loading
    	__syncthreads();

    	// Check if the thread is within a valid value range
    	if (i < n) {

        	// Create a variable to save result
        	float result = 0.0f;

        	// Loop to get the convolution
        	for (int j = -R; j <= R; ++j) {

            		int idx = threadIdx.x + j;

            		if (idx >= 0 && idx < n) {

                		result += shared_image[idx] * mask[j + R];

            		} else {
                	
                		result += 1.0f * mask[j + R];

            		}
        	}

        // Assign value to output
        output[i] = result;
    }
}



__host__ void stencil(const float* image, const float* mask, float* output, unsigned int n, unsigned int R, unsigned int threads_per_block){

	// Define grid and block dimensions	
	// Define a 2D block
        dim3 block(threads_per_block);

        // Define a 2D grid
        dim3 grid((n + block.x - 1) / block.x);

        // Call the kernel function
        stencil_kernel<<<grid, block>>>(image, mask, output, n, R);

        // Tell the host waits for the kernel
        // to finish printing before returning from main
       	cudaDeviceSynchronize();

}

