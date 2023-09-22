// convolution.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <stddef.h>
#include <vector>
#include <cmath>
#include <cstdint>
#include<cstring>
using namespace std;

#include <chrono>
#include <ratio>
#include <iostream>
#include <cmath>
using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;


void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m)
{

	// Set up time counter
	high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

	// Start count time
	auto startcount = high_resolution_clock::now();

	// Create a new matrix G
	float G[10000][10000];

	// Create a new matrix image
	float newimage[n * 10000];
	
	// Assign image to newimage
	memcpy(newimage, image, n * 10000 * sizeof(float));
	
	// Loop to calculate each element in C
	for( std::size_t x = 0; x < n; x++ ){
		for( std::size_t y = 0; y < n; y++ ){
			for( std::size_t i = 0; i < m; i++ ){
				for( std::size_t j = 0; j < m; j++ ){
			
					// Set up boundary conditions	
					if(i < 0 && i >= n && j < 0 && j >=n)
					{ 
						newimage[i * n + j] = 0.0f;
						//image[i][j] = 0;
					}
					else if( i >= 0 && i < n)
					{
						newimage[i * n + j] = 0.0f;
						//image[i][j] = 1;
					}
					else if(j >= 0 && j < n)
					{
						newimage[i * n + j] = 1.0f;
						//image[i][j] = 1;
					}
					
					// Apply the mask to image
					G[x][y] = *(mask+i*m+j) * *(newimage+(x+i-(m-1)/2)*n+(y+j-(m-1)/2));

				}
			}
		}
	}

	
	// Stop count time
	auto endcount = high_resolution_clock::now();
	
	// Convert the calculated duration to a double using the standard library
    	duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

	// Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

	// Print the last element of the output scanned array
	printf("%f\n", G[0][0]);

	// Print the last element of the output scanned array
	printf("%f\n", G[n-1][n-1]);

}
