#!/bin/bash

n=1024


if [ -f "${n}_result.txt" ]; then

    rm "${n}_result.txt"

fi


touch "${n}_result.txt"


for t in $(seq 1 20)
do
 
	DIR="${n}_${t}"
	cd "$DIR"

  	sed -n '3,3p' task1.out >> "/srv/home/jyang753/repo759/HW08/HW08_1/${n}_result.txt"

	cd ..

done
	
