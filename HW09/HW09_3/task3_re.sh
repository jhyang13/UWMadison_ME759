#!/bin/bash

if [ -f "result.txt" ]; then

    rm "result.txt"

fi


touch "result.txt"


for n in $(seq 1 25)  
do
 
	DIR="${n}"

	cd "$DIR"

  	sed -n '1,1p' task3.out >> "/srv/home/jyang753/repo759/HW09/HW09_3/result.txt"

	cd ..

done




