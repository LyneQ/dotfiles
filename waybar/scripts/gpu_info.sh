#!/usr/bin/env bash
# Outputs Waybar JSON for GPU with text and tooltip.
# Supports NVIDIA via nvidia-smi, AMD via sysfs, Intel via sysfs (limited).

set -euo pipefail

escape_json() {
  awk '{
    gsub(/\\/, "\\\\");
    gsub(/"/, "\\\"");
    if (NR>1) printf "\\n";
    printf "%s", $0;
  }'
}

nvidia_info() {
  if ! command -v nvidia-smi >/dev/null 2>&1; then return 1; fi
  # Query first GPU
  local q
  q=$(nvidia-smi --query-gpu=name,utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null) || return 1
  local name util temp mem_used mem_total
  IFS=',' read -r name util temp mem_used mem_total <<<"$q"
  name=$(echo "$name" | xargs)
  util=$(echo "$util" | xargs)
  temp=$(echo "$temp" | xargs)
  mem_used=$(echo "$mem_used" | xargs)
  mem_total=$(echo "$mem_total" | xargs)
  local text="󰢮"
  local tooltip
  tooltip=$(printf 'GPU: %s\nUtil: %s%%\nTemp: %s°C\nVRAM: %s MiB / %s MiB' "$name" "$util" "$temp" "$mem_used" "$mem_total")
  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "$text" "$(printf "%s" "$tooltip" | escape_json)" "nvidia"
  return 0
}

try_sysfs_gpu() {
  # Find first DRM card with temp
  local card_path
  for card in /sys/class/drm/card[0-9]*; do
    [[ -d $card ]] || continue
    # Prefer cards that have a device/hwmon
    local hwmon_dir="$card/device/hwmon"
    if [[ -d $hwmon_dir ]]; then
      for hm in "$hwmon_dir"/hwmon*; do
        [[ -d $hm ]] || continue
        if [[ -f "$hm/temp1_input" ]]; then
          card_path="$card"
          local temp_raw=$(<"$hm/temp1_input")
          local temp=$(awk -v v="$temp_raw" 'BEGIN{printf "%.0f", v/1000}')
          local util=""
          if [[ -f "$card/device/gpu_busy_percent" ]]; then
            util=$(<"$card/device/gpu_busy_percent")
          fi
          # VRAM for AMD
          local vram_used="" vram_total=""
          if [[ -f "$card/device/mem_info_vram_used" && -f "$card/device/mem_info_vram_total" ]]; then
            local u=$(<"$card/device/mem_info_vram_used")
            local t=$(<"$card/device/mem_info_vram_total")
            # values are in bytes
            vram_used=$(awk -v b="$u" 'BEGIN{printf "%.1f", b/1024/1024/1024}')
            vram_total=$(awk -v b="$t" 'BEGIN{printf "%.1f", b/1024/1024/1024}')
          fi
          local vendor="$(tr '[:upper:]' '[:lower:]' <"$card/device/vendor" 2>/dev/null | tr -d '\n')"
          local cls="amd"
          if [[ $vendor == *0x10de* ]]; then cls="nvidia"; fi
          if [[ $vendor == *0x8086* ]]; then cls="intel"; fi
          local text="󰢮"
          local tooltip
          tooltip=$(printf 'GPU: %s\nTemp: %s°C' "${cls^^}" "$temp")
          if [[ -n $util ]]; then tooltip+=$'\n'"Util: ${util%%.*}%"; fi
          if [[ -n $vram_total ]]; then tooltip+=$'\n'"VRAM: ${vram_used} GB / ${vram_total} GB"; fi
          printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
            "$text" "$(printf "%s" "$tooltip" | escape_json)" "$cls"
          return 0
        fi
      done
    fi
  done
  return 1
}

main() {
  if nvidia_info; then exit 0; fi
  if try_sysfs_gpu; then exit 0; fi
  # Fallback if nothing found
  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "󰢮" "GPU info unavailable" "unknown"
}

main
