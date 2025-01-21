#!/bin/bash

##	Filename: pingOvernight.sh
##	Author: yu1
##	Date: 2024-12-25 11:46:59 +0800
## 
##	Description:
##		automatic ping target IP (Host)
##		if host is losing, noted it and timestamp	
## 

log="deviceName.log"
ip_addr="IP address"
sleeping=5

while [ true ]; do
	if ! ping -c 10 -w 5 "$ip_addr" > /dev/null 2>&1; then
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
		echo "[$timestamp]_lost_host" >> "$log"
		fi
	ping "$ip_addr"
	sleep "$sleeping"
	done
