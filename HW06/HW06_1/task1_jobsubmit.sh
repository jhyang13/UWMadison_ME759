#!/bin/bash

n_tests=100

for n in $(seq 5 11)  
do 

	DIR="${n_tests}_${n}"

	mkdir $DIR

	cp task1.sh task1.cu mmul.cu mmul.h $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task1.sh > tmp1
	sed '{s/{n_tests}/'"$n_tests"'/g}' < tmp1 > tmp2
	mv tmp2 task1.sh
	rm tmp*	

	sbatch task1.sh

	cd ..
	
done	
