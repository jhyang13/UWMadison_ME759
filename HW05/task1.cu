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
	// 2^n is used to decide the size of matrix
	// block_dim^2 should be the number of threads
	unsigned int n = pow(2, atoi(argv[1]));
	unsigned int block_dim  = atoi(argv[2]);



	// int part
    	// Allocate memory for matrices A, B, and C
	// Create new matrices A, B and C
    	int* ha = new int[n * n];
    	int* hb = new int[n * n];
    	int* hc = new int[n * n];

    	// Initialize the pseudo-random number generator's seed 
	// for generating random numbers in the program
    	srand(static_cast<unsigned int>(time(nullptr)));
	// Initialize matrices A and B with random values
	// From 0 to 50
    	for (unsigned int i = 0; i < n * n; ++i) {

        	ha[i] = static_cast<int>(rand() % 50); 
        	hb[i] = static_cast<int>(rand() % 50);

    	}

    	// Create device matrices A, B, and C
    	int* da;
    	int* db;
    	int* dc;
	// Allocate device memory for matrices A, B, and C
    	cudaMalloc((void**)&da, sizeof(int) * n * n);
    	cudaMalloc((void**)&db, sizeof(int) * n * n);
    	cudaMalloc((void**)&dc, sizeof(int) * n * n);

    	// Copy matrices A and B to device
    	cudaMemcpy(da, ha, sizeof(int) * n * n, cudaMemcpyHostToDevice);
    	cudaMemcpy(db, hb, sizeof(int) * n * n, cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start;
	cudaEvent_t stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	// Lanuch the timer
	cudaEventRecord(start);

    	// Call the appropriate matmul function based on the template type
    	matmul_1(da, db, dc, n, block_dim);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
    	cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
    	// into the host array for array c
    	cudaMemcpy(hc, dc, sizeof(int) * n * n, cudaMemcpyDeviceToHost);

	// Stop the timer
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);

	// Calculate the duration time in milliseconds
    	float milliseconds = 0.0f;
    	cudaEventElapsedTime(&milliseconds, start, stop);

	// Print the first element of C
 	std::cout << hc[0] << std::endl;

	// Print the last element of C
	std::cout << hc[n * n - 1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
    	std::cout << milliseconds << std::endl;

    	// Free memory
    	delete[] ha;
    	delete[] hb;
    	delete[] hc;
    	cudaFree(da);
    	cudaFree(db);
    	cudaFree(dc);



	// float part
    	// Allocate memory for matrices A, B, and C
	// Create new matrices A, B and C
    	float* ha2 = new float[n * n];
    	float* hb2 = new float[n * n];
    	float* hc2 = new float[n * n];

    	// Initialize the pseudo-random number generator's seed 
	// for generating random numbers in the program
    	srand(static_cast<unsigned int>(time(nullptr)));
	// Initialize matrices A and B with random values
	// From 0 to 50
    	for (unsigned int i = 0; i < n * n; ++i) {
        	
		// Integer part
		int integerPart = rand() % 50;    
		// Decimal part
    		float decimalPart = static_cast<float>(rand() % 100) / 100.0f;
		// Assign elements to ha2 and hb2
    		ha2[i] = static_cast<float>(integerPart) + decimalPart;
    		hb2[i] = static_cast<float>(integerPart) + decimalPart;

    	}

    	// Create device matrices A, B, and C
    	float* da2;
    	float* db2;
    	float* dc2;
	// Allocate device memory for matrices A, B, and C
    	cudaMalloc((void**)&da2, sizeof(float) * n * n);
    	cudaMalloc((void**)&db2, sizeof(float) * n * n);
    	cudaMalloc((void**)&dc2, sizeof(float) * n * n);

    	// Copy matrices A and B to device
    	cudaMemcpy(da2, ha2, sizeof(float) * n * n, cudaMemcpyHostToDevice);
    	cudaMemcpy(db2, hb2, sizeof(float) * n * n, cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start2;
	cudaEvent_t stop2;
	cudaEventCreate(&start2);
	cudaEventCreate(&stop2);

	// Lanuch the timer
	cudaEventRecord(start2);

    	// Call the appropriate matmul function based on the template type
    	matmul_2(da2, db2, dc2, n, block_dim);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
    	cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
    	// into the host array for array c
    	cudaMemcpy(hc2, dc2, sizeof(float) * n * n, cudaMemcpyDeviceToHost);

	// Stop the timer
	cudaEventRecord(stop2);
	cudaEventSynchronize(stop2);

	// Calculate the duration time in milliseconds
    	float milliseconds2 = 0.0f;
    	cudaEventElapsedTime(&milliseconds2, start2, stop2);

	// Print the first element of C
 	std::cout << hc2[0] << std::endl;

	// Print the last element of C
	std::cout << hc2[n * n - 1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
    	std::cout << milliseconds2 << std::endl;

    	// Free memory
    	delete[] ha2;
    	delete[] hb2;
    	delete[] hc2;
    	cudaFree(da2);
    	cudaFree(db2);
    	cudaFree(dc2);


		
	// double part
    	// Allocate memory for matrices A, B, and C
	// Create new matrices A, B and C
    	double* ha3 = new double[n * n];
    	double* hb3 = new double[n * n];
    	double* hc3 = new double[n * n];

    	// Initialize the pseudo-random number generator's seed 
	// for generating random numbers in the program
    	srand(static_cast<unsigned int>(time(nullptr)));
	// Initialize matrices A and B with random values
	// From 0 to 50
    	for (unsigned int i = 0; i < n * n; ++i) {
        	
		// Integer part
		int integerPart = rand() % 50;    
		// Decimal part
    		double decimalPart = static_cast<double>(rand() % 100) / 100.0f;
		// Assign elements to ha2 and hb2
    		ha3[i] = static_cast<double>(integerPart) + decimalPart;
    		hb3[i] = static_cast<double>(integerPart) + decimalPart;

    	}

    	// Create device matrices A, B, and C
    	double* da3;
    	double* db3;
    	double* dc3;
	// Allocate device memory for matrices A, B, and C
    	cudaMalloc((void**)&da3, sizeof(double) * n * n);
    	cudaMalloc((void**)&db3, sizeof(double) * n * n);
    	cudaMalloc((void**)&dc3, sizeof(double) * n * n);

    	// Copy matrices A and B to device
    	cudaMemcpy(da3, ha3, sizeof(double) * n * n, cudaMemcpyHostToDevice);
    	cudaMemcpy(db3, hb3, sizeof(double) * n * n, cudaMemcpyHostToDevice);

	// Prepare CUDA timer
	cudaEvent_t start3;
	cudaEvent_t stop3;
	cudaEventCreate(&start3);
	cudaEventCreate(&stop3);

	// Lanuch the timer
	cudaEventRecord(start3);

    	// Call the appropriate matmul function based on the template type
    	matmul_3(da3, db3, dc3, n, block_dim);

	// Tell the host waits for the kernel 
	// to finish printing before returning from main
    	cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
    	// into the host array for array c
    	cudaMemcpy(hc3, dc3, sizeof(double) * n * n, cudaMemcpyDeviceToHost);

	// Stop the timer
	cudaEventRecord(stop3);
	cudaEventSynchronize(stop3);

	// Calculate the duration time in milliseconds
    	float milliseconds3 = 0.0f;
    	cudaEventElapsedTime(&milliseconds3, start3, stop3);

	// Print the first element of C
 	std::cout << hc3[0] << std::endl;

	// Print the last element of C
	std::cout << hc3[n * n - 1] << std::endl;

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
    	std::cout << milliseconds3 << std::endl;

    	// Free memory
    	delete[] ha3;
    	delete[] hb3;
    	delete[] hc3;
    	cudaFree(da3);
    	cudaFree(db3);
    	cudaFree(dc3);

	return 0;

}




