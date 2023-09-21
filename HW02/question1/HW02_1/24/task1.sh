#!/usr/bin/env zsh

#SBATCH -p instruction
#SBATCH -t 0-00:05:00
#SBATCH -J HW02_1_24_Slurm
#SBATCH -o HW02_1_Slurm_24.out -e HW02_1_Slurm_24.err
#SBATCH -c 2

cd $SLURM_SUBMIT_DIR

./task1 24

