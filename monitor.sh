#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LOG_FILE="$SCRIPT_DIR/monitor.log"
TIME_STAMP=$(TZ='Asia/Kolkata' date '+%Y-%m-%d %H:%M:%S')

# Append the current timestamp to the log file
echo "$TIME_STAMP" >> "$LOG_FILE"



# DISK USAGE
# Warn when disk usage reaches 80%
DISK_WARN=80

# Get the root filesystem uasge report
DISK_USED=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage: $DISK_USED%"
echo "Disk usage: $DISK_USED%" >> "$LOG_FILE"

if [ "$DISK_USED" -ge "$DISK_WARN" ]; then 
	echo "WARNING: Disk usage is high"
	echo "WARNING: Disk usage is high" >> "$LOG_FILE"
else
	echo "OK: Disk usage is below the warning threshold"
	echo "OK: Disk usage is below the warning threshold" >> "$LOG_FILE"
fi

# print empty line

echo



# MEMORY USAGE
# Warn when available memory falls to 1024 MiB or below
MEM_WARN_MB=1024

# Get available memory
MEM_AVAIL=$(free -m | awk 'NR==2 {print$7}')

echo "Available memory: $MEM_AVAIL MiB"
echo "Available memory: $MEM_AVAIL MiB" >> "$LOG_FILE"

if [ "$MEM_AVAIL" -le "$MEM_WARN_MB" ]; then
	echo "WARNING: Available memory is low"
	echo "WARNING: Available memory is low" >> "$LOG_FILE"
else
	echo "OK: Available memory is above the warning threshold"
	echo "OK: Available memory is above the warning threshold" >> "$LOG_FILE"
fi

# print empty line
echo



# LOAD AVAERAGE
# Get 1-minute CPU load average
CPU_LOAD=$(awk '{print$1}' /proc/loadavg)

# Get number of available CPU cores
CPU_CORES=$(nproc)

echo "CPU load: $CPU_LOAD"
echo "CPU load: $CPU_LOAD" >> "$LOG_FILE"

echo "CPU cores: $CPU_CORES"
echo "CPU cores: $CPU_CORES" >> "$LOG_FILE"

if awk -v cpu_load="$CPU_LOAD" -v cpu_cores="$CPU_CORES" 'BEGIN { if (cpu_load >= cpu_cores) exit 0; else exit 1 }'; then
    echo "WARNING: CPU load is high"
    echo "WARNING: CPU load is high" >> "$LOG_FILE"
else
    echo "OK: CPU load is below the warning threshold"
    echo "OK: CPU load is below the warning threshold" >> "$LOG_FILE"
fi

echo "----------------------------------------" >> "$LOG_FILE"
