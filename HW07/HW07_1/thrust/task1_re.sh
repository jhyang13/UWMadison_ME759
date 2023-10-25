#!/bin/bash

if [ -f "result.txt" ]; then

    rm "result.txt"

fi


touch "result.txt"


for n in $(seq 10 20)
do
 
	DIR="thrust_${n}"
	cd "$DIR"

  	sed -n '6,6p' task1_thrust.out >> "/srv/home/jyang753/repo759/HW07/HW07_1/thrust/result.txt"

	cd ..

done
	
