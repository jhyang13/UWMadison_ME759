// matmul.cu

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
#include "matmul.cuh"

// Define the block size
#define BLOCK_SIZE 16

/*
// Without using shared memory
// Used for different types
template <typename T>
__global__ void matmul_kernel(const T* A, const T* B, T* C, unsigned int n){

    // The row index and column index of each thread in a two-dimensional grid
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;

    // Create a variable to save current result
    T sum = 0;

    for (int k = 0; k < n; k++) {

        // Create variables to save current result
        T a = A[row * n + k];
        T b = B[k * n + col];

        // Save the result
        sum += a * b;

    }

    // Assign new element to C
    C[row * n + col] = sum;

}*/


// Use shared memory
// Used for different types
template <typename T>
__global__ void matmul_kernel(const T* A, const T* B, T* C, unsigned int n){

    // The row index and column index of each thread in a two-dimensional grid
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;

    // Create shared memory for caching A and B submatrices
    __shared__ T shared_A[BLOCK_SIZE][BLOCK_SIZE];
    __shared__ T shared_B[BLOCK_SIZE][BLOCK_SIZE];

    // Create a variable to save current result
    T sum = 0;

    // Calculate the number of submatrices
    int num_submatrices = n / BLOCK_SIZE;

    for (int i = 0; i < num_submatrices; i++) {

        // Load A and B submatrices into shared memory
        shared_A[threadIdx.y][threadIdx.x] = A[row * n + i * BLOCK_SIZE + threadIdx.x];
        shared_B[threadIdx.y][threadIdx.x] = B[(i * BLOCK_SIZE + threadIdx.y) * n + col];

        // Synchronize threads to ensure data is loaded
        __syncthreads();

        // Perform matrix multiplication on the submatrices in shared memory
        for (int k = 0; k < BLOCK_SIZE; k++) {
            sum += shared_A[threadIdx.y][k] * shared_B[k][threadIdx.x];
        }

        // Synchronize threads to ensure computation is done
        __syncthreads();
    }

    // Assign the result to the appropriate element in C
    C[row * n + col] = sum;

}


__host__ void matmul_1(const int *A, const int *B, int *C, unsigned int n, unsigned int block_dim){

    // Setting the dimensions of thread blocks and grids
    dim3 block(block_dim, block_dim);
    dim3 grid((n + block.x - 1) / block.x, (n + block.y - 1) / block.y);

    // Launch the matrix multiplication kernel
    matmul_kernel<<<grid, block>>>(A, B, C, n);

    // Wait for the kernel to finish
    cudaDeviceSynchronize();

}

__host__ void matmul_2(const float *A, const float *B, float *C, unsigned int n, unsigned int block_dim){

    // Setting the dimensions of thread blocks and grids
    dim3 block(block_dim, block_dim);
    dim3 grid((n + block.x - 1) / block.x, (n + block.y - 1) / block.y);

    // Launch the matrix multiplication kernel
    matmul_kernel<<<grid, block>>>(A, B, C, n);

    // Wait for the kernel to finish
    cudaDeviceSynchronize();

}

__host__ void matmul_3(const double *A, const double *B, double *C, unsigned int n, unsigned int block_dim){

    // Setting the dimensions of thread blocks and grids
    dim3 block(block_dim, block_dim);
    dim3 grid((n + block.x - 1) / block.x, (n + block.y - 1) / block.y);

    // Launch the matrix multiplication kernel
    matmul_kernel<<<grid, block>>>(A, B, C, n);

    // Wait for the kernel to finish
    cudaDeviceSynchronize();

}


