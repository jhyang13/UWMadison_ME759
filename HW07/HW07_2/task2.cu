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
#include <iostream>
#include <thrust/reduce.h>
#include <thrust/random.h>
#include <thrust/generate.h>
#include <thrust/functional.h>
#include <thrust/copy.h>
#include <stdio.h>
#include <cub/util_allocator.cuh>
#include <cub/device/device_reduce.cuh>
#include "cub/util_debug.cuh"
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include "count.cuh"


int main(int argc, char *argv[]) {

    // Create the variables to receive the input number
    int n = static_cast<int>(pow(2, atoi(argv[1])));

    // Create a host vector of integers with size 'n'
    thrust::host_vector<int> hdata(n);

    // Create a default random number generator
    thrust::default_random_engine rng;

    // Create a uniform integer distribution that generates random numbers
    // in the range [0, 500]
    thrust::uniform_int_distribution<int> dist(0, 500);

    // Fill the host vector with random integer values
    for (int i = 0; i < n; i++) {

        // Generate a random integer 
        // using the 'dist' distribution and 'rng' generator
        hdata[i] = dist(rng);
    }

    // Create a device vector and copy the data from the host vector
    thrust::device_vector<int> ddata = hdata;

    // Create device vectors 'values' and 'counts' to store results
    thrust::device_vector<int> values;
    thrust::device_vector<int> counts;

    // Measure time with CUDA events
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Start the timer
    cudaEventRecord(start);

    // Call the count function
    count(ddata, values, counts);

    // Stop th timer
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    // Print the last element of values and counts
    std::cout << values[values.size() - 1] << std::endl;
    std::cout << counts[counts.size() - 1] << std::endl;

    // Calculate duration time
    float milliseconds = 0.0f;
    cudaEventElapsedTime(&milliseconds, start, stop);
    
    // Print the time taken to run the count function in milliseconds
    std::cout << milliseconds << std::endl;

    return 0;

}






