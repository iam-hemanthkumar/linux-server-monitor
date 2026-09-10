#!/bin/bash

# Warn when disk usage reaches 80%
DISK_WARN=80

# Get the root filesystem uasge report
DISK_USED=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage: ${DISK_USED}%"

if [ "$DISK_USED" -ge "$DISK_WARN" ]; then 
	echo "WARNING: Disk usage is high"
else
	echo "OK: Disk usage is below the warning threshold"
fi
