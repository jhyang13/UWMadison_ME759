#!/bin/bash

for n in $(seq 10 20)  
do 

	DIR="cub_${n}"

	mkdir $DIR

	cp task1_cub.sh task1_cub.cu $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task1_cub.sh > tmp1
	sed '{s/{n}/'"$n"'/g}' < tmp1 > tmp2

	mv tmp2 task1_cub.sh
	rm tmp*	

	sbatch task1_cub.sh

	cd ..
	
done	
