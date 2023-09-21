// scan.cpp
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


void mmul1(int n, int (*arra)[1000], int (*arrb)[1000])
{

	// Set up time counter
	high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

	// Start count time
	auto startcount = high_resolution_clock::now();

        // Create a variable which increments Cij
	int sum = 0;

	// Create a new matrix C
	int C[n][n];

	// Loop to calculate each element in C
	for( int i = 0; i < n; i++ ){
		for( int j = 0; j < n; j++ ){
			for( int k = 0; k < n; k++ ){
				
				// Assign element to C
				C[i][j] +=  arra[i][k] * arrb[k][j];

				// The single line of code which increments Cij
				sum = sum + k;
			}
		}
	}

	
	// Stop count time
	auto endcount = high_resolution_clock::now();

	// Convert the calculated duration to a double using the standard library
    	duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

	// Print the number of rows of your input matrices
	printf("%d\n", n);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

	// Print the last element of the output scanned array
	printf("%d\n", C[n-1][n-1]);

}


void mmul2(int n, int (*arra)[1000], int (*arrb)[1000])
{

	// Set up time counter
        high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

        // Start count time
        auto startcount = high_resolution_clock::now();

        // Create a variable which increments Cij
	int sum = 0;

	// Create a new matrix C
	int C[n][n];

        // Loop to calculate each element in C
        for( int i = 0; i < n; i++ ){
                for( int k = 0; k < n; k++ ){

			// The single line of code which increments Cij
			sum = sum + k;
                        
			for( int j = 0; j < n; j++ ){

                                // Assign element to C
				C[i][j] +=  arra[i][k] * arrb[k][j];

                        }

                }
        }


        // Stop count time
        auto endcount = high_resolution_clock::now();

        // Convert the calculated duration to a double using the standard library
        duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Print the number of rows of your input matrices
        printf("%d\n", n);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

        // Print the last element of the output scanned array
        printf("%d\n", C[n-1][n-1]);

}


void mmul3(int n, int (*arra)[1000], int (*arrb)[1000])
{

	// Set up time counter
        high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

        // Start count time
        auto startcount = high_resolution_clock::now();

        // Create a variable which increments Cij
	int sum = 0;

	// Create a new matrix C
	int C[n][n];

        // Loop to calculate each element in C
        for( int j = 0; j < n; j++ ){
                for( int k = 0; k < n; k++ ){
                        
			// The single line of code which increments Cij
			sum = sum + k;

                        for( int i = 0; i < n; i++ ){

                                // Assign element to C
				C[i][j] +=  arra[i][k] * arrb[k][j];

                        }

                }
        }


        // Stop count time
        auto endcount = high_resolution_clock::now();

        // Convert the calculated duration to a double using the standard library
        duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Print the number of rows of your input matrices
        printf("%d\n", n);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

        // Print the last element of the output scanned array
        printf("%d\n", C[n-1][n-1]);

}


void mmul4(int n, std::vector<std::vector<int> > arra4, std::vector<std::vector<int> > arrb4)
{

	// Set up time counter
        high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

        // Start count time
        auto startcount = high_resolution_clock::now();

        // Create a variable which increments Cij
	int sum = 0;

	// Create a new matrix C
	int C[n][n];

        // Loop to calculate each element in C
        for( int i = 0; i < n; i++ ){
                for( int j = 0; j < n; j++ ){
                        for( int k = 0; k < n; k++ ){

                                // Assign element to C
				C[i][j] +=  arra4[i][k] * arrb4[k][j];

				// The single line of code which increments Cij
				sum = sum + k;
                        }
                }
        }


        // Stop count time
        auto endcount = high_resolution_clock::now();

        // Convert the calculated duration to a double using the standard library
        duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Print the number of rows of your input matrices
        printf("%d\n", n);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

        // Print the last element of the output scanned array
        printf("%d\n", C[n-1][n-1]);

}




