#!/usr/bin/env zsh

#SBATCH --job-name=task1
#SBATCH --partition=instruction
#SBATCH --time=00-00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --output=task1.out

cd $SLURM_SUBMIT_DIR

module load nvidia/cuda/11.8

nvcc task1.cu matmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task1

./task1 5 16

#./task1 {n} {block_dim}

