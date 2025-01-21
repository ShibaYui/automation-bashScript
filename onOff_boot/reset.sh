#!/bin/bash

date=$(date +%Y%m%d_%s)

mkdir log_${date}

mv *.log log_${date}
mv *errorTimer log_${date}
mv count log_${date}
mv cal_* log_${date}
