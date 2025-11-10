#!/bin/bash

if command -v nvidia-smi >/dev/null 2>&1; then
    gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -i 0 2>/dev/null | head -n1 | tr -d '\r' | head -c3 || echo "0")
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits -i 0 2>/dev/null | head -n1 | tr -d '\r' | head -c3 || echo "0")
    
    # Clean up values (remove spaces)
    gpu_usage=$(echo "$gpu_usage" | tr -d ' ')
    gpu_temp=$(echo "$gpu_temp" | tr -d ' ')
    
    # Determine CSS class based on usage
    if [ "$gpu_usage" -ge 80 ]; then
        class="high"
    elif [ "$gpu_usage" -ge 50 ]; then
        class="medium"
    else
        class="low"
    fi
    
    # Output JSON for Waybar
    echo "{\"text\":\"${gpu_usage}%\", \"tooltip\":\"${gpu_usage}% (${gpu_temp}°C)\", \"class\":\"${class}\"}"
else
    # No NVIDIA GPU detected
    echo "{\"text\":\"N/A\", \"tooltip\":\"No NVIDIA GPU detected\", \"class\":\"unavailable\"}"
fi
