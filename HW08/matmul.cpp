// matmul.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <vector>
#include <chrono>
#include "matmul.h"

// Declare an external variable
extern int t; 

void mmul(const float* A, const float* B, float* C, const std::size_t n) {

    #pragma omp parallel for num_threads(t)
    
    for (std::size_t i = 0; i < n; i++) {
        for (std::size_t k = 0; k < n; k++) {

            // Initialize the sum for the resulting element in matrix C
            float sum = 0.0f;

            for (std::size_t j = 0; j < n; j++) {

                // Multiply corresponding elements of matrices A and B, and accumulate the sum
                sum += A[i * n + k] * B[k * n + j];

            }

            // Store the computed sum in the corresponding element of matrix C
            C[i * n + k] = sum;

        }
    }
}


