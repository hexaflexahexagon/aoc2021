#!/usr/bin/env python3

import re # regex

input = "input.txt"

def filter(opt):
    file = open(input, 'r')
    
    # Read file line by line (remove newlines/extra whitespace)
    content = file.readlines()
    data = []
    for i in content:
        data.append(i.strip())

    lineLen = len(data[0])
    fileLen = len(data)

    binary = ""

    # loop through each digit of a line
    for i in range(0, lineLen):

        # in position i, find the most common value (1 or 0)
        tally = 0
        for x in range(0, fileLen):
            #print("line", x, "char", i, "data:", data[x][i])
            if ( data[x][i] == "1" ):
                tally += 1

        if ( opt == "oxy" ) and ( tally >= (fileLen / 2) ):
            binary += "1"
        elif ( opt == "oxy" ) and ( tally < (fileLen / 2) ):
            binary += "0"
        elif ( opt == "co2" ) and ( tally >= (fileLen / 2) ):
            binary += "0"
        elif ( opt == "co2" ) and ( tally < (fileLen / 2) ):
            binary += "1"
        else:
            print("Error: bad")
            exit()

        # Cull data[]
        regex = re.compile(r'^' + re.escape(binary) + r'[01]*$')
        data_f = [ i for i in data if regex.match(i) ]
        data = data_f

        fileLen = len(data)
        # check if there's only 1 thing in data[], if not continue
        
        if ( fileLen == 1 ):
            binary = data[0]
            break

    file.close()
    return int(binary, 2)

oxyDec = filter("oxy")
print("oxyDec", oxyDec)

co2Dec = filter("co2")
print("co2Dec", co2Dec)

print("product", (oxyDec * co2Dec))
