// convolution.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <stddef.h>
#include <vector>
#include <cmath>
using namespace std;

#include <chrono>
#include <ratio>
#include <iostream>
#include <cmath>
using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;


void convolve(int N, int M, float (*arri)[10000], float (*arrm)[10000])
{

	// Set up time counter
	high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

	// Start count time
	auto startcount = high_resolution_clock::now();

	// Create a new matrix G
	float G[10000][10000];

	// Loop to calculate each element in C
	for( int x = 0; x < N; x++ ){
		for( int y = 0; y < N; y++ ){
			for( int i = 0; i < M; i++ ){
				for( int j = 0; j < M; j++ ){
			
					// Set up boundary conditions	
					if(i < 0 && i >= N && j < 0 && j >=N)
					{ 
						arri[i][j] = 0;
					}
					else if( i >= 0 && i < N)
					{
						arri[i][j] = 1;
					}
					else if(j >= 0 && j < N)
					{
						arri[i][j] = 1;
					}
					
					// Apply the mask to image
					G[x][y] = arrm[i][j] * arri[x+i-(M-1)/2][y+j-(M-1)/2];
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
	printf("%f\n", G[N-1][N-1]);

}
