#!/bin/bash

##	Filename: module_IPMI.sh
##	Author: wick.hy.hsu
##	Date: 2025-01-21 17:23:58 +0800
## 
##	Description:
##		module for IPMI MC information automatic noted
## 

# get value-defined from "auto.sh"
cy_times=$1
path=$2

cmd=$(ipmitool mc info)
log_main="${path}/main.log"
log_old="${path}/ipmiInfo_0.log"
log_new="${path}/ipmiInfo_1.log"
log_all="${path}/ipmiInfo_all.log"
log_errorCounter="${path}/ipmiInfo_error.log"


if [[ ${cy_times} == 1 ]]; then
	echo "$cmd" > "$log_old"
	cat "$log_old" > "$log_new"
else
	echo "$cmd" > "$log_new"
fi

cat "$log_new" >> "$log_all" 
if diff -q "$log_old" "$log_new" > /dev/null; then
	echo "IPMI Info. Result: Pass" >> "$log_main"
else
	echo "${cy_times}" >> ${path}/"$log_errorCounter"
	echo "IPMI Info. Result: Failed, Times: $(wc -l < "$log_errorCounter")" >> "$log_main"
fi
