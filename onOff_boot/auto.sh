#!/bin/bash

##	Filename: auto.sh
##	Author: yu1
##	Date: 2024-12-30 16:08:32 +0800
##
##	Description
##		automatic-validation tool (worm/cold-boot)
##

# value-defined
ac_on=230
path="/root/_dev/onOff_boot"
log_main="${path}/main.log"
log_count="${path}/count"
log_cal_timer="${path}/cal_timer"

# check have privous data or not

test -e ${log_count} && fileExisted=y || fileExisted=n

if [ ${fileExisted} = n ]; then
	echo "0" > ${log_count}
	count=$(cat ${log_count})
	cy_times=$(echo ${count} |bc )	# get cycle times of counter

	# record cycle times
	echo ${cy_times} > ${log_count}

	# record the last power-on time 
	echo "The ${cy_times} time reboot Power-on Time: $(date -R)" >> ${log_main}

	# record the power-on/off cycle time span
	echo $(date +%s) > ${log_cal_timer}
	echo "Power-on/off time span: sec" >> ${log_main}
	echo "===========================================================================" >> ${log_main}

	chmod 777 ${log_main}
	chmod 777 ${log_cal_timer}
	chmod 777 ${log_count}
fi

# get power-on/off cycle time-numbers
count=$(cat ${log_count})
cy_times=$(echo "${count}+1" |bc)

## note cycle times
echo "Power-on/off cycle times: ${cy_times}"
echo ${cy_times} > ${log_count}

## calculate and noted the power-on/off cycle timespan
now=$(date +%s)
old=$(cat "${log_cal_timer}")
time_sp=$(($now-$old))
echo ${now} > ${log_cal_timer}

## add function module
source module_lspci.sh ${cy_times} ${path}
source module_IPMI.sh ${cy_times} ${path}

## main log
echo "Power-on/off time-span: ${time_sp} sec" >> ${log_main}
echo "The ${cy_times} time reboot Power-on Time: $(date -R)" >> ${log_main}
echo "===========================================================================" >> ${log_main}
