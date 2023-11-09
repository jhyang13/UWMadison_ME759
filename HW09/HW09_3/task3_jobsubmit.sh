#!/bin/bash

for n in $(seq 1 25)  
do 

	DIR="${n}"

	mkdir $DIR

	cp task3.sh task3.cpp $DIR

	cd $DIR

	sed "s/{n}/$n/g" < task3.sh > tmp1

	mv tmp1 task3.sh

	sbatch task3.sh

	cd ..
	
done	





