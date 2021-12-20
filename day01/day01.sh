#!/bin/bash

input='inputsmall.txt'

lineOld=""
count=0

while read -r line; do
	echo -n "$line "
	
	if [[ $lineOld == "" ]]; then
		# This is iteration #1, do nothing
		echo "(N/A)"
	else
		if [ $lineOld -lt $line ]; then
			# We increased
			count=$((count+1))
			echo "(Increase)"
		elif [ $lineOld -gt $line ]; then
			# We decreased 
			echo "(Decrease)"
		else
			# Equal
			echo "(Equal)"
		fi
	fi
	lineOld="$line"

done < $input

echo "$count" Increased
