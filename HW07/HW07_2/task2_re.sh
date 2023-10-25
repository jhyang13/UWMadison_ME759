#!/bin/bash

if [ -f "result.txt" ]; then

    rm "result.txt"

fi


touch "result.txt"


for n in $(seq 5 20)
do
 
	DIR="${n}"

	cd "$DIR"

  	sed -n '7,7p' task2.out >> "/srv/home/jyang753/repo759/HW07/HW07_2/result.txt"

	cd ..

done
	


