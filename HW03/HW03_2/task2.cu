// task2.cu

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <cstdio>
#include <iostream>
#include <string>
#include <random>
#include <cuda.h>

// Defined GPU Kernel Function
__global__ void simpleKernel(int* dA, int a) {

	// Assign Cuda and the global unique index of a thread within the grid
    	int x = threadIdx.x;
    	int y = blockIdx.x;
    	
	// Create the array dA with sixteen ints on the device
	// Compute ax+y on each thread 
	// Write the result in one distinct entry of the dA array	
	dA[y * blockDim.x + x] = a * x + y;

}


int main() {

	// Assign eight threads
    	const int num_threads = 8;
	// Assign two blocks
    	const int num_blocks = 2;

	// Define the array size for the host array
    	const int asize = num_threads * num_blocks;
    
        // Generate the random integer a
        const int RANGE = 50;
        int a = rand() % (RANGE + 1);

    	// Create a new array hA
    	int hA[asize];
	// Create a pointer to dA
    	int* dA;
    
    	// Allocate memory space on the device for storing dA
    	cudaMalloc((void**)&dA, sizeof(int) * asize);
    
    	// Invoke GPU kernel, with two block and eight threads
    	simpleKernel<<<num_blocks, num_threads>>>(dA, a);
    
    	// Copy back the data stored in the device array dA 
        // into the host array hA
    	cudaMemcpy(hA, dA, sizeof(int) * asize, cudaMemcpyDeviceToHost);
    
    	// Loop to print (from the host) the sixteen values 
	// stored in the host array separated by a single space each
    	for (int i = 0; i < asize; ++i) {

        	std::cout << hA[i] << " ";

    	}
    
    	// Deallocate the memory on the device 
	// that was previously allocated using cudaMalloc
    	cudaFree(dA);
    
    	return 0;

}

