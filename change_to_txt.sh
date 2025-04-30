#!/bin/bash

##	Filename: change_to_txt.sh
##	Author: yu1
##	Date: 2025-04-29 07:01:03 +0800
## 
##	Description:
## 		translate .work to .txt
##
##	Hint:
##		filename -> basename.parameter_expansion
##

file_list=$(ls *.work)

for file in $file_list; do
	#echo $(basename $file | cut -d. -f1)
	cp $file "$(basename $file | cut -d. -f1).txt"
done
