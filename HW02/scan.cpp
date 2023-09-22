// scan.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <stddef.h>
#include <cmath>
#include <cstdint>
using namespace std;

#include <chrono>
#include <ratio>
#include <iostream>
#include <cmath>
using std::cout;
using std::chrono::high_resolution_clock;
using std::chrono::duration;


void scan(const float *arr, float *output, std::size_t n)
{

	// Set up time counter
	high_resolution_clock::time_point start;
        high_resolution_clock::time_point end;
        duration<double, std::milli> duration_sec;

	// Start count time
	auto startcount = high_resolution_clock::now();

	// Create the random array
        float scana[n];

	// Assign value to scana[0]
	scana[0] = arr[0];

	// Loop to assign value to scana
	for( int i = 0; i < n-1; i++ ){
	
		scana[i+1] = scana[i] + arr[i+1];

		// Print each element in arr
		//printf("%.1f\n", scana[i+1]);
		
	}
	
	// Stop count time
	auto endcount = high_resolution_clock::now();

	// Convert the calculated duration to a double using the standard library
    	duration_sec = std::chrono::duration_cast<duration<double, std::milli>>(endcount - startcount);

        // Durations are converted to milliseconds already thanks to std::chrono::duration_cast
        cout << duration_sec.count() << "\n";

	// Print the first element of the output scanned array
	printf("%.1f\n", scana[0]);

	// Print the last element of the output scanned array
	printf("%.1f\n", scana[n-1]);

}

