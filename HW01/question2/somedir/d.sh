#!/bin/bash

# This is the script for question 2 d)

for f in *.txt
do
	echo $f is opened now

	tail -5 $f

done

