// task3.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iomanip>
#include <cstdio>
#include <ctime>
#include <iostream>
#include <random>
#include <cuda.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include "vscale.cuh"


int main(int argc, char **argv) {

	// Create the variable to receive the input number
	unsigned int n = pow(2, atoi(argv[1]));
	
 	// Assign host memory and stack allocation for array a and b
	float ha[n];
	float hb[n];

	// Set up random seed
        srand (static_cast <unsigned> (time(0)));

	// Set decimal places before generating random numbers
	std::cout << std::fixed << std::setprecision(1);

	// Assign values to array a and b with random values
    	for (unsigned int i = 0; i < n; ++i){
        	
		// The range of values for array a is [-10.0, 10.0]
		ha[i] = static_cast<float>(rand()) / static_cast<float>(RAND_MAX) * 20.0f - 10.0f;
		
		// The range of values for array b is [0.0, 1.0]
        	hb[i] = static_cast<float>(rand()) / static_cast<float>(RAND_MAX) * 1.0f;

    	}

    	// Allocate device memory for array a and b
    	float *da, *db;
    	cudaMalloc((void**)&da, sizeof(float) * n);
    	cudaMalloc((void**)&db, sizeof(float) * n);

    	// Copy back the data stored in the device array
        // into the host array
    	cudaMemcpy(da, ha, sizeof(float) * n, cudaMemcpyHostToDevice);
    	cudaMemcpy(db, hb, sizeof(float) * n, cudaMemcpyHostToDevice);

	// Assign 512 threads
        const int num_threads = 16;
        // Assign a 1D execution configuration that uses 512 threads per block
    	//int num_blocks = (n + num_threads - 1) / num_threads;
	int num_blocks = 1;

	// Prepare CUDA timer
	cudaEvent_t start;
	cudaEvent_t stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	// Lanuch the timer
	cudaEventRecord(start);

    	// Launch the vscale kernel
    	vscale<<<num_threads, num_blocks>>>(da, db, n);

	// Tell the host waits for the kernel to finish printing before returning from main
        cudaDeviceSynchronize();

    	// Copy back the data stored in the device array
        // into the host array
    	cudaMemcpy(hb, db, sizeof(float) * n, cudaMemcpyDeviceToHost);

	// Stop the timer
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);

	// Calculate the duration time
	float ms = 0;
	cudaEventElapsedTime(&ms, start, stop);

	// Print the amount of time taken to execute the kernel in milliseconds using CUDA event
	printf("%f\n", ms);

    	// Print the first element of the resulting array
    	std::cout << hb[0] << std::endl;

	// Print the last element of the resulting array
	std::cout << hb[n - 1] << std::endl;

    	return 0;

}





