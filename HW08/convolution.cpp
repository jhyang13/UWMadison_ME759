// convolution.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <omp.h>
#include "convolution.h"

// Declare an external variable for the threshold
extern int t; 

void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m)
{
    // Parallelize the convolution operation
    #pragma omp parallel for shared(image, output, mask, n, m) num_threads(t)
    for (std::size_t x = 0; x < n; x++)
    {
        for (std::size_t y = 0; y < n; y++)
        {
            for (std::size_t i = 0; i < m; i++)
            {
                for (std::size_t j = 0; j < m; j++)
                {
                    // Calculate indices and apply the mask to the image
                    std::size_t image_x = x + i - (m-1) / 2;
                    std::size_t image_y = y + j - (m-1) / 2;

                    if (image_x < n && image_y < n)
                    {
                        // Apply the mask to the image and accumulate the result in the output
                        output[x * n + y] += image[image_x * n + image_y] * mask[i * m + j];
                    }
                }
            }
        }
    }
}





