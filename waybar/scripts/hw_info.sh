#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1 2>/dev/null || echo "N/A")


ram_used=$(free -h | awk '/^Mem:/ {print $3}' | sed 's/Gi//' 2>/dev/null || echo "N/A")
ram_total=$(free -h | awk '/^Mem:/ {print $2}' | sed 's/Gi//' 2>/dev/null || echo "N/A")

cpu_temp=$(cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input 2>/dev/null | awk '{print $1/1000}' || echo "N/A")
if [ "$cpu_temp" != "N/A" ]; then
    cpu_temp=$(printf "%.0f" "$cpu_temp")"°C"
fi

if command -v nvidia-smi &>/dev/null; then
    gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv -i 0 2>/dev/null | grep -o "[0-9]\+" || echo "N/A")
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv -i 0 2>/dev/null | grep -o "[0-9]\+" || echo "N/A")
    if [ "$gpu_temp" != "N/A" ]; then
        gpu_temp="${gpu_temp}°C"
    fi
else
    if command -v radeontop &>/dev/null; then
        gpu_usage=$(radeontop -d- -l 1 | grep "gpu" | awk '{print $5}' | cut -d, -f1 2>/dev/null || echo "N/A")
        gpu_temp=$(cat /sys/class/hwmon/hwmon3/temp1_input 2>/dev/null | awk '{print $1/1000}' || echo "N/A")
        if [ "$gpu_temp" != "N/A" ]; then
            gpu_temp=$(printf "%.0f" "$gpu_temp")"°C"
        fi
    else
        gpu_usage="N/A"
        gpu_temp="N/A"
    fi
fi

# Icône pour la barre (Nerd Font:  pour matériel)
icon=""

# Format de l'infobulle (lignes séparées comme demandé)
tooltip="CPU ${cpu_usage}% ${cpu_temp}\nGPU ${gpu_usage}% ${gpu_temp}\nRAM ${ram_used}/${ram_total}G"

# Sortie JSON
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\"}"