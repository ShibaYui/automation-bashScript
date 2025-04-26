#!/bin/bash

##	Filename: module_sampleCode.sh
##	Author: yu1
##	Date: 2025-02-11 16:42:07 +0800
## 
##	Description:
## 


# get value-defined from "auto.sh"
cy_times=$1
path=$2

funcName="sampleCode_name"
sc_path="sc_1829/psu/v1.00/psu"

cmd=$(ipmitool mc info)
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
	echo "IPMI Info. Result: Pass" >> "$log_main"
else
	echo "${cy_times}" >> ${path}/"$log_errorCounter"
	echo "IPMI Info. Result: Failed, Times: $(wc -l < "$log_errorCounter")" >> "$log_main"
fi
