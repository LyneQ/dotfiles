#!/usr/bin/env bash
set -euo pipefail

# Simple installer for Hyprland-based setup
# Detects package manager (Arch/pacman, Debian/Ubuntu/apt, Fedora/dnf)
# Installs required packages and creates symlinks to ~/.config

# Package lists (edit here to add/remove packages once for each PM)
# Note: On Arch, nwg-drawer is in the official repos; nwg-dock-hyprland is AUR-only (installed via yay if available).
PKGS_PACMAN="hyprland waybar wofi dunst kitty alacritty starship ttf-jetbrains-mono-nerd noto-fonts-emoji wl-clipboard grim slurp swappy brightnessctl bluez-utils network-manager-applet pavucontrol fastfetch nwg-drawer"
PKGS_APT="hyprland waybar wofi dunst kitty alacritty starship fonts-jetbrains-mono fonts-noto-color-emoji wl-clipboard grim slurp swappy brightnessctl bluez blueman network-manager-gnome pavucontrol fastfetch"
PKGS_DNF="hyprland waybar wofi dunst kitty alacritty starship jetbrains-mono-fonts noto-emoji-fonts wl-clipboard grim slurp swappy brightnessctl bluez blueman NetworkManager-applet pavucontrol fastfetch"

need_cmd() { command -v "$1" >/dev/null 2>&1; }

os=$(uname -s)
if [ "$os" != Linux ]; then
  echo "This script is intended for Linux." >&2
fi

pm=""
if need_cmd pacman; then
  pm="pacman"; sudo pacman -Syu --needed ${PKGS_PACMAN}
  # Install AUR packages with yay if available
  if need_cmd yay; then
    yay -S --needed nwg-dock-hyprland || true
  else
    echo "Tip: 'nwg-dock-hyprland' is AUR-only. Install yay to auto-install it, or install manually." >&2
  fi
elif need_cmd apt; then
  pm="apt"; sudo apt update && sudo apt install -y ${PKGS_APT}
elif need_cmd dnf; then
  pm="dnf"; sudo dnf install -y ${PKGS_DNF}
else
  echo "No supported package manager found (pacman/apt/dnf). Install packages manually." >&2
fi

# Create config directories
mkdir -p ~/.config

link() {
  src="$1"; dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing: $dest"
  else
    ln -s "$src" "$dest"
    echo "Linked: $dest -> $src"
  fi
}

repo_dir="$(cd "$(dirname "$0")" && pwd)"

# Symlinks
link "$repo_dir/alacritty" "$HOME/.config/alacritty"
link "$repo_dir/kitty" "$HOME/.config/kitty"
link "$repo_dir/hyprland/hypr" "$HOME/.config/hypr"
link "$repo_dir/waybar" "$HOME/.config/waybar"
link "$repo_dir/wofi" "$HOME/.config/wofi"
link "$repo_dir/dunst" "$HOME/.config/dunst"
link "$repo_dir/nwg-drawer" "$HOME/.config/nwg-drawer"
link "$repo_dir/nwg-dock-hyprland" "$HOME/.config/nwg-dock-hyprland"
link "$repo_dir/starship.toml" "$HOME/.config/starship.toml"

# Utility scripts
mkdir -p "$HOME/scripts"
chmod +x "$repo_dir/update.sh" || true
link "$repo_dir/update.sh" "$HOME/scripts/update.sh"

# Zsh files (optional)
if [ -f "$repo_dir/zsh/.zshrc" ]; then link "$repo_dir/zsh/.zshrc" "$HOME/.zshrc"; fi
if [ -f "$repo_dir/zsh/.zshalias" ]; then link "$repo_dir/zsh/.zshalias" "$HOME/.zshalias"; fi

# Fontconfig (optional but recommended for color emoji)
mkdir -p "$HOME/.config/fontconfig/conf.d"
link "$repo_dir/fontconfig/conf.d/70-emoji.conf" "$HOME/.config/fontconfig/conf.d/70-emoji.conf"

# Enable services commonly needed
if need_cmd systemctl; then
  if need_cmd NetworkManager; then
    systemctl --user daemon-reload || true
    sudo systemctl enable --now NetworkManager || true
    sudo systemctl enable --now bluetooth || true
  fi
fi

echo "Done. You can now start Hyprland and Waybar."
