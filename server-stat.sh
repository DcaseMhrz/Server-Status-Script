#!/usr/bin/env bash
# server-stats.sh - Analyze basic server performance stats
# Usage: chmod +x server-stats.sh && ./server-stats.sh

# Total CPU usage (user + system)
cpu_usage() {
  # Extract idle percentage and subtract from 100 using awk (no bc dependency)
  local idle usage 

  #getting the cpu details using top -bn1 making it non interactive and getting the 8th column
  idle=$(top -bn1 | awk '/Cpu\(s\):/ {gsub(",", ".", $8); print $8}')
  usage=$(awk "BEGIN {printf \"%.2f\", 100 - $idle}") #subtracting the total free space to 100% to get total usage
  printf "Total CPU Usage: %s%%\n" "$usage"
}

# Total memory usage
mem_usage() {
  # Output total, used, free, and percentage using awk (no bc)
  local total used free percent
  read total used free <<< "$(free -m | awk '/Mem:/ {print $2" "$3" "$4}')"
  percent=$(awk "BEGIN {printf \"%.2f\", $used * 100 / $total}")
  printf "Memory Usage: %sMB used / %sMB free (%s%%)\n" "$used" "$free" "$percent"
}

# Total disk usage for root (/)
disk_usage() {
  # Use df to pull size, used, avail, and percent
  df -h / | awk 'NR==2 {printf "Disk Usage (/): %s used / %s available (%s)\n", $3, $4, $5}'
}

# Top 5 processes by CPU usage
top_cpu_processes() {
  echo -e "\nTop 5 Processes by CPU Usage:"
  ps -eo pid,comm,pcpu --sort=-pcpu | head -n6
}

# Top 5 processes by memory usage
top_mem_processes() {
  echo -e "\nTop 5 Processes by Memory Usage:"
  ps -eo pid,comm,pmem --sort=-pmem | head -n6
}

# Stretch goal: Additional stats
os_info() {
  echo -e "\nOS Version: $(lsb_release -ds 2>/dev/null || grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')"
  echo "Uptime: $(uptime -p)"
  echo "Load Average: $(awk '{print $1", "$2", "$3}' /proc/loadavg)"
}

logged_users() {
  echo -e "\nLogged in users:"
  who | awk '{print $1}' | sort | uniq
}

failed_logins() {
  echo -e "\nFailed SSH login attempts:"
  sudo grep 'Failed password' /var/log/auth.log 2>/dev/null | wc -l
}

# Execute functions
cpu_usage
mem_usage
disk_usage
top_cpu_processes
top_mem_processes
