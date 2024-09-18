#!/usr/bin/env python3
import math
import sys

if len(sys.argv) != 3:
    print("Usage: python3 gcd.py <integer1> <integer2>")
    sys.exit(1)

try:
    arg1 = sys.argv[1].strip()
    arg2 = sys.argv[2].strip()
    int1 = int(arg1)
    int2 = int(arg2)
except ValueError:
    print("Both arguments must be integers.")
    sys.exit(1)

result = "gcd:\t" + str(math.gcd(int1,int2))
print(result)


