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


void mmul1(const double* A, const double* B, double* C, const unsigned int n)
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
	double Cnew[n][n];

	// Loop to calculate each element in C
	for( unsigned int i = 0; i < n; i++ ){
		for( unsigned int j = 0; j < n; j++ ){
			for( unsigned int k = 0; k < n; k++ ){
				
				// Assign element to C
				double AA = *(A+i)+j;
				double BB = *(B+i)+j;

				Cnew[i][j] +=  AA * BB;

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
	fflush(stdout);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";
	fflush(stdout);

	// Print the last element of the output scanned array
	printf("%f\n", Cnew[n-1][n-1]);
	fflush(stdout);

}


void mmul2(const double* A, const double* B, double* C, const unsigned int n)
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
	double Cnew[n][n];

        // Loop to calculate each element in C
        for( unsigned int i = 0; i < n; i++ ){
                for( unsigned int k = 0; k < n; k++ ){

			// The single line of code which increments Cij
			sum = sum + k;
                        
			for( unsigned int j = 0; j < n; j++ ){

                                // Assign element to C
				double AA = *(A+i)+j;
                                double BB = *(B+i)+j;

                                Cnew[i][j] +=  AA * BB;


                        }

                }
        }


        // Stop count time
        auto endcount = high_resolution_clock::now();

        // Convert the calculated duration to a double using the standard library
        duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Print the number of rows of your input matrices
        printf("%d\n", n);
	fflush(stdout);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";
	fflush(stdout);

        // Print the last element of the output scanned array
        printf("%f\n", Cnew[n-1][n-1]);
	fflush(stdout);

}


void mmul3(const double* A, const double* B, double* C, const unsigned int n)
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
	double Cnew[n][n];

        // Loop to calculate each element in C
        for( unsigned int j = 0; j < n; j++ ){
                for( unsigned int k = 0; k < n; k++ ){
                        
			// The single line of code which increments Cij
			sum = sum + k;

                        for( unsigned int i = 0; i < n; i++ ){

                                // Assign element to C
				double AA = *(A+i)+j;
                                double BB = *(B+i)+j;

                                Cnew[i][j] +=  AA * BB;


                        }

                }
        }


        // Stop count time
        auto endcount = high_resolution_clock::now();

        // Convert the calculated duration to a double using the standard library
        duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Print the number of rows of your input matrices
        printf("%d\n", n);
	fflush(stdout);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";
	fflush(stdout);

        // Print the last element of the output scanned array
        printf("%f\n", Cnew[n-1][n-1]);
	fflush(stdout);

}


void mmul4(const std::vector<double>& A, const std::vector<double>& B, double* C, const unsigned int n)
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
	double Cnew[n][n];

        // Loop to calculate each element in C
        for( unsigned int i = 0; i < n; i++ ){
                for( unsigned int j = 0; j < n; j++ ){
                        for( unsigned int k = 0; k < n; k++ ){

                                // Assign element to C
				Cnew[i][j] += A[i * n + k] * B[k * n + j];

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
	fflush(stdout);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";
	fflush(stdout);

        // Print the last element of the output scanned array
        printf("%f\n", Cnew[n-1][n-1]);
	fflush(stdout);

}




