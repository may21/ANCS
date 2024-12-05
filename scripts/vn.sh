#!/bin/bash

# This script monitors network transmission data over a specified period and interval.
# It uses 'vnstat' to collect transmission statistics at given intervals
# and repeats this process for the calculated number of iterations.

# Assign the second argument to 'interval' (sampling interval in seconds)
interval=$2

# Assign the first argument to 'period' (total monitoring period in seconds)
period=$1

# Output the period and interval values for verification
echo $period
echo $interval

# Calculate the number of iterations needed to cover the total period
iter=$(($period / $interval + 1))

# Output the number of iterations
echo $iter

# Wait for the virtual machine to be ready before starting the monitoring
./wait_vm.sh

# Loop for the calculated number of iterations to collect data
for (( i = 0; i < iter; i++ ))
do
    # Run vnstat to monitor the 'enp1s0f1' network interface for the given interval
    # and filter the output for 'tx' (transmitted data). Run this command in the background.
    vnstat -i enp1s0f1 -tr $interval | grep tx &

    # Sleep for 1 second before starting the next vnstat command
    sleep 1

    # Run vnstat again with the same parameters, in the background
    vnstat -i enp1s0f1 -tr $interval | grep tx &

    # Sleep for 1 second before the next iteration
    sleep 1
done
