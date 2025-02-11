#!/bin/bash

##	Filename: module_lspci.sh
##	Author: wick.hy.hsu
##	Date: 2025-01-21 17:24:09 +0800
## 
##	Description:
##		module for pci information automatic noted
## 

# get value-defined from "auto.sh"
cy_times=$1
path=$2

funcName="lspci"
cmd=$(lspci |grep -i net)
log_main="${path}/main.log"
log_old="${path}/${funcName}_0.log"
log_new="${path}/${funcName}_1.log"
log_all="${path}/${funcName}_all.log"
log_errorCounter="${path}/${funcName}_error.log"


if [[ ${cy_times} == 1 ]]; then
	echo "$cmd" > "$log_old"
	cat "$log_old" > "$log_new"
else
	echo "$cmd" > "$log_new"
fi

cat "$log_new" >> "$log_all" 
if diff -q "$log_old" "$log_new" > /dev/null; then
	echo "PCIe Result: Pass" >> "$log_main"
else
	echo "${cy_times}" >> "$log_errorCounter"
	echo "PCIe Result: Failed, Times: $(wc -l < "$log_errorCounter")" >> "$log_main"
fi
