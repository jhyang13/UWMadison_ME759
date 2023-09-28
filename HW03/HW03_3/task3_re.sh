#!/bin/bash 

rm result.txt

echo result.txt

for N in $(seq 10 29)
do
       	
 	DIR="16_${N}"

	cd $DIR

	sed -n '1,1'p task3.out >> /srv/home/jyang753/repo759/HW03/HW03_3/result.txt

	cd ..
	
done	
