// task1.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <vector>
#include <chrono>
#include "matmul.h"

// Declare a global variable to store the number of threads
int t;

int main(int argc, char *argv[])
{

	// Create the variables to receive the input number
	int n = atol(argv[1]); 
	t = atol(argv[2]);

	// Create new matrices A, B and C
    	std::vector<float> A(n * n);
    	std::vector<float> B(n * n);
    	std::vector<float> C(n * n, 0.0);

	// Initialize matrices A and B with random values
    	// Range [-1 to 1] in row-major order
    	for (int i = 0; i < n; i++) {
        	for (int j = 0; j < n; j++) {

            		A[i * n + j] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;
            		B[i * n + j] = static_cast<float>(rand()) / RAND_MAX * 2.0f - 1.0f;

        	}	
    	}

    	// Start timing
    	auto start = std::chrono::high_resolution_clock::now();

    	// Call mmul function
	mmul(A.data(), B.data(), C.data(), n);

	// Stop timing
    	auto end = std::chrono::high_resolution_clock::now();

	// Create a variable to store the duration time
    	std::chrono::duration<double> duration = end - start;

    	// Print the first element of the resulting C array
    	std::cout << C[0] << std::endl;
	// Print the last element of the resulting C array
    	std::cout << C[n * n - 1] << std::endl;

    	// Print the time taken in milliseconds
    	std::cout << duration.count() * 1000 << std::endl;

    	return 0;

}






