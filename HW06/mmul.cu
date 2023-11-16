// mmul.cu

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
#include <cstdlib>
#include <cublas_v2.h>
#include "mmul.h"


void mmul(cublasHandle_t handle, const float* A, const float* B, float* C, int n){

    int lda = n, ldb = n, ldc = n;
    // Initialize the scaling factor for matrices A and B
    const float Alpha = 1;
    // Initialize the scaling factor for matrix C
    const float Beta = 1;
    const float *alpha = &Alpha;
    const float *beta = &Beta;

    /*
    // Test cublasSgemm
    cublasStatus_t sgemmStatus = cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, n, n, n, &alpha, A, n, B, n, &beta, C, n);
    if (sgemmStatus != CUBLAS_STATUS_SUCCESS) {
        std::cerr << "cuBLAS matrix multiplication failed." << std::endl;
    }*/

    // Initialize the cuBLAS context
    cublasCreate(&handle);
    // Perform C = A * B using cuBLAS
    cublasSgemm(handle, CUBLAS_OP_T, CUBLAS_OP_T, n, n, n, alpha, A, lda, B, ldb, beta, C,  ldc);
    // Destroy the cuBLAS context
    cublasDestroy(handle);

}




