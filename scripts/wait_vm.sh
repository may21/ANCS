#!/bin/bash

# This script waits for a signal to start a job.
# It continuously monitors the 'nfs/sign.txt' file for a change in value.
# When the value becomes '1', it indicates that the job should start.

# Initialize the sign.txt file with 0 to indicate that the job hasn't started yet
echo 0 > nfs/sign.txt

# Output a waiting message with the current date and time
echo "Waiting...$(date +%m-%d-%H-%M-%S)"

# Start an infinite loop to check for the signal
while true; do
    # Alternative method to read the value from sign.txt (commented out)
    # var="$(cat sign.txt)"

    # Read the current value from 'nfs/sign.txt' and check if it's equal to 1
    if [ $(cat nfs/sign.txt) -eq 1 ]; then
        # Alternative conditional using the variable 'var' (commented out)
        # if [ $var -eq 1 ]; then

        # Signal detected, output a message indicating the job is starting
        echo "JOB START!!"

        # Optionally reset the sign.txt file to 0 after starting the job (commented out)
        # echo 0 > sign.txt

        # Exit the loop since the job is starting
        break;
    fi	

    # Wait for 0.01 seconds before checking again to prevent excessive CPU usage
    sleep 0.01
done
