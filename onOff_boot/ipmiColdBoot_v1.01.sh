#!/bin/bash

##	Filename: ipmiColdBoot_v1.01.sh
##	Author: yu1
##	Date: 2025-01-23 11:55:16 +0800
## 
##	Description:
## 

sleeping_seconds=180
path="/root/onOff_boot"
log_ipmi="${path}/ipmiAll.log"  # including "ipmitool mc info" & "ipmitool sel list"
log_counter="${path}/count"


if [ ! -f "${log_counter}" ]; then
    echo "0" > "${log_counter}"
fi

while true; do
    os_time=$(date +"%Y%m%d_%I%M")

    {
        echo "====================Time Stamp: ${os_time}===================="
        ipmitool mc info
        ipmitool sel list
    } >> "${log_ipmi}"

    counter=$(cat "${log_counter}")
    counter=$((counter + 1))
    echo "${counter}" > "${log_counter}"

    ipmitool mc reset cold

    sleep "${sleeping_seconds}"
done

