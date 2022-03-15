#!/usr/bin/env python3

FILENAME = "input.txt"

file = open(FILENAME, 'r')

count = 0
i = 0

numOld = 0
numOldOld = 0

value = 0
valueOld = 0

for line in file:
    num = int(line.strip('\n'))
    
    if ( i < 2 ):
        numOldOld = numOld
        numOld = num

        print("NUM:", num)
        value = num + numOld + numOldOld

        i += 1
        continue
        
    value = num + numOld + numOldOld
    
    if ( valueOld == 0 ):
        # first iteration
        status = "(N/A)"

    elif ( valueOld > value ):
        status = "(Decrease)"

    elif ( valueOld < value ):
        status = "(Increase)"
        count += 1

    else:
        status = "(Equal)"

    numOldOld = numOld
    numOld = num
   
    valueOld = value

    print(valueOld, status, value)
    prev = num

print("Count is", count)
