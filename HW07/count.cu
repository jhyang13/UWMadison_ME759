// count.cu

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
#include <thrust/sort.h>
#include <thrust/unique.h>
#include "count.cuh"


// Find unique integers in the array d_in, store them in values array in ascending order,
// and store the occurrences of these integers in counts array.
void count(const thrust::device_vector<int>& d_in, thrust::device_vector<int>& values, thrust::device_vector<int>& counts) {
    
    // Make a copy of the input vector and sort it
    thrust::device_vector<int> sorted_in = d_in;
    thrust::sort(sorted_in.begin(), sorted_in.end());

    // Find unique elements in the sorted vector
    thrust::device_vector<int>::iterator new_end = thrust::unique(sorted_in.begin(), sorted_in.end());

    // Resize the 'values' and 'counts' vectors to accommodate the unique elements
    int unique_count = new_end - sorted_in.begin();
    values.resize(unique_count);
    counts.resize(unique_count);

    // Compute the counts using the 'reduce by key' operation
    thrust::reduce_by_key(sorted_in.begin(), new_end, thrust::constant_iterator<int>(1), values.begin(), counts.begin());
    
}






