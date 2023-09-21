// task3.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <cmath>
#include <vector>
#include "matmul.h"
using namespace std;


int main(int argc, char **argv)
{

        // Use a variable to define square matrices
        int length = 1000;

        // Create the two matrices A and B
	int A[length][1000];
	int B[length][1000];

	// Set up random seed
	srand (static_cast <unsigned> (time(0)));

	// Assign values to matrices A and B
	for( int i = 0; i < length; i++ ){
		for( int j = 0; j < length; j++ ){

			A[i][j] = rand() % 10 + 1;

			B[i][j] = rand() % 10 + 1;

		}
	}

	// Call the mmul1, mmul2, mmul3 function
	mmul1(length, A, B);
	mmul2(length, A, B);
	mmul3(length, A, B);

	// Set up the two matrices A4 and B4 for mmul4
	std::vector<std::vector<int>> A4(length, std::vector<int>(1000, rand() % 10 + 1));
	std::vector<std::vector<int>> B4(length, std::vector<int>(1000, rand() % 10 + 1));

	// Call the mmul4 function
	mmul4(length, A4, B4);
		
	return 0;	

}

