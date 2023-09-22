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
	double a[length][1000];
	double b[length][1000];
	double c[length][1000];

	// Set up random seed
	srand (static_cast <unsigned> (time(0)));

	// Assign values to matrices A and B
	for( int i = 0; i < length; i++ ){
		for( int j = 0; j < length; j++ ){

			a[i][j] = rand() % 10 + 1;

			b[i][j] = rand() % 10 + 1;

		}
	}

	// Call the mmul1, mmul2, mmul3 function
	mmul1(*a, *b, *c, length);
	mmul2(*a, *b, *c, length);
	mmul3(*a, *b, *c, length);

	// Set up the two matrices A4 and B4 for mmul4
	std::vector<std::vector<double>> A4(length, std::vector<double>(1000, rand() % 10 + 1));
	std::vector<std::vector<double>> B4(length, std::vector<double>(1000, rand() % 10 + 1));

	// Call the mmul4 function
	mmul4(std::vector<double>(A4[0].begin(), A4[0].end()), std::vector<double>(B4[0].begin(), B4[0].end()), *c, length);
		
	return 0;	

}

