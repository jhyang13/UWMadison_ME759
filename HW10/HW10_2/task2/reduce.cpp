// reduce.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include "reduce.h"

// Function to perform parallel reduction using OpenMP.
// It computes the sum of elements in the array 'arr' within the range [l, r).
float reduce(const float* arr, const size_t l, const size_t r) {
    float output = 0; // Initialize the output variable to store the sum.

    // OpenMP directive for parallelism.
    // The 'parallel for' directive divides the loop into multiple threads.
    // The 'simd' directive enables vectorization for further performance improvement.
    // The 'reduction' clause accumulates the results from each thread into 'output'.
    #pragma omp parallel for simd reduction(+ : output)
    for (size_t i = l; i < r; i++) {
        output += arr[i]; // Accumulate the sum of array elements.
    }

    return output; // Return the computed sum.
}




