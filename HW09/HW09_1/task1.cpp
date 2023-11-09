// task1.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <chrono>
#include <algorithm>
#include <random>
#include "cluster.h"

int main(int argc, char *argv[]) {
    
    // Create the variables to receive the input number
    std::size_t n = std::atol(argv[1]);
    std::size_t t = std::atol(argv[2]);

    // Create and fill an array 'arr' with random float numbers in the range [0, n]
    std::vector<float> arr(n);
    std::random_device rd;
    std::default_random_engine eng(rd());
    std::uniform_real_distribution<float> distr(0, static_cast<float>(n));
    for (std::size_t i = 0; i < n; ++i) {
        arr[i] = distr(eng);
    }

    // Sort the array 'arr' for efficient processing
    std::sort(arr.begin(), arr.end());

    // Create and fill an array 'centers' with calculated values
    std::vector<float> centers(t);
    for (std::size_t i = 0; i < t; ++i) {
        centers[i] = (2 * i + 1) * n / (2.0 * t);
    }

    // Create and initialize the 'dists' array with zeros to store distances
    std::vector<float> dists(t, 0.0);

    // Start the timer to measure execution time
    auto start = std::chrono::high_resolution_clock::now();

    // Call the cluster function to compute distances and store them in 'dists'
    cluster(n, t, &arr[0], &centers[0], &dists[0]);

    // Stop the timer
    auto end = std::chrono::high_resolution_clock::now();

    // Calculate the time taken in milliseconds
    std::chrono::duration<double> duration = end - start;
    double duration_ms = duration.count() * 1000;

    // Find the maximum distance among partitions
    float max_distance = *std::max_element(dists.begin(), dists.end());

    // Find the partition ID with the maximum distance
    std::size_t max_partition_id = std::distance(dists.begin(), std::max_element(dists.begin(), dists.end()));

    // Print the maximum distance
    std::cout << max_distance << std::endl;

    // Print the partition ID with the maximum distance
    std::cout << max_partition_id << std::endl;

    // Print the time taken in milliseconds
    std::cout << duration_ms << std::endl;

    return 0;
}





