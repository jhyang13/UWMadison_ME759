// montecarlo.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include "montecarlo.h"
#include <omp.h>
#include <cstdlib>
#include <ctime>

// Declare an external variable
extern int t; 

int montecarlo(const size_t n, const float *x, const float *y, const float radius) {
    
    int incircle = 0;

    // Set the seed for random number generation
    std::srand(static_cast<unsigned int>(std::time(nullptr)));

    #pragma omp parallel for num_threads(t)
    for (size_t i = 0; i < n; i++) {
        float point_x = x[i];
        float point_y = y[i];

        // Check if the point is inside the circle
        if (point_x * point_x + point_y * point_y <= radius * radius) {
            #pragma omp atomic
            incircle++;
        }
    }

    return incircle;
}




