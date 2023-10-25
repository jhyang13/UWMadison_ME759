#!/bin/bash

for n in $(seq 10 20)  
do 

	DIR="thrust_${n}"

	mkdir $DIR

	cp task1_thrust.sh task1_thrust.cu $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task1_thrust.sh > tmp1
	sed '{s/{n}/'"$n"'/g}' < tmp1 > tmp2

	mv tmp2 task1_thrust.sh
	rm tmp*	

	sbatch task1_thrust.sh

	cd ..
	
done	
