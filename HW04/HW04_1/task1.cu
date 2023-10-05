// task1.cu

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


int main(int argc, char **argv) {

	// Create the variables to receive the input number
	unsigned int N = pow(2, atoi(argv[1]));
	unsigned int Threads_per_Block = atoi(argv[2]);
	
 	// Assign host memory and stack allocation for array a, b and c
	float* ha = new float[N * N];
	float* hb = new float[N * N];
	float* hc = new float[N * N];

	// Create Pseudo-random number generator 
	// used for generating pseudo-random number sequences
        std::default_random_engine generator(std::time(nullptr));
	// Set up random numbers in the range [-1, 1]
	std::uniform_real_distribution<float> distribution(-1.0f, 1.0f);

	// Assign values to array a and b with the created random values
    	for (unsigned int i = 0; i < N * N; ++i){
        	ha[i] = distribution(generator);
        	hb[i] = distribution(generator);
    	}

    	// Allocate device memory for array a, b and c
    	float *da; 
	float *db;
	float *dc;

    	cudaMalloc((void**)&da, sizeof(float) * N * N);
	cudaMalloc((void**)&db, sizeof(float) * N * N);
	cudaMalloc((void**)&dc, sizeof(float) * N * N);

    	// Copy back the data stored in the device array
        // into the host array for array a and b
    	cudaMemcpy(da, ha, sizeof(float) * N * N, cudaMemcpyHostToDevice);
    	cudaMemcpy(db, hb, sizeof(float) * N * N, cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start;
	cudaEvent_t stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	// Lanuch the timer
	cudaEventRecord(start);

   	// Call the matmul function
    	matmul(da, db, dc, N, Threads_per_Block);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
        cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
        // into the host array for array c
    	cudaMemcpy(hc, dc, sizeof(float) * N * N, cudaMemcpyDeviceToHost);


	// Check if the kernel function call is in error
	/*cudaError_t error = cudaGetLastError();
	//if (error != cudaSuccess) {
    		std::cerr << "CUDA error: " << cudaGetErrorString(error) << std::endl;
	}*/


	// Stop the timer
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);

	// Calculate the duration time in milliseconds
    	float milliseconds = 0.0f;
    	cudaEventElapsedTime(&milliseconds, start, stop);

	// Print the last element of the resulting array
	std::cout << hc[N * N - 1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
        std::cout << milliseconds << std::endl;
	
	// Free memory
    	delete[] ha;
    	delete[] hb;
    	delete[] hc;
    	cudaFree(da);
    	cudaFree(db);
    	cudaFree(dc);

    	return 0;

}





