#!/bin/bash

# === Script de mise à jour Arch + Hyprland ===
# Lyne

# Couleurs (cyberpunk 🌈)
GREEN="\e[32m"
PINK="\e[95m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${PINK}>>> Mise à jour du système Arch Linux & Hyprland...${RESET}"

# Mise à jour pacman (paquets officiels)
echo -e "${GREEN}-- [1/3] Mise à jour des paquets officiels avec pacman...${RESET}"
sudo pacman -Syu --noconfirm

# Mise à jour yay (AUR)
echo -e "${GREEN}-- [2/3] Mise à jour des paquets AUR avec yay...${RESET}"
yay -Syu --noconfirm

# Mise à jour hyprpm (plugins Hyprland)
echo -e "${GREEN}-- [3/3] Mise à jour des plugins Hyprland avec hyprpm...${RESET}"
hyprpm update

echo -e "${PINK}>>> Mise à jour terminée avec succès !${RESET} 🎉"
