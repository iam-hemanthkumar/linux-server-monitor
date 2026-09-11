# Linux Server Monitor

A simple Bash script to monitor basic Linux system resources.

It checks:

- Disk usage
- Available memory
- CPU load

The script also saves the results to a log file and can run automatically using cron.

## Features

- Disk usage warning at 80% or higher
- Memory warning when available memory is 1024 MiB or lower
- CPU load check using the 1-minute load average
- CPU core detection using `nproc`
- `[OK]` and `[WARNING]` status output
- Log file with timestamp
- Automatic monitoring using cron

## Example Output

```text
========================================
 Linux Server Monitor
========================================
Disk   : 2% [OK]
Memory : 7133 MiB [OK]
CPU    : 0.13 / 12 [OK]
========================================
```

## How to Run

Give execute permission:

```bash
chmod +x monitor.sh
```

Run the script:

```bash
./monitor.sh
```

The results are also saved in:

```text
monitor.log
```

## Cron Scheduling

Example to run the script every 5 minutes:

```cron
*/5 * * * * /full/path/to/linux-server-monitor/monitor.sh
```

## Commands Used

- `df` - disk usage
- `free` - memory information
- `awk` - extract values
- `tr` - remove characters
- `nproc` - CPU core count
- `/proc/loadavg` - CPU load average
- `date` - timestamp
- `cron` - automatic scheduling

## Project Structure

```text
linux-server-monitor/
├── monitor.sh
├── README.md
└── .gitignore
```

`monitor.log` is generated automatically and ignored by Git.

## What I Learned

This project helped me practise:

- Bash scripting
- Variables
- Command substitution
- `if/else` conditions
- Functions
- Linux system commands
- Logging
- Cron scheduling
- Git branches
- Git commits
- Git diff
- Git merge
- `.gitignore`
