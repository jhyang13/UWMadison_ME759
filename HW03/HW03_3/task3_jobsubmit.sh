#!/bin/bash 

for N in $(seq 10 29)  
do 

	DIR="512_${N}"

	mkdir $DIR

	cp task3.sh task3.cu vscale.cu vscale.cuh $DIR

	cd $DIR

	sed '{s/{N}/'"$N"'/g}' < task3.sh > tmp1
	sed '{s/{N}/'"$N"'/g}' < tmp1 > tmp2
	mv tmp2 task3.sh
	rm tmp*	

	sbatch task3.sh

	cd ..
	
done	
