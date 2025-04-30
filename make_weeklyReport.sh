#!/bin/bash

##	Filename: make_weeklyReport.sh
##	Author: yu1
##	Date: 2025-04-29 07:06:04 +0800
## 
##	Description:
## 		collect daily reports to make weekly report
##
##	Usage:
##		using command "basename filename.work | cut -d. -f1" to get filename
##
##	input:
## 		report filename (for-loop)
##
##	output:
##		print to the terminal
##
##	


# define cmd
cmd="tail -n +8"

# define input: filename
read -r filename   

# define the report which I key-in as "daily_rp"
for daily_rp in  $filename; do
	# Ignore blank lines and comment lines
	[[ -z "$daily_rp" || "$daily_rp" == \#* ]] && continue
	echo "$(basename $daily_rp | cut -d. -f1): "
	cat ${daily_rp} | $cmd 
	echo " "
done
