//task1.cpp
#include <cstdio>
#include <iostream>
#include <string>
#include <ctime>
#include <cmath>
#include <cstdint>
#include "scan.h"
using namespace std;


int main(int argc, char **argv)
{

        // Use a variable to receive input number
        int k = atoi(argv[1]);

	// Use a variable to define the array length
	int length = pow(2, k);

        // Create the random array
	float randa[length];

	// Create the output array
	float outa[length];

	// Set up random seed
	srand (static_cast <unsigned> (time(0)));

	// Assign random float elements to the randa array
	for( int i = 0; i < length; i++ ){

		randa[i] = -1.0 + static_cast <float> (rand()) / (static_cast <float> (RAND_MAX/(2.0)));
		
		// Print each element in the array
		//printf("%.1f\n", randa[i]);
	
	}

	// Call the scan function
	scan(randa, outa, length);
		
	return 0;	

}

