#!/bin/bash

#SBATCH --job-name=task3
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=20G
#SBATCH --output=task3.out

cd $SLURM_SUBMIT_DIR

module load nvidia/cuda/11.8

g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

./task3 6 8 5

#./task3 {n} {t} {ts}




