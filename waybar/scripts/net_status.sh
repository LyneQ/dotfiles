#!/usr/bin/env bash
set -euo pipefail

# Determine primary/default interface (prefer default route)
get_primary_if() {
  local dev
  # Prefer a connected Wi‑Fi device if any
  if command -v nmcli >/dev/null 2>&1; then
    dev=$(nmcli -t -f DEVICE,TYPE,STATE device status | awk -F: '$2=="wifi" && $3=="connected"{print $1; exit}') || true
    if [[ -n "${dev:-}" ]]; then
      echo "$dev"
      return
    fi
  fi
  # Then prefer the interface with the default IPv4 route
  dev=$(ip route 2>/dev/null | awk '/^default/ {print $5; exit}') || true
  if [[ -n "${dev:-}" ]]; then
    echo "$dev"
    return
  fi
  # Fallback: first connected device from NetworkManager (any type)
  if command -v nmcli >/dev/null 2>&1; then
    dev=$(nmcli -t -f DEVICE,STATE device status | awk -F: '$2=="connected"{print $1; exit}') || true
    if [[ -n "${dev:-}" ]]; then
      echo "$dev"
      return
    fi
  fi
  echo ""
}

json_escape() {
  # Escape backslashes and quotes for JSON strings
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
}

primary_if=$(get_primary_if)

# Determine connection type and human name (SSID for Wi-Fi; gateway hostname/connection name for Ethernet)
conn_type=""
name="Unknown"
if [[ -n "$primary_if" ]]; then
  if command -v nmcli >/dev/null 2>&1; then
    conn_type=$(nmcli -t -f DEVICE,TYPE device status | awk -F: -v d="$primary_if" '$1==d{print $2; exit}') || true
  fi
  if [[ "$conn_type" == "wifi" ]]; then
    # Try to get SSID
    if command -v iwgetid >/dev/null 2>&1; then
      ssid=$(iwgetid -r 2>/dev/null || true)
    fi
    if [[ -z "${ssid:-}" ]]; then
      if command -v nmcli >/dev/null 2>&1; then
        ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}') || true
      fi
    fi
    name=${ssid:-$primary_if}
  else
    # Ethernet or other: try to show internet box (gateway) name
    gw=$(ip route 2>/dev/null | awk '/^default/ {print $3; exit}') || true
    gwhost=""
    if [[ -n "${gw:-}" ]]; then
      gwhost=$(getent hosts "$gw" 2>/dev/null | awk '{print $2; exit}') || true
      if [[ -z "${gwhost:-}" ]] && command -v avahi-resolve >/dev/null 2>&1; then
        gwhost=$(avahi-resolve -a "$gw" 2>/dev/null | awk '{print $2; exit}') || true
      fi
      # strip trailing dot if any
      gwhost=${gwhost%.}
      # filter bogus/unhelpful names
      case "$gwhost" in
        blocked.local|localhost|localhost.localdomain|localhost.local)
          gwhost=""
          ;;
      esac
    fi
    if [[ -n "${gwhost:-}" ]]; then
      name="$gwhost"
    else
      # Fallback to NetworkManager connection name, then IF name
      if command -v nmcli >/dev/null 2>&1; then
        conn_name=$(nmcli -g GENERAL.CONNECTION device show "$primary_if" 2>/dev/null || true)
        if [[ -n "${conn_name:-}" && "$conn_name" != "--" ]]; then
          name="$conn_name"
        else
          name="$primary_if"
        fi
      else
        name="$primary_if"
      fi
    fi
  fi
fi

# IPv4 of primary interface
ip4=""
if [[ -n "$primary_if" ]]; then
  ip4=$(ip -4 -o addr show dev "$primary_if" 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1) || true
fi

# Connectivity status
status="disconnected"
connected=false
if [[ -n "$primary_if" ]]; then
  if command -v nmcli >/dev/null 2>&1; then
    # Treat any state starting with "connected" (e.g., "connected (externally)") as connected
    if nmcli -t -f DEVICE,STATE device status | awk -F: -v d="$primary_if" '$1==d && $2 ~ /^connected/{found=1} END{exit found?0:1}'; then
      connected=true
    elif [[ -n "$ip4" ]]; then
      # Fallback: if interface has an IP, consider it connected
      connected=true
    fi
  else
    # Fallback: if interface has an IP, consider it connected
    if [[ -n "$ip4" ]]; then connected=true; fi
  fi
fi

if $connected; then
  connectivity="unknown"
  if command -v nmcli >/dev/null 2>&1; then
    # Returns: full|limited|portal|none|unknown
    connectivity=$(nmcli -t networking connectivity 2>/dev/null || echo "unknown")
  else
    # Simple fallback: ping a well-known IP (fast, 1 packet)
    if ping -c1 -W1 1.1.1.1 >/dev/null 2>&1; then
      connectivity="full"
    else
      connectivity="limited"
    fi
  fi
  case "$connectivity" in
    full)
      status="connected"
      ;;
    limited|portal|none|unknown)
      status="connected without internet"
      ;;
  esac
fi

# Choose an icon for the bar (text).
icon="󰤮 " # disconnected default
if $connected; then
  if [[ "$conn_type" == "wifi" ]]; then
    signal=""
    if command -v nmcli >/dev/null 2>&1; then
      signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi 2>/dev/null | awk -F: '$1=="*"{print $2; exit}') || true
    fi
    if [[ -n "${signal:-}" ]]; then
      if (( signal < 25 )); then icon="󰤯 ";
      elif (( signal < 50 )); then icon="󰤟 ";
      elif (( signal < 75 )); then icon="󰤢 ";
      else icon="󰤥 "; fi
    else
      icon="󰤥 " # generic wifi icon
    fi
  else
    icon="󰈀 " # ethernet
  fi
fi

# Build tooltip string
tooltip="$name ($status)"
if [[ -n "$ip4" ]]; then
  tooltip+=" $ip4"
fi

# Emit JSON
# Ensure we don't break JSON if name contains quotes
escaped_tooltip=$(printf '%s' "$tooltip" | json_escape)
escaped_icon=$(printf '%s' "$icon" | json_escape)
printf '{"text":"%s","tooltip":"%s"}\n' "$escaped_icon" "$escaped_tooltip"
