#!/bin/bash

#SBATCH --job-name=task3
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=task3.out

cd $SLURM_SUBMIT_DIR

module load nvidia/cuda/11.8.0 
module load gcc/11.3.0

g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

./task3

