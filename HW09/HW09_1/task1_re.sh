#!/bin/bash

n=5040000


if [ -f "${n}_result.txt" ]; then

    rm "${n}_result.txt"

fi


touch "${n}_result.txt"


for t in $(seq 1 10)
do
 
	DIR="${n}_${t}"
	cd "$DIR"

  	sed -n '3,3p' task1.out >> "/srv/home/jyang753/repo759/HW09/HW09_1/${n}_result.txt"

	cd ..

done
	
