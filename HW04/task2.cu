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
#include "stencil.cuh"


int main(int argc, char **argv) {

	// Create the variables to receive the input number
	unsigned int N = pow(2, atoi(argv[1]));
	unsigned int R = atoi(argv[2]);
	unsigned int Threads_per_Block = atoi(argv[3]);
	
 	// Assign host memory and stack allocation for array image, mask and output
	float* hi = new float[N];
	float* hm = new float[2 * R + 1];
	float* hO = new float[N];

	// Create Pseudo-random number generator 
	// used for generating pseudo-random number sequences
        std::default_random_engine generator(std::time(nullptr));
	// Set up random numbers in the range [-1, 1]
	std::uniform_real_distribution<float> distribution(-1.0f, 1.0f);

	// Assign values to array image with the created random values
    	for (unsigned int i = 0; i < N; ++i){

        	hi[i] = distribution(generator);

    	}

	// Assign values to array mask with the created random values
	for (unsigned int j = 0; j < 2 * R + 1; ++j){

        	hm[j] = distribution(generator);

    	}

    	// Allocate device memory for array a, b and c
    	float *di; 
	float *dm;
	float *dO;

    	cudaMalloc((void**)&di, sizeof(float) * N);
	cudaMalloc((void**)&dm, sizeof(float) * (2 * R + 1));
	cudaMalloc((void**)&dO, sizeof(float) * N);


	/*
	// Test if cudaMalloc is incorrect
	cudaError_t cudaStatus = cudaMalloc((void**)&di, sizeof(float) * N);
	if (cudaStatus != cudaSuccess) {
    		std::cerr << "cudaMalloc failed: " << cudaGetErrorString(cudaStatus) << std::endl;
	}*/


    	// Copy back the data stored in the device array
        // into the host array for array a and b
    	cudaMemcpy(di, hi, sizeof(float) * N, cudaMemcpyHostToDevice);
    	cudaMemcpy(dm, hm, sizeof(float) * (2 * R + 1), cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start;
	cudaEvent_t stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	// Lanuch the timer
	cudaEventRecord(start);

   	// Call the matmul function
    	stencil(di, dm, dO, N, R, Threads_per_Block);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
        cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
        // into the host array for array c
    	cudaMemcpy(hO, dO, sizeof(float) * N, cudaMemcpyDeviceToHost);


	/*
	// Test if data can be transferred
	cudaMemcpy(hi, di, sizeof(float) * N, cudaMemcpyDeviceToHost);

	// Just output several data
	for (int i = 0; i < 10; ++i) {
    		printf("hi[%d] = %f\n", i, hi[i]);
	}*/


	// Stop the timer
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);

	// Calculate the duration time in milliseconds
    	float milliseconds = 0.0f;
    	cudaEventElapsedTime(&milliseconds, start, stop);


	// Print the last element of the resulting array
	std::cout << hO[N - 1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
        std::cout << milliseconds << std::endl;
	
	// Free memory
    	delete[] hi;
    	delete[] hm;
    	delete[] hO;
    	cudaFree(di);
    	cudaFree(dm);
    	cudaFree(dO);

    	return 0;

}





