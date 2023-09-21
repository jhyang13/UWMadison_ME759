#ifndef MATMUL_H
#define MATMUL_H

#include <cstddef>
#include <vector>

// Each function produces a row-major representation of the matrix A and B
// The matrices A, B, and C are n by n
//void mmul1(const double* A, const double* B, double* C, const unsigned int n);
//void mmul2(const double* A, const double* B, double* C, const unsigned int n);
//void mmul3(const double* A, const double* B, double* C, const unsigned int n);
//void mmul4(const std::vector<double>& A, const std::vector<double>& B, double* C, const unsigned int n);
void mmul1(int n, int (*arra)[1000], int (*arrb)[1000]);
void mmul2(int n, int (*arra)[1000], int (*arrb)[1000]);
void mmul3(int n, int (*arra)[1000], int (*arrb)[1000]);
void mmul4(int n, std::vector<std::vector<int> > arra4, std::vector<std::vector<int> > arrb4);

#endif
