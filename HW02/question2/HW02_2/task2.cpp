// task2.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <cmath>
#include <vector>
#include "convolution.h"
using namespace std;


int main(int argc, char **argv)
{

        // Use variables to define square matrices
        int n = atoi(argv[1]);
	int m = atoi(argv[2]);

        // Create the two matrices image and mask
	float image[n][10000];
	float mask[m][10000];

	// Set up random seed
	srand (static_cast <unsigned> (time(0)));

	// Assign values to image matrix
	for( int i = 0; i < n; i++ ){
		for( int j = 0; j < n; j++ ){

			image[i][j] = -10.0 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX/(20.0)));
			
			// Print each element in the array
                	//printf("%.1f\n", image[i][j]);

		}
	}


	// Assign values to mask matrix
        for( int i = 0; i < m; i++ ){
                for( int j = 0; j < m; j++ ){

                	mask[i][j] = -1.0 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX/(2.0)));

			// Print each element in the array
                        //printf("%.1f\n", mask[i][j]);

                }
        }

	// Call the convolve function
	convolve(n, m, image, mask);
		
	return 0;	

}

