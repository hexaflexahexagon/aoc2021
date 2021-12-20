#!/bin/bash

input='input.txt'

lineOld=0
lineOldOld=0

value=0
valueOld=0

count=0
iteration=0

while read -r line; do
	
	# Do a 2 small loops to set up 'Old' line variables
	if [ $iteration -lt 2 ]; then
	
		lineOldOld=$lineOld
		lineOld=$line
		
		value=$(( $line + $lineOld + $lineOldOld ))
		
		iteration=$((iteration + 1))
		continue
	fi

	value=$(( $line + $lineOld + $lineOldOld ))

	echo -n "$value "

	if [ $valueOld -eq 0 ]; then
		# This is iteration #1, do nothing
		echo "(N/A)"
	else
		if [ $valueOld -lt $value ]; then
			# We increased
			count=$((count+1))
			echo "(Increase)"
		elif [ $valueOld -gt $value ]; then
			# We decreased 
			echo "(Decrease)"
		else
			# Equal
			echo "(Equal)"
		fi
	fi
	lineOldOld=$lineOld
	lineOld=$line
	
	valueOld=$value
	value=$(( $line + $lineOld + $lineOldOld ))

done < $input

echo "$count" Increased
