// This is the C++ codes for question6 
#include <cstdio>
#include <iostream>
#include <string>
using namespace std;

int main(int argc, char **argv) 
{
	
	// Use n to receive input
	int n = atoi(argv[1]);

	// Print the ascending result
	for( int i = 0; i <= n; i = i + 1 ){

		printf("%-2d", i);
				
	}

	printf("\n");

	// Print the descending result
        for( int i = n; i >= 0; i = i - 1 ){

                std::cout << i << " ";

        }

	return 0;
	
}
