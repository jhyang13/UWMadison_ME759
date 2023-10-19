#!/bin/bash

t=100


if [ -f "${t}_result.txt" ]; then

    rm "${t}_result.txt"

fi


touch "${t}_result.txt"


for n in $(seq 5 11)
do
 
	DIR="${t}_${n}"
	cd "$DIR"

  	sed -n '1,1p' task1.out >> "/srv/home/jyang753/repo759/HW06/HW06_1/${t}_result.txt"

	cd ..

done
	
