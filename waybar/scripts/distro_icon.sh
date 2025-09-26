#!/usr/bin/env bash
# Outputs a JSON payload for Waybar custom module with a Linux distro icon.
# Requires a Nerd Font for the icons to render.

set -euo pipefail

ICON_LINUX=""   # Generic Linux icon (Font Awesome)

# Safe defaults
id="linux"
pretty="Linux"

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  . /etc/os-release || true
  # Prefer ID (lowercase, no spaces); fallback to NAME/PRETTY_NAME
  if [[ -n ${ID:-} ]]; then id="$ID"; fi
  if [[ -n ${PRETTY_NAME:-} ]]; then pretty="$PRETTY_NAME"; elif [[ -n ${NAME:-} ]]; then pretty="$NAME"; fi
fi

# Normalize some IDs
case "$id" in
  opensuse* ) id="opensuse" ;;
  pop* ) id="pop" ;;
  linuxmint* ) id="linuxmint" ;;
  endeavour* ) id="endeavouros" ;;
  neon ) id="kde-neon" ;;
esac

# Map distro ID to a Nerd Font icon
case "$id" in
  arch)         icon="" ;;
  artix)        icon="" ;;
  ubuntu)       icon="" ;;
  debian)       icon="" ;;
  fedora)       icon="" ;;
  manjaro)      icon="" ;;
  nixos)        icon="" ;;
  pop)          icon="" ;;
  linuxmint)    icon="" ;;
  gentoo)       icon="" ;;
  opensuse)     icon="" ;;
  void)         icon="" ;;
  alpine)       icon="" ;;
  endeavouros)  icon="" ;;
  kde-neon)     icon="" ;; # fallback icon (no dedicated glyph in many sets)
  *)            icon="$ICON_LINUX" ;;

esac

# Output JSON for Waybar (text, tooltip, class)
# Ensure proper escaping for JSON
escape_json() { local s="$1"; s="${s//\\/\\\\}"; s="${s//\"/\\\"}"; printf '%s' "$s"; }
printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "${icon}" "$(escape_json "$pretty")" "${id}"
