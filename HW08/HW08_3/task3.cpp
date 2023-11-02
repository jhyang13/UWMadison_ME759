// task3.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <vector>
#include <chrono>
#include <cmath> 
#include "msort.h"

// Threshold for sorting
int t;

int main(int argc, char* argv[]) {

    // Create the variables to receive the input number
    // Length of the array
    int n = pow(10, atoi(argv[1]));

    // Number of threads (unused variable)
    t = atol(argv[2]);

    // Threshold as a power of 2
    int ts = pow(2, atoi(argv[3]));

    // Create and fill an array with random integers
    // in the range [-1000, 1000]
    std::vector<int> arr(n);
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 2001 - 1000;
    }

    // Start timing
    auto start = std::chrono::high_resolution_clock::now();

    // Call the msort function to sort the array with t threads and ts threshold
    msort(arr.data(), n, ts);

    // Stop timing
    auto end = std::chrono::high_resolution_clock::now();

    // Create a variable to store the duration time
    std::chrono::duration<double> duration = end - start;

    // Print the first elements of the resulting array
    std::cout << arr[0] << std::endl;

    // Print the last elements of the resulting array
    std::cout << arr[n - 1] << std::endl;

    // Print the time taken in milliseconds
    std::cout << duration.count() * 1000 << std::endl;

    return 0;
    
}





