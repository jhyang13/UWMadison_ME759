#!/bin/bash

n=6

for t in $(seq 1 10)  
do

	DIR="${n}_${t}"

	mkdir $DIR

	cp task2.sh task2.cpp montecarlo.cpp montecarlo.h $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task2.sh > tmp1
	sed '{s/{t}/'"$t"'/g}' < tmp1 > tmp2
	mv tmp2 task2.sh
	rm tmp*	

	sbatch task2.sh

	cd ..
	
done	



