// cluster.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include "cluster.h"
#include <cmath>
#include <iostream>

void cluster(const size_t n, const size_t t, const float *arr,const float *centers, float *dists) {
	
#pragma omp parallel num_threads(t)
  {
    unsigned int tid = omp_get_thread_num();
    float local_dist = 0.0;  // Each thread has its own local variable.

#pragma omp for
    for (size_t i = 0; i < n; i++) {
      local_dist += std::fabs(arr[i] - centers[tid]);
    }

// After the loop, update the shared 'dists' array.
#pragma omp critical
    {
      dists[tid] = local_dist;
    }
  }
}




