#!/bin/bash

if ! command -v nvidia-smi &>/dev/null; then
    echo '{"text": "󰢮 N/A", "tooltip": "nvidia-smi not found", "class": "disabled"}'
    exit 0
fi

read -r utilization power temperature <<< \
    "$(nvidia-smi --query-gpu=utilization.gpu,power.draw,temperature.gpu \
       --format=csv,noheader,nounits 2>/dev/null | tr -d ' '  | tr ',' ' ')"

if [[ -z "$utilization" ]]; then
    echo '{"text": "󰢮 ERR", "tooltip": "nvidia-smi query failed", "class": "error"}'
    exit 0
fi

class="normal"
if (( utilization > 90 )); then
    class="high"
elif (( utilization > 50 )); then
    class="medium"
fi

printf '{"text": "󰢮 %s%%", "tooltip": "Utilization: %s%%\\nPower: %sW\\nTemp: %s°C", "class": "%s"}\n' \
    "$utilization" "$utilization" "$power" "$temperature" "$class"
