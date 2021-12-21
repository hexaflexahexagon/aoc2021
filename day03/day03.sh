#!/bin/bash

input=input.txt
list=$(cat $input)

# Uncomment for verbose output
#verbose=1

generator_rating=""
scrubber_rating=""
	
function find_number () {
	# Function to perform the searching algoritm given a switch input
	list_working="$list"
	sum=0
	len=$(echo "$list_working" | head -n1 | tr -d '\n' | wc -c)

	regex="^"

	# Loop through each line of $list_working, tally spot x and use grep to slice down list_working
	i=0
	while [ $i -lt $len ]; do
		lines=$(echo "$list_working" | wc -l | cut -d' ' -f 1)

		while read -r line; do	
			if [ ${line:$i:1} -eq 1 ]; then
				# Digit $i is 1
				sum=$((sum+1))
			fi
		done <<< "$list_working"

		if ! [ -z $verbose ]; then echo There are $sum 1 bits and $(($lines - $sum)) 0 bits.; fi

		if [[ "$1" == oxygen ]]; then
			# We want to find the oxygen generator rating
			if [ $sum -ge $(($lines - $sum)) ]; then
				# 1 is the most common (or 1/0 are equal)
				regex=${regex}"1"
				if ! [ -z $verbose ]; then echo Add a 1 to regex, $regex; fi
			else
				# Else, 0 is the most common
				regex=${regex}"0"
				if ! [ -z $verbose ]; then echo Add a 0 to regex, $regex; fi
			fi
		elif [[ "$1" == co2 ]]; then
			# We want to find the co2 scrubber rating
			if [ $sum -ge $(($lines - $sum)) ]; then
				# 0 is the least common (or 1/0 are equal)
				regex=${regex}"0"
				if ! [ -z $verbose ]; then echo Add a 0 to regex, $regex; fi
			else
				# Else, 1 is the least common
				regex=${regex}"1"
				if ! [ -z $verbose ]; then echo Add a 1 to regex, $regex; fi
			fi
		else
			echo Error: Invalid input \""$1"\" to function find_number
			exit -1
		fi
		
		# Remove non-matching lines
		list_working=$(echo "$list_working" | grep $regex)	
		if ! [ -z $verbose ]; then echo New list is: $list_working; fi

		# If only 1 address left, we're done
		if [ $(echo "$list_working" | wc -l) -eq "1" ]; then
			if [[ "$1" == oxygen ]]; then
				generator_rating=$list_working
			elif [[ "$1" == co2 ]]; then
				scrubber_rating=$list_working
			else
				echo Error: Something went wrong
				exit -1
			fi
			break
		fi

		sum=0
		i=$(($i+1))
	done
}

find_number oxygen
find_number co2

generator_d=$(echo "$((2#$generator_rating))")
scrubber_d=$(echo "$((2#$scrubber_rating))")

echo The generator value is $generator_rating or $generator_d
echo The scrubber value is $scrubber_rating or $scrubber_d

support_rating=$(( $generator_d * $scrubber_d ))

echo Total life support rating of the submarine is $support_rating
