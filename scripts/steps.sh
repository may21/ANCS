#!/bin/bash

# This script automates the adjustment of an interval parameter over multiple iterations.
# It initializes settings, then increments the interval value in a loop,
# applying the new value each time and pausing between iterations.
# Certain actions are triggered at specific iterations.

# Set the sleep duration between iterations (in seconds)
time=60

# Initialize the interval and test reader settings
./interval.sh 0          # Reset interval to 0
./testReader 0           # Disable the test reader
./wait_vm.sh             # Wait for the virtual machine to be ready

# Start interval at 0
interval=0

# Loop 11 times to adjust the interval
for (( i=0 ; i<11; i++ ))
do
    # Enable the test reader at the second iteration
    if [ $i -eq 1 ]; then
        ./testReader 1   # Enable the test reader
    fi

    # Display the current interval value
    echo $interval

    # Apply the current interval value
    ./interval.sh $interval

    # Increase the interval by 500 for the next iteration
    interval=$(($interval + 500))

    # Pause before the next iteration
    sleep $time
done

# Reset the interval and test reader settings after completion
./interval.sh 0          # Reset interval to 0
./testReader 0           # Disable the test reader