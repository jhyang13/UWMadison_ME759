#!/usr/bin/env zsh

#SBATCH -p instruction
#SBATCH -t 0-00:05:00
#SBATCH -J HW02_2_Slurm
#SBATCH -o HW02_2_Slurm.out -e HW02_2_Slurm.err
#SBATCH -c 2

cd $SLURM_SUBMIT_DIR

./task2 4 3

