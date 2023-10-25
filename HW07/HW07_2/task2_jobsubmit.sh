#!/bin/bash

for n in $(seq 5 20)  
do 

	DIR="${n}"

	mkdir $DIR

	cp task2.sh task2.cu count.cu count.cuh $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task2.sh > tmp1
	sed '{s/{n}/'"$n"'/g}' < tmp1 > tmp2
	mv tmp2 task2.sh
	rm tmp*	

	sbatch task2.sh

	cd ..
	
done	
