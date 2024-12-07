#!/bin/bash

set -x

time_stamp=$(date '+%m%d-%H%M%S')
rvs_path="/opt/rocm-6.2.1/bin/rvs"
rvs_config_path="/opt/rocm/rvs/conf/customer/gst_sgemm_5min.conf"
agt_path="/home/test/Desktop/agt/AGT_4.1.28.0E_Linux_64bit/agt"

log_path="/home/test/Desktop/1946_ROCm"
rvs_check=$(ls -l $log_path/rvs_* |tail -n 2 |head -n 1 -c 35)
counter=$(ls $log_path/dmesg_* |wc -l)

ip=$(ip addr |grep 192)

sudo dmesg >> ${log_path}/dmesg_"${time_stamp}".log
echo $counter
echo $rvs_check
echo $ip
sudo echo $counter > ${log_path}/counter

sudo .${rvs_path} -c ${rvs_config_path} >> ${log_path}/rvs_"${time_stamp}".log & \
sudo .${agt_path} -i=0,1 -pmlogall -pmperiod=5000 -pmoutput=${log_path}/pm_"${time_stamp}".csv & \
