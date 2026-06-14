#!/usr/bin/env python3

import sys
import argparse

parser = argparse.ArgumentParser(add_help=False)
parser.add_argument('-i','--input',required=True,nargs=1,help="Input file to paste")
parser.add_argument('-o','--output',required=True,nargs=1,help="Output file target")
parser.add_argument('-s','--search',required=True,nargs=1,help="Search string")

args = parser.parse_args()
print(args)

def insert_file(input,output,search):
   insert_at = -1
   with open(input,"r") as f1:
      t1 = f1.readlines()
   with open(output,"r") as f2:
      t2 = f2.readlines()
      for num, line in enumerate(t2,0):
         if search in line:
            #print("found:" + search + " at line:" + str(num) )
            insert_at = num + 1
            break
   if insert_at > -1:
      current_line = insert_at
      for num, line in enumerate(t1,0):
         t2.insert(current_line,line)
         current_line = current_line + 1
      with open(output,"w") as f3:
         f3.writelines(t2)
         

def main(argv):
   infile = args.input[0]
   outfile = args.output[0]
   search = args.search[0]
   insert_file(infile,outfile,search)

if __name__ == "__main__":
   main(sys.argv[1:])