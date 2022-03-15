#!/usr/bin/env python3

input = "input.txt"

file = open(input, 'r')

horiz = 0
depth = 0

for line in file:
    command = line.strip('\n').split()[0]
    count = int(line.strip('\n').split()[1])

    if ( command == "forward" ):
        horiz += count

    elif ( command == "backward" ):
        horiz -= count
        print("does this exist")

    elif ( command == "up" ):
        depth -= count
    
    elif ( command == "down" ):
        depth += count

    #print(command, count)

print("final horiz", horiz)
print("final depth", depth)

product = horiz * depth
print("final product", product)
