#!/bin/bash

# Define the log directory and log file with desired naming convention
LOG_DIR="/usr/local/nagios/var"
LOG_FILE="$LOG_DIR/nagios_total_proc_$(date '+%Y-%b-%d_%H-%M-%S').log"

# Check if the log directory exists; if not, create it
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
    echo "Log directory created: $LOG_DIR"
fi

# Get the current date and time
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Capture the total number of processes
TOTAL_PROCS=$(ps aux | wc -l)

# Capture the full list of processes
PROCESS_LIST=$(ps aux)

# Log the information to the designated log file
{
    echo "-----------------------------------------"
    echo "Timestamp: $TIMESTAMP"
    echo "Total Processes: $TOTAL_PROCS"
    echo ""
    echo "-----------------------------------------"
    echo "Process List:"
    echo "-----------------------------------------"
    echo "$PROCESS_LIST"
    echo "-----------------------------------------"
} >> "$LOG_FILE"

echo "Recorded $TOTAL_PROCS processes."  # This line is crucial for NRPE output
exit 0

