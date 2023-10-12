#!/bin/bash

t=64


if [ -f "${t}_int_result.txt" ] || [ -f "${t}_float_result.txt" ] || [ -f "${t}_double_result.txt" ]; then
   
    	rm "${t}_int_result.txt"
    	rm "${t}_float_result.txt"
    	rm "${t}_double_result.txt"

fi


touch "${t}_int_result.txt"
touch "${t}_float_result.txt"
touch "${t}_double_result.txt"


for n in $(seq 5 14)
do
 
	DIR="${t}_${n}"
	cd "$DIR"

  	sed -n '3,3p' task1.out >> "/srv/home/jyang753/repo759/HW05/HW05_1/${t}_int_result.txt"
  	sed -n '6,6p' task1.out >> "/srv/home/jyang753/repo759/HW05/HW05_1/${t}_float_result.txt"
  	sed -n '9,9p' task1.out >> "/srv/home/jyang753/repo759/HW05/HW05_1/${t}_double_result.txt"

	cd ..

done
	
