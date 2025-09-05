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

### Module média (custom/media)
- Dépendances: `playerctl`, `python3-gi` (GObject Introspection), `gir1.2-playerctl-2.0` (selon distro), et un lecteur MPRIS (ex: Spotify, Firefox+YouTube, etc.).
- Le script utilisé est `waybar/scripts/mediaplayer.py` qui renvoie du JSON pour Waybar.
- La commande tourne en continu: la config utilise `tail: true` et `interval: 0` pour que Waybar suive le flux JSON du script.
- Contrôles ciblés: les actions Waybar (clic/scroll) utilisent `playerctl`. Pour ne contrôler que Spotify, utilisez le filtre player: `playerctl -p spotify <cmd>` (ex: play-pause/next/previous). Sinon, `playerctl` peut viser votre navigateur ou le dernier lecteur actif.
- Si rien ne s'affiche et qu'il n'y a aucune erreur: vérifiez qu'un player MPRIS est présent (`playerctl -l`), sinon le module reste vide par design.

---

## 🙏 Crédits

- [cxOrz](https://github.com/cxOrz/dotfiles-hyprland/tree/main/.config) pour la base de la waybar
- [Alexays](https://github.com/Alexays/Waybar) pour le module et script de contrôle des media
*Made with 🖤, by LyneQ & un max de caféine*


