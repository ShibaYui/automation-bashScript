#!/bin/bash

##	Filename: netPortScanner.sh
##	Author: wick.hy.hsu
##	Date: 2025-01-07 15:44:03 +0800
## 
##	Description:
##		automatic tool for ping-testing between two Net Interfaces	
##
##	Notice:
##		you have to install package "iputils-ip" first for using "ping" command
##


# defined
net_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v "lo")
countsOfInterface=$(echo "$net_interfaces" | wc -l)
if_array=($(echo "$net_interfaces"))	# set array for saving net interface
stringIP="192.168.1."					# set string for IP address definded
ping_count=1
ping_interval=5

# Configuring Net Interface with IP Address
for ((i=0; i<countsOfInterface; i++)); do	  

	# set IP address
	assignedIP="${stringIP}$((100+i))"

	echo "${if_array[$i]} -> ${assignedIP}"

	# remove configuration from interface
	sudo ip addr flush dev "${if_array[$i]}"

	# set IP address to interface 
	sudo ip addr add "$assignedIP"/24 dev "${if_array[$i]}"
	sudo ip link set "${if_array[$i]}" up
done

# starting ping test between two intrefaces 
echo "Starting ping-testing..." 
for ((i=0; i<countsOfInterface; i++)); do
	for ((j=i+1; j<countsOfInterface; j++)); do
		ipA="${stringIP}$((100+i))"
		ipB="${stringIP}$((100+j))"
        
        # a -> b
		if	ping -c $ping_count "$ipB" -I "${if_array[$i]}" > /dev/null 2>&1; then
			echo "$(date) [INFO] $ipA -> $ipB Success!!"
		else
			echo "$(date) [ERROR] $ipA -> $ipB Failed!!"
		fi

		# b -> a
 		if ping -c $ping_count "$ipA" -I "${if_array[$j]}" > /dev/null 2>&1; then
			echo "$(date) [INFO] $ipB -> $ipA Success!!"
		else
			echo "$(date) [ERROR] $ipB -> $ipA Failed!!"
		fi
 
		sleep "$ping_interval"
	done
done


