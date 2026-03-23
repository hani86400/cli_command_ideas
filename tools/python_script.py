# python_script.py

import sys
import os

def sum(N1,N2):
    return int(N1) + int(N2)

def main():
    if len(sys.argv) >= 3:
        print(sum(sys.argv[1], sys.argv[2]))
        return

if __name__ == "__main__":
    main()