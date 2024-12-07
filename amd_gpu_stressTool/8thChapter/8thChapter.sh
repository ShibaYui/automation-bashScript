#!/bin/bash

set -x

time_stamp=$(date '+%m%d-%H%M%S')
rvs_path="/opt/rocm-6.2.1/bin/rvs"
rvs_config_path="/opt/rocm/rvs/conf/customer/gst_sgemm_5min.conf"
rvs_config_path_30="/opt/rocm/rvs/conf/customer/gst_sgemm_30min.conf"
agt_path="/home/test/Desktop/agt/AGT_4.1.28.0E_Linux_64bit/agt"
babel_conf="/opt/rocm-6.2.1/bin/conf/babel.conf"

log_path=$(pwd)

# 300s, 5min
execution_time=320

## 8.1
timeout 1900 bash -c "
	./ipmi.sh >> ${log_path}/log_8_1/8_1_ipmitool_gpuAll.log & \
	sudo ${agt_path} -i=0,1 -pmlogall -pmperiod=500 -pmoutput=${log_path}/log_8_1/pm_"${time_stamp}".csv & \
	sudo ${rvs_path} -c gst_sgemm_30min.conf >> ${log_path}/log_8_1/rvs_"${time_stamp}".log & \
"

## 8.2
## 1st GPU
timeout $execution_time bash -c "
	./ipmi.sh >> ${log_path}/log_8_2/8_2_1_ipmitool_gpu1.log & \
	sudo ${rvs_path} -i 57300 -d 3 -c gst_sgemm_5min.conf > ${log_path}/log_8_2/gpu0_5min_"${time_stamp}".log & \
	sudo ${agt_path} -i=0,1 -pmlogall -pmperiod=500 -pmoutput=${log_path}/log_8_2/pm_gpu0_"${time_stamp}".csv & \
"

## 2nd GPU
timeout $execution_time bash -c "
	./ipmi.sh >> ${log_path}/log_8_2/8_2_2_ipmitool_gpu1.log & \
	sudo ${rvs_path} -i 32693 -d 3 -c gst_sgemm_5min.conf > ${log_path}/log_8_2/gpu1_5min_"${time_stamp}".log & \
	sudo ${agt_path} -i=0,1 -pmlogall -pmperiod=500 -pmoutput=${log_path}/log_8_2/pm_gpu1_"${time_stamp}".csv & \
"

## 8.3
timeout $execution_time bash -c "
	sudo ${rvs_path} -c ${babel_conf} >> ${log_path}/log_8_3/babel_"${time_stamp}".log & \
	sudo ${agt_path} -i=0,1 -pmlogall -pmperiod=500 -pmoutput=${log_path}/log_8_3/pm_"${time_stamp}".csv & \
"

## 8.4
timeout $execution_time bash -c "
	./ipmi.sh >> ${log_path}/log_8_4/8_4_ipmitool.log & \
	./gemm R_32F R_32F R_32F R_32F OP_N OP_T 8640 8640 8640 8640 8640 8640 72 300 strided >> ${log_path}/log_8_4/gemm_"${time_stamp}".log & \
"
