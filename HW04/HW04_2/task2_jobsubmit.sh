#!/bin/bash

threads_per_block=512
R=128

for N in $(seq 10 29)  
do 

	DIR="512_${N}"

	mkdir $DIR

	cp task2.sh task2.cu stencil.cu stencil.cuh $DIR

	cd $DIR

	sed '{s/{N}/'"$N"'/g}' < task2.sh > tmp1
	sed '{s/{threads_per_block}/'"$threads_per_block"'/g}' < tmp1 > tmp2
	sed '{s/{R}/'"$R"'/g}' < tmp2 > tmp3
	mv tmp3 task2.sh
	rm tmp*	

	sbatch task2.sh

	cd ..
	
done	
