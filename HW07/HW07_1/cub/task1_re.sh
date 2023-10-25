#!/bin/bash

if [ -f "result.txt" ]; then

    rm "result.txt"

fi


touch "result.txt"


for n in $(seq 10 20)
do
 
	DIR="cub_${n}"

	cd "$DIR"

  	sed -n '6,6p' task1_cub.out >> "/srv/home/jyang753/repo759/HW07/HW07_1/cub/result.txt"

	cd ..

done
	
