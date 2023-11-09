// task3.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include <iostream>
#include <cstdlib>
#include <mpi.h>
#include <cmath>

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int receive = std::atoi(argv[1]);
    int n = std::pow(2.0, static_cast<double>(receive));
    float *send_data = new float[n];
    float *recv_data = new float[n];

    // Initialize the send_data array (you can fill it with actual data)
    for (int i = 0; i < n; i++) {
        send_data[i] = static_cast<float>(i);
    }

    // Record the start time
    double start_time = MPI_Wtime();

    if (rank == 0) {
        // Process 0 starts the communication
        MPI_Send(send_data, n, MPI_FLOAT, 1, 0, MPI_COMM_WORLD);
        MPI_Recv(recv_data, n, MPI_FLOAT, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    } else if (rank == 1) {
        // Process 1 waits for the message
        MPI_Recv(recv_data, n, MPI_FLOAT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        // Process 1 sends a response
        MPI_Send(send_data, n, MPI_FLOAT, 0, 0, MPI_COMM_WORLD);
    }

    // Record the end time
    double end_time = MPI_Wtime();

    // Calculate the time taken for both processes to complete
    double total_time = end_time - start_time;

    if (rank == 0) {
        // Process 0 collects and prints the total time
        MPI_Recv(&total_time, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        std::cout << total_time * 1000.0 << std::endl;
    } else if (rank == 1) {
        // Process 1 sends the total time to Process 0
        MPI_Send(&total_time, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
    }

    delete[] send_data;
    delete[] recv_data;

    MPI_Finalize();
    return 0;
}





