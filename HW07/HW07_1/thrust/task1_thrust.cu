// task1_thrust.cu

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
#include <iostream>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/reduce.h>
#include <thrust/random.h>
#include <thrust/generate.h>
#include <thrust/functional.h>
#include <thrust/copy.h>


int main(int argc, char **argv) {

	// Create the variables to receive the input number
	// n is used to decide the size of matrix
	int n = pow(2, atoi(argv[1]));

	// Create a host vector to store random float numbers
    	thrust::host_vector<float> hdata(n);
	// Create a random number generator engine
    	thrust::default_random_engine rng;
	// Define a uniform distribution for random numbers in the range [-1.0, 1.0]
    	thrust::uniform_real_distribution<float> dist(-1.0f, 1.0f);
	// Fill the host vector with random numbers using the random number generator and distribution
    	thrust::generate(hdata.begin(), hdata.end(), [&]() { return dist(rng); });

	// Copy the host vector to a device vector
    	thrust::device_vector<float> ddata = hdata;

    	// Set up timer
    	cudaEvent_t start, stop;
    	cudaEventCreate(&start);
    	cudaEventCreate(&stop);

	// Start timer
    	cudaEventRecord(start);

    	// Perform reduction
    	float result = thrust::reduce(ddata.begin(), ddata.end(), 0.0f, thrust::plus<float>());

	// Stop timer
    	cudaEventRecord(stop);
    	cudaEventSynchronize(stop);

	// Create a variable to store the duration time in milliseconds
    	float milliseconds = 0.0f;
    	cudaEventElapsedTime(&milliseconds, start, stop);

    	// Print the result 
    	std::cout << result << std::endl;
	// Print the time
    	std::cout << milliseconds << std::endl;

    	return 0;
}




