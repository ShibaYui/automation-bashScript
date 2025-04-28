#!/bin/bash

##	Filename: update_Broadcom_driver.sh
##	Author: yu1
##	Date: 2025-04-29 01:07:43 +0800
## 
##	Description:
## 		update Broadcom Net-controller driver
##
##	Ref.
##		https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers
##		https://bugs.launchpad.net/qpdfview/+bug/1819201
##		https://help.ubuntu.com/community/WifiDocs/Driver/bcm43xx
##

sudo apt update
sudo apt install -y build-essential dkms linux-headers-$(uname -r)

# install Broadcom STA driver (broadcom-sta-dkms)
sudo apt install -y broadcom-sta-dkms

# remove old driver
sudo modprobe -r b43 b44 b43legacy ssb brcmsmac bcma

# probe Broadcom STA driver
sudo modprobe wl

# restart Wi-fi module
sudo rfkill unblock all
sudo nmcli radio wifi off
sleep 2
sudo nmcli radio wifi on


