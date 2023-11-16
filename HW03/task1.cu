// task1.cu

/*After completing my test, 
I requested suggestions from ChatGPT 
for improving the code.*/

#include <cstdio>
#include <iostream>
#include <string>
#include <cuda.h>

// Defined GPU Kernel Function
__global__ void simpleKernel() {

	// Assign CUDA and the global unique index of a thread within the grid
	int index = threadIdx.x + blockIdx.x * blockDim.x;

	// Assign value to a and b
	int a = index + 1;
	int b = 1;

    	// Calculate the factorial b = a!
    	for (int i = 1; i < a+1; i++) {

        	b = b * i;
    	}	

    	// Print out the result
	printf("%d!=%d\n", a, b);
}



int main() {

	// Assign eight threads
    	const int num_threads = 8;
	// Assign one block
	const int num_blocks = 1;

	// Invoke GPU kernel, with one block and eight threads
    	simpleKernel<<<num_blocks, num_threads>>>();

	// Tell the host waits for the kernel to finish printing before returning from main
    	cudaDeviceSynchronize();

    	return 0;
}




