#!/bin/bash

n=5040000

for t in $(seq 1 10)  
do 

	DIR="${n}_${t}"

	mkdir $DIR

	cp task1.sh task1.cpp cluster.cpp cluster.h $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task1.sh > tmp1
	sed '{s/{t}/'"$t"'/g}' < tmp1 > tmp2
	mv tmp2 task1.sh
	rm tmp*	

	sbatch task1.sh

	cd ..
	
done	
