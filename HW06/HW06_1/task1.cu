// task1.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <iomanip>
#include <cstdio>
#include <ctime>
#include <iostream>
#include <random>
#include <chrono>
#include <cuda.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include <cstdlib>
#include <cublas_v2.h>
#include "mmul.h"


int main(int argc, char *argv[])
{

	/*
	// Test GPU
	int deviceCount;
	cudaGetDeviceCount(&deviceCount);
	if (deviceCount == 0) {
    		std::cerr << "No available GPU devices found." << std::endl;
    		return 1; // quit
	}*/

	using namespace std;
	// Create the variables to receive the input number
	int n = atol(argv[1]); 
	int n_tests = atol(argv[2]);

	// Create new matrices A, B and C
	float *A, *B, *C;
 	// Allocate memory for matrices A, B, and C
	cudaMallocManaged(&A, (n*n)*sizeof(float));
	cudaMallocManaged(&B, (n*n)*sizeof(float));
	cudaMallocManaged(&C, (n*n)*sizeof(float));

	// Initialize matrices A and B with random values 
	// range [-1 to 1] in column-major order
	for (int i = 0; i < n*n; i++)
	{
		A[i] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;
		B[i] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;
		C[i] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;

	}

	// Initialize timer
	float total_time = 0.0f;

	// Calls your mmul function n tests times
	for (int run = 0; run < n_tests; run++)
	{

		// Start timing
        	cudaEvent_t start, stop;
        	cudaEventCreate(&start);
        	cudaEventCreate(&stop);
        	cudaEventRecord(start);

		// Initialize cuBLAS
		cublasHandle_t handle;
		cublasCreate(&handle);

		/*
		// Test
		cublasStatus_t status = cublasCreate(&handle);
		if (status != CUBLAS_STATUS_SUCCESS) {
    		std::cerr << "cuBLAS initialization failed." << std::endl;
    		return 1; // quit
		}*/

		// Call mmul function
		mmul(handle, A, B, C, n); 

		// Tell the host waits for the kernel 
		// to finish printing before returning from main
		cudaDeviceSynchronize();
		
		// Stop timing
        	cudaEventRecord(stop);
        	cudaEventSynchronize(stop);

		// Calculate the duration time in milliseconds
		float milliseconds = 0.0f;
        	cudaEventElapsedTime(&milliseconds, start, stop);

		// Sum up time
		total_time += milliseconds;

	}

	// Calculate the average time
    	float average_time = total_time / n_tests;

	// Print the average time
    	std::cout << average_time << std::endl;

	// Free memory
	cudaFree(A);
	cudaFree(B);
	cudaFree(C);

	return 0;

}
