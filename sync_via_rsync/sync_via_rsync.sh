#!/bin/bash

##	Filename: sync_via_scp.sh
##	Author: yu1
##	Date: 2025-04-26 06:14:03 +0800
## 
##	Description:
## 		sync files to onther device via scp tool
##


# define
host_list="host_list"
sync_from="sync/from/where"
sync_to="sync/to/where"
 
##
## host_list=(
##	xx.xx.xx.xx
##	aa.aa.aa.aa
##	cc.cc.cc.cc
##	)
##
##
##for host in "${host_list[@]}"; do
##	echo "Syncing to ${host}"
##	rsync -avP -e ssh $sync_from/ ${USER}@${host}:$sync_to/
##done
##


# -n, non-zero length, 非空字串
# [[ ... ]] bash test command, safe than [ ... ]
while read -r host || [[ -n "$host" ]]; do
	# 忽略空白行跟註解行
	[[ -z "$host" || "$host" == \#* ]] && continue

 	echo "Syncing to ${host}"
	rsync -avP -e ssh $sync_from/ ${USER}@${host}:$sync_to/

# 將host_list作為while-loop輸入源（<: 重定向字符）
done < "$host_list"
