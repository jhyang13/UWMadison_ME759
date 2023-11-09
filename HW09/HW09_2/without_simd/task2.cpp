// task2.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <chrono>
#include <random>
#include "montecarlo.h"

// Declare a global variable to store the number of threads
int t;

int main(int argc, char *argv[]) {

    int exponent = std::atoi(argv[1]);  // Parse the input as an integer
    std::size_t n = static_cast<std::size_t>(std::pow(10, exponent));
    t = std::atol(argv[2]);

    float *x = new float[n];
    float *y = new float[n];

    // Create and fill arrays x and y with random numbers in the range [-1.0, 1.0]
    std::random_device rd;
    std::default_random_engine eng(rd());
    std::uniform_real_distribution<float> distr(-1.0, 1.0);
    for (std::size_t i = 0; i < n; ++i) {
        x[i] = distr(eng);
        y[i] = distr(eng);
    }

    // Set the radius of the circle
    float radius = 1.0;

    // Start the timer
    auto start = std::chrono::high_resolution_clock::now();

    // Call the montecarlo function to estimate π and count points in the circle
    int incircle = montecarlo(n, x, y, radius);

    // Stop the timer
    auto end = std::chrono::high_resolution_clock::now();

    // Calculate the time taken in milliseconds
    std::chrono::duration<double> duration = end - start;
    double duration_ms = duration.count() * 1000;

    // Calculate the estimated value of π
    double pi_estimate = 4.0 * static_cast<double>(incircle) / static_cast<double>(n);

    // Print the estimated π value
    std::cout << pi_estimate << std::endl;

    // Print the time taken in milliseconds
    std::cout << duration_ms << std::endl;

    // Clean up memory
    delete[] x;
    delete[] y;

    return 0;
}



