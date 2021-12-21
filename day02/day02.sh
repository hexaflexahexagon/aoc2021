#!/bin/bash

input=input.txt

pos_hor=0
pos_ver=0
aim=0

while read -r line; do
	action=$(echo $line | awk '{ print $1 }')
	units=$(echo $line | awk '{ print $2 }')

	if [[ "$action" == "forward" ]]; then
		pos_hor=$(($pos_hor + $units))
		pos_ver=$(($pos_ver + ( $aim * $units )))

		echo $line adds $units to horiz, resulting in $pos_hor
		echo $line also adds $(($aim * $units)) to depth, resulting in $pos_ver

	elif [[ "$action" == "down" ]]; then
		aim=$(($aim + $units))
		echo $line changes aim by $units, resulting in $aim
	elif [[ "$action" == "up" ]]; then
		aim=$(($aim - $units))
		echo $line changes aim by $units, resulting in $aim
	else
		echo what is "$action"
		exit -1
	fi

done < $input

echo
echo Total horizontal position is $pos_hor
echo Total depth is $pos_ver

product=$(( $pos_hor * $pos_ver ))

echo
echo The product of the two is $product
