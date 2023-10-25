// task3.cpp

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
#include <omp.h>

// Function to calculate the factorial
int factorial(int n) {
    
    // Initialize the result to 1
    int result = 1;

    for (int i = 1; i <= n; i++) {
        result *= i;
    }

    return result;
}


int main() {

    // Set the number of threads to 4
    omp_set_num_threads(4);

    #pragma omp parallel
    {
        
        // Print the total number of threads
        #pragma omp single
        std::cout << "Number of threads: " << omp_get_num_threads() << "\n";

        // Get the thread number
        #pragma omp critical
        std::cout << "I am thread No. " << omp_get_thread_num() << "\n";

        // Compute and print factorials in parallel
        #pragma omp for
        for (int i = 1; i <= 8; i++) {
            int result = factorial(i);
            #pragma omp critical
            std::cout << i << "!=" << result << "\n";
        }
    }

    return 0;
}

