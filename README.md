# Server-Status-Script
https://roadmap.sh/projects/server-stats


# Server Stats Script

A simple Bash script to analyze basic server performance statistics on Linux.

## Features

- **Total CPU usage** (percentage of time the CPU is busy)
- **Total memory usage** (used vs free in MB and percentage)
- **Total disk usage** for root (`/`) (used vs available in human-readable form)
- **Top 5 processes by CPU usage**
- **Top 5 processes by memory usage**
- **Optional stretch goals** (uncomment in script):
  - OS version
  - System uptime
  - Load average
  - Logged-in users
  - Failed SSH login attempts

## Prerequisites

- Linux system with Bash (#!/usr/bin/env bash)
- Standard utilities installed: `top`, `awk`, `free`, `df`, `ps`, `who`, `uptime`
- Optional: `sudo` privileges for reading `/var/log/auth.log`

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/server-stats.git
   cd server-stats
   ```
2. **Make the script executable**
   ```bash
   chmod +x server-stats.sh
   ```

## Usage

Run the script directly:
```bash
./server-stats.sh
```

To enable additional stretch-goal stats, open `server-stats.sh` and uncomment the following lines at the bottom:
```bash
# os_info
# logged_users
# failed_logins
```

## Example Output

```text
Total CPU Usage: 12.20%
Memory Usage: 2856MB used / 163MB free (75.36%)
Disk Usage (/): 5.8G used / 111G available (5%)

Top 5 Processes by CPU Usage:
    PID COMMAND         %CPU
  28436 bash             2.9
  25855 brave            1.7
  ...

Top 5 Processes by Memory Usage:
    PID COMMAND         %MEM
  25855 brave            8.7
  1297 gnome-software   8.5
  ...
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

