#!/bin/bash

## Filename: ipmiColdBoot.sh
## Author: wick.hy.hsu
## Date: 2025-01-23 09:52:31 +0800
## 
## Description:
##		create log-files depends on BMC automatic on/off
## 

os_time=$(date +"%Y%m%d_%I%M")
sleeping_seconds=180                  
path="/root/onOff_boot"
log_ipmi="${path}/ipmiAll.log"		#including "ipmitool mc info" & "ipmitool sel list"

while [ ture ];
do	                        
	# noted logs
	echo "$(ipmitool mc info)" >> ${log_ipmi}
	echo "$(ipmitool sel list)" >> ${log_ipmi}
	echo "====================Time Stamp: ${os_time}====================" >> ${log_ipmi}

	# BMC reboot
	ipmitool mc reset cold
    
	#wait BMC rebooting 
	sleep ${sleeping_seconds}
done
