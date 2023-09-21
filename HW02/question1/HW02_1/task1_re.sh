#!/bin/bash 

rm result.txt

echo result.txt

for N in $(seq 10 30)
do
       	
 	DIR="${N}"

	cd $DIR

	sed -n '1,1'p HW02_1_Slurm_${N}.out >> /srv/home/jyang753/repo759/HW02_1/result.txt

	cd ..
	
done	
