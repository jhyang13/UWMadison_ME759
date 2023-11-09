#!/bin/bash

#SBATCH --job-name=task1
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --output=task1.out

cd $SLURM_SUBMIT_DIR

module load nvidia/cuda/11.8

g++ task1.cpp cluster.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp

./task1 5040000 1

#./task1 {n} {t}




