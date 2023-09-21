#!/bin/bash 

for N in $(seq 10 30)  
do 

	DIR="${N}"

	mkdir $DIR

	cp task1.sh task1 $DIR

	cd $DIR

	sed '{s/{N}/'"$N"'/g}' < task1.sh > tmp1
	sed '{s/{N}/'"$N"'/g}' < tmp1 > tmp2
	mv tmp2 task1.sh
	rm tmp*	

	sbatch task1.sh

	cd ..
	
done	
