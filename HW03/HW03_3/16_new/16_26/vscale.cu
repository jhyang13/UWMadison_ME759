// task3 
// vscale.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <cstdio>
#include <ctime>
#include <iostream>
#include <random>
#include <cuda.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include "vscale.cuh"


// Function that does an element-wise multiplication 
// of the two arrays: bi = ai · bi
__global__ void vscale(const float *a, float *b, unsigned int n){

	// Assign CUDA and the global unique index of a thread within the grid
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	
	// Do an element-wise multiplication of the two arrays
	for (int i = index; i < n; i += blockDim.x * gridDim.x) {
        	
		b[i] = a[i] * b[i];

   	}	
}

