#!/usr/bin/env python3

FILENAME = "input.txt"

file = open(FILENAME, 'r')

prev = file.readline().strip('\n')

count = 0

# this comes up 2 short on the big test but works on the small test for some reason
for line in file:
    num = line.strip('\n')
    
    if ( num == prev ):
        print(num, "equal", prev)

    elif (num < prev ):
        print(num, "less than", prev)

    elif ( num > prev ):
        print(num, "greater than", prev)
        count += 1
    else:
        print(num, "no")
    
    prev = num

print("Count is", count)
