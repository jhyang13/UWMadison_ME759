#!/bin/bash

t=32


if [ -f "${t}_result.txt" ]; then

    rm "${t}_result.txt"

fi


touch "${t}_result.txt"


for n in $(seq 10 30)
do
 
	DIR="${t}_${n}"
	cd "$DIR"

  	sed -n '2,2p' task2.out >> "/srv/home/jyang753/repo759/HW05/HW05_2/${t}_result.txt"

	cd ..

done
	
