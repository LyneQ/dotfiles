#!/usr/bin/env bash
# Outputs Waybar JSON with CPU temperature (text) and tooltip including overall CPU usage,
# per-core usage, and temperatures when available.
# Designed to be robust with fallbacks across systems.

set -euo pipefail

escape_json() {
  awk '{
    gsub(/\\/, "\\\\");
    gsub(/"/, "\\\"");
    if (NR>1) printf "\\n";
    printf "%s", $0;
  }'
}

# Helper: Read CPU usage from /proc/stat twice and compute deltas
get_cpu_usage() {
  local interval_ms=${1:-400}
  # read total and per-core stats twice
  mapfile -t a < <(grep -E '^cpu[0-9]* ' /proc/stat)
  sleep "$(awk -v ms="$interval_ms" 'BEGIN{printf "%.3f", ms/1000}')"
  mapfile -t b < <(grep -E '^cpu[0-9]* ' /proc/stat)

  # Function to compute usage percent given two lines
  compute_usage() {
    local first="$1"; local second="$2"
    # fields: cpuN user nice system idle iowait irq softirq steal guest guest_nice
    read -r _ u1 n1 s1 i1 w1 irq1 sirq1 st1 gu1 gn1 <<<"$first"
    read -r _ u2 n2 s2 i2 w2 irq2 sirq2 st2 gu2 gn2 <<<"$second"
    local idle1=$((i1 + w1))
    local idle2=$((i2 + w2))
    local non1=$((u1 + n1 + s1 + irq1 + sirq1 + st1))
    local non2=$((u2 + n2 + s2 + irq2 + sirq2 + st2))
    local tot1=$((idle1 + non1))
    local tot2=$((idle2 + non2))
    local dt=$((tot2 - tot1))
    local dn=$((non2 - non1))
    if (( dt <= 0 )); then echo 0; return; fi
    awk -v dn="$dn" -v dt="$dt" 'BEGIN{printf "%.0f", (dn*100.0)/dt}'
  }

  local -a overall_core_first overall_core_second
  # overall is the line that starts with 'cpu '
  local line_overall_a="" line_overall_b=""
  for line in "${a[@]}"; do [[ $line =~ ^cpu\  ]] && line_overall_a="$line"; done
  for line in "${b[@]}"; do [[ $line =~ ^cpu\  ]] && line_overall_b="$line"; done

  local overall=0
  if [[ -n "$line_overall_a" && -n "$line_overall_b" ]]; then
    overall=$(compute_usage "$line_overall_a" "$line_overall_b")
  fi

  # per-core
  declare -a cores usage
  for i in "${!a[@]}"; do
    if [[ ${a[$i]} =~ ^cpu([0-9]+)\  ]]; then
      local id="${BASH_REMATCH[1]}"
      # skip overall 'cpu '
      if [[ ${a[$i]} =~ ^cpu\  ]]; then
        continue
      fi
      # find matching b line
      local bline="${b[$i]}"
      local u=$(compute_usage "${a[$i]}" "$bline")
      cores+=("$id")
      usage+=("$u")
    fi
  done

  # Print results to globals via echo (overall;cores;usage)
  echo "$overall"; printf '%s\n' "${cores[@]}" | paste -sd, -; printf '%s\n' "${usage[@]}" | paste -sd, -
}

