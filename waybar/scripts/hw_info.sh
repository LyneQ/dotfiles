#!/usr/bin/env bash

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1 2>/dev/null || echo "0")
cpu_usage=$(echo "$cpu_usage" | tr -d '%us,' | head -c3)

# Get RAM info
ram_used=$(free -h | awk '/^Mem:/ {print $3}' | sed 's/Gi//' 2>/dev/null || echo "0")
ram_total=$(free -h | awk '/^Mem:/ {print $2}' | sed 's/Gi//' 2>/dev/null || echo "0")
ram_used=$(echo "$ram_used" | head -c4)
ram_total=$(echo "$ram_total" | head -c4)

# Get CPU temperature
cpu_temp=$(cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input 2>/dev/null | awk '{print $1/1000}' || echo "0")
if [ "$cpu_temp" != "0" ]; then
    cpu_temp=$(printf "%.0f" "$cpu_temp")
else
    cpu_temp="N/A"
fi

# Get GPU info (simplified)
if command -v nvidia-smi >/dev/null 2>&1; then
    gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -i 0 2>/dev/null | head -n1 | tr -d '\r' | head -c3 || echo "0")
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits -i 0 2>/dev/null | head -n1 | tr -d '\r' | head -c3 || echo "0")
else
    gpu_usage="N/A"
    gpu_temp="N/A"
fi

cat << EOF
{"text":"󰓅","tooltip":"CPU ${cpu_usage}% ${cpu_temp}°C\\nGPU ${gpu_usage}% ${gpu_temp}°C\\nRAM ${ram_used}/${ram_total}GB"}
EOF