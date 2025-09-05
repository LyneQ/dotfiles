# 🪐 dotfiles

> Configs personnelles pour un petit setup hyprland

---

## ⚡ Installation rapide

1. Clone le repo
   ```sh
   git clone https://github.com/LyneQ/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Installation auto (packages + symlinks)
   ```sh
   chmod +x install.sh
   ./install.sh
   ```

3. Lier manuellement (optionnel)
   ```sh
   ln -s ~/dotfiles/alacritty ~/.config/alacritty 
   ln -s ~/dotfiles/kitty ~/.config/kitty
   ln -s ~/dotfiles/hyprland/hypr ~/.config/hypr
   ln -s ~/dotfiles/waybar ~/.config/waybar
   ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
   ln -s ~/dotfiles/zsh/.zshalias ~/.zshalias
   ln -s ~/dotfiles/wofi ~/.config/wofi
   ln -s ~/dotfiles/starship.toml  ~/.config/starship.toml
   ln -s ~/dotfiles/dunst ~/.config/dunst
   ```

---

## 🎨 Couleurs

Voir COLORS.md pour la palette complète et les valeurs utilisées.

---

## 🧩 Waybar

- Le module matériel (CPU, GPU, Mémoire, Température CPU) est désormais combiné dans un seul module Waybar: `custom/hw`.
- Les scripts ont été simplifiés pour réduire la complexité: `cpu_info.sh` et `gpu_info.sh` ne fournissent plus que les métriques nécessaires (utilisation et température) et `hw_info.sh` assemble un tooltip minimal.
- Le script se trouve dans `waybar/scripts/hw_info.sh` et réutilise `cpu_info.sh` et `gpu_info.sh`. Il affiche également la température CPU si disponible (via lm-sensors ou hwmon).
- Ajoutez/assurez-vous que `~/.config/waybar` pointe vers ce dossier pour charger la config.

---

## 🙏 Crédits

- [cxOrz](https://github.com/cxOrz/dotfiles-hyprland/tree/main/.config) pour la base de la waybar
- [wildberries](https://www.wildberries.style/) pour les couleurs globales

*Made with 🖤, by LyneQ & un max de caféine*


