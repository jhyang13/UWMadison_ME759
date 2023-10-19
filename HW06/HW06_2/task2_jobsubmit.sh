#!/bin/bash

threads_per_block=1024

for n in $(seq 10 16)  
do 

	DIR="${threads_per_block}_${n}"

	mkdir $DIR

	cp task2.sh task2.cu scan.cu scan.cuh $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task2.sh > tmp1
	sed '{s/{threads_per_block}/'"$threads_per_block"'/g}' < tmp1 > tmp2
	mv tmp2 task2.sh
	rm tmp*	

	sbatch task2.sh

	cd ..
	
done	
