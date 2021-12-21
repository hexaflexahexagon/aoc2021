#!/bin/bash

input=input.txt

pos_hor=0
pos_ver=0

while read -r line; do
	action=$(echo $line | awk '{ print $1 }')
	units=$(echo $line | awk '{ print $2 }')

	if [[ "$action" == "forward" ]]; then
		pos_hor=$(($pos_hor + $units))
		echo $line adds $units to horiz, resulting in $pos_hor
	elif [[ "$action" == "down" ]]; then
		pos_ver=$(($pos_ver + $units))
		echo $line adds $units to depth, resulting in $pos_ver
	elif [[ "$action" == "up" ]]; then
		pos_ver=$(($pos_ver - $units))
		echo $lien removes $units from depth, resulting in $pos_ver
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
