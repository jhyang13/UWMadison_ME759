#!/bin/bash

n=6

if [ -f "${n}_result.txt" ]; then

    rm "${n}_result.txt"

fi


touch "${n}_result.txt"


for t in $(seq 1 10)
do
 
	DIR="${n}_${t}"
	cd "$DIR"

  	sed -n '3,3p' task2.out >> "/srv/home/jyang753/repo759/HW09/HW09_2/with_simd/${n}_result.txt"

	cd ..

done



