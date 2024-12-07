#!/bin/bash

time_stamp=$(date '+%d%m%y')

mkdir log_${time_stamp}
mv *.csv log_${time_stamp}
mv *.log log_${time_stamp}
cp counter log_${time_stamp} && echo 0 > counter
