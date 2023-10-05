#!/bin/bash

if [ -e "512_result.txt" ]; then

    rm 512_result.txt

else

    echo "txt does not exist"

fi

for N in $(seq 10 29)
do

    DIR="512_${N}"

    cd $DIR

    sed -n '2,2'p task2.out >> /srv/home/jyang753/repo759/HW04/HW04_2/512_result.txt

    cd ..

done	
