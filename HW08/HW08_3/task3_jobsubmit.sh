#!/bin/bash

n=6
ts=10 

for t in $(seq 1 20)  
do 

	DIR="${n}_${ts}_${t}"

	mkdir $DIR

	cp task3.sh task3.cpp msort.cpp msort.h $DIR

	cd $DIR

	sed '{s/{n}/'"$n"'/g}' < task3.sh > tmp1
	sed '{s/{t}/'"$t"'/g}' < tmp1 > tmp2
	sed '{s/{ts}/'"$ts"'/g}' < tmp2 > tmp3

	mv tmp3 task3.sh
	rm tmp*	

	sbatch task3.sh

	cd ..
	
done	



