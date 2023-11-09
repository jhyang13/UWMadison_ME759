#!/bin/bash

#SBATCH --job-name=task2
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --output=task2.out

cd $SLURM_SUBMIT_DIR

module load nvidia/cuda/11.8

g++ task2.cpp montecarlo.cpp -Wall -O3 -std=c++17 -o task2 -fopenmp -fno-tree-vectorize -march=native -fopt-info-vec

./task2 6 1

#./task2 {n} {t}




