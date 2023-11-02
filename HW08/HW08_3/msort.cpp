// msort.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include "msort.h"
#include <vector>
#include <algorithm>
#include <iostream>

// Declare an external variable for the threshold
extern int t; 

// Function for merging two subarrays
void merge(int* arr, int* temp, std::size_t left, std::size_t middle, std::size_t right) {

    std::size_t i = left;
    std::size_t j = middle + 1;
    std::size_t k = left;

    // Merge two subarrays
    while (i <= middle && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k] = arr[i];
            i++;
        } else {
            temp[k] = arr[j];
            j++;
        }
        k++;
    }

    // Copy any remaining elements from the left subarray
    while (i <= middle) {
        temp[k] = arr[i];
        i++;
        k++;
    }

    // Copy any remaining elements from the right subarray
    while (j <= right) {
        temp[k] = arr[j];
        j++;
        k++;
    }

    // Copy the merged elements back to the original array
    for (std::size_t index = left; index <= right; index++) {
        arr[index] = temp[index];
    }
}

// Function for parallel merge sort
void msort(int* arr, const std::size_t n, const std::size_t threshold) {

    if (n <= threshold) {

        // Use a serial sorting algorithm when the array size is below the threshold
        std::sort(arr, arr + n);

    } else {
        
        // Recursively split the array into two halves
        std::size_t middle = n / 2;

        // Create temporary storage for merging
        std::vector<int> temp(n);

        // Sort the left and right halves in parallel using OpenMP tasks
        #pragma omp parallel num_threads(t)
        {
            #pragma omp single nowait
            {
                #pragma omp task
                msort(arr, middle, threshold);

                #pragma omp task
                msort(arr + middle, n - middle, threshold);
            }
        }

        // Merge the sorted halves
        merge(arr, temp.data(), 0, middle - 1, n - 1);
    }
}




