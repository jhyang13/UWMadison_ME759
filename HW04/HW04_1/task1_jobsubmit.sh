#!/bin/bash

threads_per_block=512

for N in $(seq 5 29)  
do 

	DIR="512_${N}"

	mkdir $DIR

	cp task1.sh task1.cu matmul.cu matmul.cuh $DIR

	cd $DIR

	sed '{s/{N}/'"$N"'/g}' < task1.sh > tmp1
	sed '{s/{threads_per_block}/'"$threads_per_block"'/g}' < tmp1 > tmp2
	mv tmp2 task1.sh
	rm tmp*	

	sbatch task1.sh

	cd ..
	
done	
