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
#include "reduce.cuh"


int main(int argc, char **argv) {

	// Create the variables to receive the input number
	// 2^n is used to decide the size of matrix
	unsigned int N = pow(2, atoi(argv[1]));
	unsigned int threads_per_block  = atoi(argv[2]);

	// Create new array hinput
    	// Allocate memory for array hinput
	float* hinput = new float[N];

    	// Initialize the pseudo-random number generator's seed 
	// for generating random numbers in the program
    	srand(static_cast<unsigned int>(time(nullptr)));
	// Initialize array hinput with random values
	// From -1 to 1
    	for (unsigned int i = 0; i < N; ++i) {

        	hinput[i] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;

    	}	

    	// Create device array dinput and doutput
	float* dinput;
	float* doutput;
	// Allocate device memory for array dinput and doutput
	cudaMalloc((void**)&dinput, N * sizeof(float));
    	cudaMalloc((void**)&doutput, N * sizeof(float));

    	// Copy array dinput and hinput to device
    	cudaMemcpy(dinput, hinput, N * sizeof(float), cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start;
	cudaEvent_t stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	// Lanuch the timer
	cudaEventRecord(start);

	// Call the reduce function
    	reduce(&dinput, &doutput, N, threads_per_block);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
    	cudaDeviceSynchronize();

	// Copy the result back from device to host
    	cudaMemcpy(hinput, dinput, sizeof(float), cudaMemcpyDeviceToHost);

	// Stop the timer
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);

	// Calculate the duration time in milliseconds
    	float milliseconds = 0.0f;
    	cudaEventElapsedTime(&milliseconds, start, stop);

	// Print the resulting sum.
 	std::cout << hinput[0] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
    	std::cout << milliseconds << std::endl;

    	// Free memory
    	delete[] hinput;
    	cudaFree(dinput);
    	cudaFree(doutput);

	return 0;

}




