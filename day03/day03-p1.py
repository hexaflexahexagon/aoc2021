#!/usr/bin/env python3

input = "input.txt"

file = open(input, 'r')
#data = file.readlines().strip("\n")

# Read file line by line (remove newlines/extra whitespace)
content = file.readlines()
data = []
for i in content:
    data.append(i.strip())

lineLen = len(data[0])
fileLen = len(data)

count = [0] * lineLen

gammaBin = ""
epsilonBin = ""

for i in range(0, fileLen):

    # Go through each bit of each line and tally up scores
    bit = 0
    for char in data[i]:
        if ( char == "1" ):
            count[bit] += 1

        elif ( char == "0" ):
            pass

        bit += 1

for i in range(0, lineLen):
    # If over half are 1, set Gamma string bit to 1
    if ( count[i] >= (fileLen/2) ):
        gammaBin += "1"
        epsilonBin += "0"
    
    else:
        gammaBin += "0"
        epsilonBin += "1"

# Convert binary -> decimal
gammaDec = int(gammaBin, 2)
epsilonDec = int(epsilonBin, 2)

print("Product:", (gammaDec * epsilonDec))
