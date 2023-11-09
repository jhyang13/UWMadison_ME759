#!/bin/bash

#SBATCH --job-name=task3
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=2
#SBATCH --mem=20G
#SBATCH --output=task3.out

cd $SLURM_SUBMIT_DIR

module load mpi/mpich/4.0.2

mpicxx task3.cpp -Wall -O3 -o task3

#srun -n 2 task3 1

srun -n 2 task3 {n}





