// task1.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <cstdlib>
#include <chrono>
#include <random>
#include "optimize.h"

int main(int argc, char *argv[]) {

    int exponent = std::atoi(argv[1]);  // Parse the input as an integer
    // Parse the command line argument 'n'
    int n = std::pow(10, exponent);

    // Create and initialize a vector 'v' with length 'n'
    vec v(n);
    v.data = new data_t[n];
    for (int i = 0; i < n; i++) {
        v.data[i] = static_cast<data_t>(i);
    }

    // Initialize variables for timing measurements
    auto start_time = std::chrono::high_resolution_clock::now();
    data_t result; // To store the result of optimization functions

    // Measure and print the results of different optimization functions
    // Optimize1
    optimize1(&v, &result);
    std::cout << result << std::endl;
    auto end_time = std::chrono::high_resolution_clock::now();
    double elapsed_time = std::chrono::duration<double>(end_time - start_time).count() * 1000.0;
    std::cout << elapsed_time << std::endl;

    // Optimize2
    start_time = std::chrono::high_resolution_clock::now();
    optimize2(&v, &result);
    std::cout << result << std::endl;
    end_time = std::chrono::high_resolution_clock::now();
    elapsed_time = std::chrono::duration<double>(end_time - start_time).count() * 1000.0;
    std::cout << elapsed_time << std::endl;

    // Optimize3
    start_time = std::chrono::high_resolution_clock::now();
    optimize3(&v, &result);
    std::cout << result << std::endl;
    end_time = std::chrono::high_resolution_clock::now();
    elapsed_time = std::chrono::duration<double>(end_time - start_time).count() * 1000.0;
    std::cout << elapsed_time << std::endl;

    // Optimize4
    start_time = std::chrono::high_resolution_clock::now();
    optimize4(&v, &result);
    std::cout << result << std::endl;
    end_time = std::chrono::high_resolution_clock::now();
    elapsed_time = std::chrono::duration<double>(end_time - start_time).count() * 1000.0;
    std::cout << elapsed_time << std::endl;

    // Optimize5
    start_time = std::chrono::high_resolution_clock::now();
    optimize5(&v, &result);
    std::cout << result << std::endl;
    end_time = std::chrono::high_resolution_clock::now();
    elapsed_time = std::chrono::duration<double>(end_time - start_time).count() * 1000.0;
    std::cout << elapsed_time << std::endl;

    // Clean up memory
    delete[] v.data;

    return 0;
}





