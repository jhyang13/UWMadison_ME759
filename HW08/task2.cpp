// task2.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <chrono>
#include <random>
#include "convolution.h"

// Declare a global variable to store the number of threads
int t;

int main(int argc, char *argv[]) {

    // Create the variables to receive the input number
    int n = atol(argv[1]); 
    t = atol(argv[2]);

    // Create and initialize the input image (n x n square matrix) and mask (3 x 3)
    float* image = new float[n * n];
    float* output = new float[n * n];
    float* mask = new float[3 * 3];

    // Initialize the image with random float values between -10.0 and 10.0
    std::random_device rd;
    std::default_random_engine eng(rd());
    std::uniform_real_distribution<float> distr(-10.0, 10.0);
    for (std::size_t i = 0; i < n * n; i++) {
        image[i] = distr(eng);
    }

    // Initialize the mask with random float values between -1.0 and 1.0
    std::uniform_real_distribution<float> mask_distr(-1.0, 1.0);
    for (std::size_t i = 0; i < 3 * 3; i++) {
        mask[i] = mask_distr(eng);
    }

    // Start the timer
    auto start = std::chrono::high_resolution_clock::now();

    // Perform the convolution operation
    convolve(image, output, n, mask, 3);

    // Stop the timer
    auto end = std::chrono::high_resolution_clock::now();

    // Create a variable to store the duration time
    std::chrono::duration<double> duration = end - start;

    // Print the first and last elements of the resulting output array
    std::cout << output[0] << std::endl;
    std::cout << output[n * n - 1] << std::endl;

    // Print the time taken in milliseconds
    std::cout << duration.count() * 1000 << std::endl;

    // Deallocate memory
    delete[] image;
    delete[] output;
    delete[] mask;

    return 0;
}





