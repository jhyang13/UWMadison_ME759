#!/bin/bash 

rm 512_result.txt

echo 512_result.txt

for N in $(seq 5 14)
do
       	
 	DIR="512_${N}"

	cd $DIR

	sed -n '2,2'p task1.out >> /srv/home/jyang753/repo759/HW04/HW04_1/512_result.txt

	cd ..
	
done	
