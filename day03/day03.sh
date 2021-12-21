#!/bin/bash

input=input.txt

# Gamma rate = most common value of each column
# Epsilon rate = least common

# Input:
#	100 
#	110
#	110
#	011

# Gamma: 110
# Epsil: 001

len=$(head -n1 $input | tr -d '\n' | wc -c)
lines=$(wc -l $input | cut -d' ' -f 1)

i=0

# Populate array with as many 0's as each line of input has digits
while [ $i -lt $len ]; do
	count_array+=(0)
	i=$((i+1))
done

while read -r line; do

	# Loop throuh each digit of each line
	i=0
	while [ $i -lt $len ]; do
		#echo -n ${line:$i:1}	
		
		# If 1, add to running total array
		if [ ${line:$i:1} -eq "1" ]; then
			count_array[$i]=$(( ${count_array[$i]} + 1 ))
		fi

		i=$((i+1))
	done
	#echo
done < $input

threshhold=$(( $lines / 2))
gamma=""
epsil=""

i=0
while [ $i -lt $len ]; do
	if [ ${count_array[$i]} -gt $threshhold ]; then
		# More than half of the lines have that digit set to '1'
		gamma=${gamma}"1"
		epsil=${epsil}"0"
	else
		# Less than half are '1' (or, exactly half)
		gamma=${gamma}"0"
		epsil=${epsil}"1"
	fi		
	i=$((i+1))
done

echo
echo Gamma binary rate is $gamma
echo Epsilon binary rate is $epsil

gamma_d=$(echo "$((2#$gamma))")
epsil_d=$(echo "$((2#$epsil))")

echo
echo Gamma decimal rate is $gamma_d
echo Epsilon decimal rate is $epsil_d

power=$(( $gamma_d * $epsil_d ))
echo 
echo Total power consumption is $power
