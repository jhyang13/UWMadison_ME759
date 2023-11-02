#!/bin/bash

n=6
ts=10 

if [ -f "${n}_${ts}_result.txt" ]; then

    rm "${n}_${ts}_result.txt"

fi


touch "${n}_${ts}_result.txt"


for t in $(seq 1 20)  
do
 
	DIR="${n}_${ts}_${t}"
	cd "$DIR"

  	sed -n '3,3p' task3.out >> "/srv/home/jyang753/repo759/HW08/HW08_3/${n}_${ts}_result.txt"

	cd ..

done




