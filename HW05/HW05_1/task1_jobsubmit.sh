#!/bin/bash

block_dim=64

for n in $(seq 5 14)  
do 

	DIR="${block_dim}_${n}"

	mkdir $DIR

	cp task1.sh task1.cu matmul.cu matmul.cuh $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task1.sh > tmp1
	sed '{s/{block_dim}/'"$block_dim"'/g}' < tmp1 > tmp2
	mv tmp2 task1.sh
	rm tmp*	

	sbatch task1.sh

	cd ..
	
done	
