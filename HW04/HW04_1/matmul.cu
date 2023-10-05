// matmul.cu
        
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
#include "matmul.cuh"


__global__ void matmul_kernel(const float* A, const float* B, float* C, size_t n){

	// Calculates the row and column coordinates of the element 
	// that the current thread is processing in the result matrix
	int row = blockIdx.x * blockDim.x + threadIdx.x;
    	int col = blockIdx.y * blockDim.y + threadIdx.y;

	// Check if the thread is within valid row and column values
	if (row < n && col < n) {

		// Create a variable to store the value
        	float result = 0.0f;
        
		// Loop to assign value to array C
		for (int i = 0; i < n; ++i){
            		
			result += A[row * n + i] * B[i * n + col];

        	}
        
		// Assign value to array C
		C[row * n + col] = result;

	}
}
    	

void matmul(const float* A, const float* B, float* C, size_t n, unsigned int threads_per_block){

	// Define a 2D block
	dim3 block(threads_per_block, threads_per_block);

	// Define a 2D grid
    	dim3 grid((n + block.x - 1) / block.x, (n + block.y - 1) / block.y);

	// Call the kernel function 
    	matmul_kernel<<<grid, block>>>(A, B, C, n);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
    	cudaDeviceSynchronize();
}





