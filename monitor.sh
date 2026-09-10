#!/bin/bash

# Warn when disk usage reaches 80%
DISK_WARN=80

# Get the root filesystem uasge report
DISK_USED=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage: ${DISK_USED}%"

#
if [ "$DISK_USED" -ge "$DISK_WARN" ]; then 
	echo "WARNING: Disk usage is high"
else
	echo "OK: Disk usage is below the warning threshold"
fi

#Warn when available memory falls to 1024 MiB or below
MEM_WARN=1024

# Get available memory
MEM_AVAIL=$(free -m | awk 'NR==2 {print$7}')

echo "Available memory: $MEM_AVAIL MiB"

#
if [ "$MEM_AVAIL" -le "$MEM_WARN" ]; then
	echo "WARNING: Available memory is low"
else
	echo "OK: Available memory is above the warning threshold"
fi
