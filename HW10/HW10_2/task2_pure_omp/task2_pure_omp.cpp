// task2_pure_omp.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <algorithm>
#include <chrono>
#include <iostream>
#include <omp.h>
#include <random>
#include <stdio.h>
#include <memory> // Include for std::unique_ptr
#include "reduce.h"

using namespace std;
using namespace std::chrono;

int main(int argc, char *argv[]) {

    // Convert command line arguments to integers
    int exponent = atoi(argv[1]); // Parse the input as an integer
    int n = pow(2, exponent);     // Size of the array (2^exponent)
    int t = atol(argv[2]);        // Number of threads

    // Set the number of threads for OpenMP
    omp_set_num_threads(t);

    // Random number generation setup
    random_device entropy_source;
    mt19937_64 generator(entropy_source());
    uniform_real_distribution<float> dist(-1.0, 1.0); // Range of random numbers

    // Allocate memory for the array and initialize it with random floats
    unique_ptr<float[]> arr(new float[n]);
    for (int i = 0; i < n; i++) {
        arr[i] = dist(generator);
    }

    // Perform the reduction operation and time it
    auto start = high_resolution_clock::now();
    float result = reduce(arr.get(), 0, n);
    auto end = high_resolution_clock::now();

    // Calculate the time taken in milliseconds
    double ms = duration_cast<duration<double, milli>>(end - start).count();

    // Print the result of the reduction and the time taken
    printf("%f\n%f\n", result, ms);

    return 0;
}




