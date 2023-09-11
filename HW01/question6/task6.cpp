// This is the C++ codes for question6 
#include <cstdio>
#include <iostream>
#include <string>
using namespace std;

int main() {
	
	// Use n to receive input
	int n;

	cin >> n;

	// Print the ascending result
	for( int n = 0; n < 7; n = n + 1 ){

		printf("%d\n", n);
				
	}

	// Print the descending result
        for( int n = 6; n >= 0; n = n - 1 ){

                std::cout << n << std::endl;

        }

	return 0;
	
}
