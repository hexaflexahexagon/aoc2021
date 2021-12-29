#!/bin/bash

# this takes over 2.5 minutes to do the full challenge, consider some optimizations?
# ... and almost 13 minutes for part 2... use python next time

fileSource="input.txt"
file="${fileSource}-tmp"
rm $file 2>/dev/null
cat $fileSource | sed 's/  / /g' | sed 's/^ //g' > $file

draw=$(head $file -n1)
drawhead=""
i=0

boardcount=$(grep -Evc '[^[:space:]]' "$file")
rowcount=$(( $(grep -Ec '[^[:space:]]' "$file") / boardcount ))
colcount=$(tail -n+3 "$file" | head -n1 | wc -w) 
numcount=$((rowcount * colcount - 1))

# print only the given board to stdout
function board () {
	value=3
	value=$((value + ("$1" * ("$rowcount" + 1))))
	tail -n+"$value" $file | head -n5
}

# calculate the final score after board $1 wins with call $2
function score () {
	echo Board \#$1 was the last to be solved, last drawn number is: $2
	
	sum=0	
	k=0
	while [ $k -le "$numcount" ]; do
		board_sub="board${1}[$k]"
		board_sub_flag="board${1}_flag[$k]"
		if [[ ${!board_sub_flag} == "false" ]];then
			value=$(echo ${!board_sub} | tr -d '\r')
			sum=$((sum + value))
		fi
		let "k++"
	done

	echo The score is $((sum * $2))
	rm $file
}

# Read the input file into a lot of arrays
i=0
while [ $i -lt "$boardcount" ]; do
	# Per row
	j=1
	while [ $j -le "$rowcount" ]; do
		# Per char
		k=1
		while [ $k -le "$colcount" ]; do
			#echo board $i: row $j: num $k is "$(board $i | cut -d' ' -f$k | tail -n+$j | head -n1)"
			eval "board$i+=( $(board $i | cut -d' ' -f$k | tail -n+$j | head -n1) )"
			eval "board${i}_flag+=('false')"
			let "k++"
		done
		let "j++"
	done
	let "i++"
done

i=0
# input list processing
while true; do
		
	if [[ $(echo "$draw" | grep ,) == "" ]]; then
		break
	fi
	
	drawhead=$(echo "$draw" | cut -d',' -f1)
	draw=$(echo "$draw" | cut -d',' -f2-)

	# Assign board_flag array values for newly-matching strings
	j=0	
	while [ $j -lt "$boardcount" ]; do
		k=0
		while [ $k -le "$numcount" ]; do
			# Check if the newest number matches anything
			board_sub="board$j[$k]"
			tmp=$(echo ${!board_sub} | tr -d '\r')
			if [[ "$tmp" == "$drawhead" ]]; then
				# Somehow set flag for that position in array to false
				eval "board${j}_flag[${k}]='true'"
				# TODO: aa
				if [ $j -eq "2" ]; then
					#echo pos $k is true i made it true with value $tmp
					true
				fi	
			fi	
			let "k++"
		done
		let "j++"
	done

	# Prepare array for board checking
	while [ $tmp -lt "$boardcount" ]; do
		board+=("false")	
		let "tmp++"
	done
	
	# Check if we have any bingos
	j=0
	while [ $j -lt "$boardcount" ]; do
		k=0
		while [ $k -lt "$numcount" ]; do
			board_sub="board${j}_flag[$k]"
			board_horiz1="board${j}_flag[$((k+1))]"
			board_horiz2="board${j}_flag[$((k+2))]"
			board_horiz3="board${j}_flag[$((k+3))]"
			board_horiz4="board${j}_flag[$((k+4))]"

			board_vert1="board${j}_flag[$((k+rowcount))]"
			board_vert2="board${j}_flag[$((k+(rowcount*2)))]"
			board_vert3="board${j}_flag[$((k+(rowcount*3)))]"
			board_vert4="board${j}_flag[$((k+(rowcount*4)))]"
			
			if ([[ $((k%rowcount)) == 0 && \
				${!board_sub} == "true" && \
				${!board_horiz1} == "true" && \
				${!board_horiz2} == "true" && \
				${!board_horiz3} == "true" && \
				${!board_horiz4} == "true" ]]); then
				board[$j]="true"
			fi

			if ([[ ${!board_sub} == "true" &&\
				${!board_vert1} == "true" &&\
				${!board_vert2} == "true" &&\
				${!board_vert3} == "true" &&\
				${!board_vert4} == "true" ]]); then
				board[$j]="true"
			fi

			let "k++"
		done
		let "j++"
	done
	let "i++"
	
	# Here after being done with all x boards at once
	numsolved=0
	j=0
	while [ $j -lt "$boardcount" ]; do
		if [[ ${board[$j]} == "true" ]]; then
			let "numsolved++"
		else
			lastunsolved=$j
		fi
		let "j++"
	done

	# Only 1 board is left unsolved
	if [ $numsolved -eq $boardcount ]; then
		score $lastunsolved $drawhead
		exit 1
	fi
done
exit -1
