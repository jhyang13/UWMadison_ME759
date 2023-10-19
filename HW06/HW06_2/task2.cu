// task2.cu

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

int main(int argc, char *argv[]) 
{

    	// Create the variables to receive the input number
    	// 2^n is used to decide the size of matrix
	int n = pow(2, atoi(argv[1]));
	int threads_per_block  = atoi(argv[2]);

	// Create new array hinput
    	// Allocate memory for array hinput
    	float *input = new float[n];
    	float *output = new float[n];

    	// Allocate the managed memory for input and output 
    	cudaMallocManaged(&input, sizeof(float) * n);
    	cudaMallocManaged(&output, sizeof(float) * n);

	// Initialize the pseudo-random number generator's seed
	// for generating random numbers in the program
    	srand(static_cast<unsigned int>(time(nullptr)));
    	// Initialize array hinput with random values
	// From -1 to 1
    	for (int i = 0; i < n; i++) 
    	{
        	input[i] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;
    	}

    	// Prepare CUDA timer
    	cudaEvent_t start;
    	cudaEvent_t stop;
    	cudaEventCreate(&start);
    	cudaEventCreate(&stop);

    	// Start the timing
    	cudaEventRecord(start);
    
	// Launch the scan kernel
	scan(input, output, n, threads_per_block);
    
	// Tell the host waits for the kernel 
	// to finish printing before returning from main
	cudaDeviceSynchronize();
    
	// Stop the timing
    	cudaEventRecord(stop);
    	cudaEventSynchronize(stop);

	// Calculate the duration time in milliseconds
        float milliseconds = 0.0f;
        cudaEventElapsedTime(&milliseconds, start, stop);

	// Print the resulting sum.
 	std::cout << output[n-1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
    	std::cout << milliseconds << std::endl;

    	// Free memory
    	cudaFree(input);
    	cudaFree(output);

    	return 0;

}
