#!/bin/bash

# ---------------- CONFIGURATION ----------------

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LOG_FILE="$SCRIPT_DIR/monitor.log"

DISK_WARN=80
MEM_WARN_MB=1024

TIME_STAMP=$(TZ='Asia/Kolkata' date '+%Y-%m-%d %H:%M:%S')


# ---------------- DISK CHECK ----------------

check_disk() {
    DISK_USED=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    if [ "$DISK_USED" -ge "$DISK_WARN" ]; then
        DISK_STATUS="[WARNING]"
    else
        DISK_STATUS="[OK]"
    fi
}


# ---------------- MEMORY CHECK ----------------

check_memory() {
    MEM_AVAIL=$(free -m | awk 'NR==2 {print $7}')

    if [ "$MEM_AVAIL" -le "$MEM_WARN_MB" ]; then
        MEM_STATUS="[WARNING]"
    else
        MEM_STATUS="[OK]"
    fi
}


# ---------------- CPU CHECK ----------------

check_cpu() {
    CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
    CPU_CORES=$(nproc)

    if awk -v cpu_load="$CPU_LOAD" -v cpu_cores="$CPU_CORES" \
        'BEGIN { if (cpu_load >= cpu_cores) exit 0; else exit 1 }'; then
        CPU_STATUS="[WARNING]"
    else
        CPU_STATUS="[OK]"
    fi
}


# ---------------- MAIN ----------------

check_disk
check_memory
check_cpu


# Terminal output

echo "========================================"
echo " Linux Server Monitor"
echo "========================================"
echo "Disk   : $DISK_USED%  $DISK_STATUS"
echo "Memory : $MEM_AVAIL MiB  $MEM_STATUS"
echo "CPU    : $CPU_LOAD / $CPU_CORES  $CPU_STATUS"
echo "========================================"


# Log output

echo "========================================" >> "$LOG_FILE"
echo "Linux Server Monitor - $TIME_STAMP" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"
echo "Disk   : $DISK_USED%  $DISK_STATUS" >> "$LOG_FILE"
echo "Memory : $MEM_AVAIL MiB  $MEM_STATUS" >> "$LOG_FILE"
echo "CPU    : $CPU_LOAD / $CPU_CORES  $CPU_STATUS" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
