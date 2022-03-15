#!/usr/bin/env python3

input = "inputsmall.txt"

file = open(input, 'r')

aim = 0
horiz = 0
depth = 0

for line in file:
    command = line.strip('\n').split()[0]
    count = int(line.strip('\n').split()[1])

    if ( command == "forward" ):
        horiz += count
        depth += aim * count

    elif ( command == "up" ):
        aim -= count
    
    elif ( command == "down" ):
        aim += count

    #print(command, count)

print("final horiz", horiz)
print("final depth", depth)

product = horiz * depth
print("final product", product)