# Helper: find temperatures via hwmon labels or sensors
get_cpu_temps() {
  # Returns CSV of core temps, and a package temp if available
  local temps=()
  local labels=()
  # Try lm-sensors output first
  if command -v sensors >/dev/null 2>&1; then
    # Extract lines like: Core 0:        +47.0°C
    while IFS= read -r line; do
      if [[ $line =~ ^(Core\ [0-9]+):.*\+?([0-9]+\.?[0-9]*)°C ]]; then
        labels+=("${BASH_REMATCH[1]}")
        temps+=("${BASH_REMATCH[2]}")
      elif [[ $line =~ ^(Package\ id\ [0-9]+):.*\+?([0-9]+\.?[0-9]*)°C ]]; then
        labels+=("${BASH_REMATCH[1]}")
        temps+=("${BASH_REMATCH[2]}")
      fi
    done < <(sensors 2>/dev/null)
  fi

  # Fallback to hwmon labels
  if ((${#temps[@]} == 0)); then
    for hw in /sys/class/hwmon/hwmon*; do
      [[ -d $hw ]] || continue
      for t in "$hw"/temp*_input; do
        [[ -f $t ]] || continue
        local label_file="${t%_input}_label"
        local label
        if [[ -f $label_file ]]; then
          label=$(<"$label_file")
        else
          label=$(basename "${t%_input}")
        fi
        local val=$(<"$t")
        if [[ $val =~ ^[0-9]+$ ]]; then
          val=$(awk -v v="$val" 'BEGIN{printf "%.0f", v/1000}')
        fi
        labels+=("$label")
        temps+=("$val")
      done
    done
  fi

  # Build maps for core temps and package temp
  local core_map=()
  local package_temp=""
  for i in "${!labels[@]}"; do
    local l="${labels[$i]}"
    local v="${temps[$i]}"
    if [[ $l =~ ^Core\ ([0-9]+) ]]; then
      core_map[${BASH_REMATCH[1]}]="$v"
    elif [[ $l =~ ^Package\ id ]]; then
      package_temp="$v"
    elif [[ $l =~ ^Tdie|^Tctl|^temp1 ]]; then
      # possible overall temp
      if [[ -z $package_temp ]]; then package_temp="$v"; fi
    fi
  done

  # Output: package_temp;core_csv (index:value)
  local core_csv=""
  for idx in "${!core_map[@]}"; do
    if [[ -n $core_csv ]]; then core_csv+=";"; fi
    core_csv+="$idx:${core_map[$idx]}"
  done
  echo "$package_temp"; echo "$core_csv"
}

main() {
  local overall cores_csv usage_csv
  read -r overall < <(get_cpu_usage 300)
  read -r cores_csv < <(get_cpu_usage 300 | sed -n '2p') || true
  read -r usage_csv < <(get_cpu_usage 300 | sed -n '3p') || true
  # The above naive triple call would measure different intervals; better to call once:
}

# Re-implement main correctly to avoid triple sampling
main() {
  local res; res=$(get_cpu_usage 300)
  local overall=$(echo "$res" | sed -n '1p')
  local cores_csv=$(echo "$res" | sed -n '2p')
  local usage_csv=$(echo "$res" | sed -n '3p')

  local package_temp core_csv
  read -r package_temp < <(get_cpu_temps | sed -n '1p')
  read -r core_csv < <(get_cpu_temps | sed -n '2p')

  # Build tooltip lines
  local tooltip="CPU: ${overall}%"
  if [[ -n $core_csv && -n $usage_csv ]]; then
    IFS=',' read -r -a usage_arr <<<"$usage_csv"
    IFS=',' read -r -a cores_arr <<<"$cores_csv"
    declare -A core_temp_map
    IFS=';' read -r -a core_pairs <<<"$core_csv"
    for p in "${core_pairs[@]}"; do
      [[ $p == *:* ]] || continue
      local idx=${p%%:*}
      local tv=${p#*:}
      core_temp_map[$idx]="$tv"
    done
    for i in "${!cores_arr[@]}"; do
      local cid=${cores_arr[$i]}
      local cu=${usage_arr[$i]:-}
      local ct="${core_temp_map[$cid]:-}"
      if [[ -n $ct ]]; then
        tooltip+=$'\n'"Core ${cid}: ${cu}%  ${ct}°C"
      else
        tooltip+=$'\n'"Core ${cid}: ${cu}%"
      fi
    done
  fi
  if [[ -n $package_temp ]]; then
    tooltip+=$'\n'"Temp: ${package_temp}°C"
  fi

  # Text shown: icon only, details in tooltip
  local text=""

  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "$text" "$(printf "%s" "$tooltip" | escape_json)" "normal"
}

main
