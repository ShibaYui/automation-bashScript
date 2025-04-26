#!/bin/bash

##	Filename: run_nccl.sh
##	Author: wick.hy.hsu
##	Date: 2025-04-24 02:00:53 +0800
## 
##	Description:
##		get configs to exec mpirun with multi nodes
##
##	Usage:
##		./run_nccl.sh
##		hostname
##

# define Environment
export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# define socket interface
export nccl_socket_if=enP5p9s0

# NCCL Path
nccl_path=./all_reduce_perf

# NCCL Arguments
##
## -b: minimum size in Bytes
## -e: maxmum size in Bytes
## -f: stepFactor（資料大小成長倍數）
## -g: number of GPUs per process
##
nccl_args="-b 8 -e 32G -f 2 -g 1"

# hosts config
##
## hostfile syntax:
## 10.10.10.10 slot=4
## ... etc
##
hosts_config="hostfile"

# get -np value via input
read -p "counts of -np(num of process): " np_value

# exec mpirun
## -np: number of process
## NVL72 -> 18個node, 4 GPUs per node
## arguments帶入np=72, g=1, 較不容易報錯（全負載時）
##
#mpirun --allow-run-as-root --map-by ppr:1:node\
mpirun --allow-run-as-root \
  --hostfile $hosts_config \
  -x PATH -x LD_LIBRARY_PATH -x NCCL_SOCKET_IFNAME="$nccl_socket_if" \
  --mca btl_tcp_if_include $nccl_socket_if \
  --mca btl ^openib \
  -np $np_value \
  $nccl_path $nccl_args                           
