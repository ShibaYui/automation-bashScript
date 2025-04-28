#!/bin/bash

##	Filename: wifi_autoChecking.sh
##	Author: yu1
##	Date: 2025-04-28 14:24:39 +0800
## 
##	Description:
##		Wi-Fi loggin checking script
##

# define checking-website (via Google)
web_check="http://connectivitycheck.gstatic.com/generate_204"

if curl -s -I "$web_check" | grep -q "204 No Content"; then
	echo "Wi-fi connection in Normal"
else
	echo "Use Browser to login the Wi-Fi connection"
	# start default broswer via xdg 
	xdg-open http://neverssl.com
fi

