// task2.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <algorithm>
#include <chrono>
#include <iostream>
#include <omp.h>
#include <random>
#include <stdio.h>
#include <mpi.h>
#include "reduce.h"

using namespace std;
using namespace std::chrono;

int main(int argc, char *argv[]) {

    MPI_Init(&argc, &argv);

    int exponent = std::atoi(argv[1]);  // Parse the input as an integer
    // Parse the command line argument 'n'
    int n = std::pow(10, exponent);
    int t = atol(argv[2]); // Number of threads
    omp_set_num_threads(t);

    // Random number generation setup
    random_device entropy_source;
    mt19937_64 generator(entropy_source()); 
    uniform_real_distribution<float> dist(-1.0, 1.0);

    // Allocate memory for the array and initialize it with random floats
    float *arr = new float[n];
    for (int i = 0; i < n; i++) {
        arr[i] = dist(generator);
    }

    // Initialize variables for MPI
    float global_res = 0;
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // Barrier to synchronize MPI processes before starting the timer
    MPI_Barrier(MPI_COMM_WORLD);

    // Start timing
    auto start = high_resolution_clock::now();

    // Perform the reduction operation
    float result = reduce(arr, 0, n);

    // Combine results from all MPI processes
    MPI_Reduce(&result, &global_res, 1, MPI_FLOAT, MPI_SUM, 0, MPI_COMM_WORLD);

    // Stop timing
    auto end = high_resolution_clock::now();
    double ms = duration_cast<duration<double, milli>>(end - start).count();

    // Root process prints the result and time taken
    if (rank == 0) {
        printf("%f\n%f\n", global_res, ms);
    }

    // Clean up
    delete[] arr;
    MPI_Finalize();

    return 0;
}







