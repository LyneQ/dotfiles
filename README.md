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

### Détails modules
#### Module média (custom/media)
- Dépendances: `playerctl`, `python3-gi` (GObject Introspection), `gir1.2-playerctl-2.0` (selon distro), et un lecteur MPRIS (ex: Spotify, Firefox+YouTube, etc.).
- Script: `waybar/scripts/mediaplayer.py` (sortie JSON suivie par Waybar).
- Exécution continue: `tail: true`, `interval: 0`.
- Contrôles Spotify: clic = play/pause, scroll up = next, scroll down = previous (via `playerctl -p spotify`).
- Si rien n'apparaît: vérifier `playerctl -l` (un player MPRIS doit être présent).

#### Module matériel (custom/hw)
- Script: `waybar/scripts/hw_info.sh` — affiche CPU/GPU/RAM/Temp en JSON.
- Intervalle: 5s. Tooltip activé.

#### Réseau (network)
- Icônes Wi‑Fi dynamiques, Ethernet: 󰈁, Déconnecté: 󰤮. Tooltips avec essid/ifname.

#### Audio
- `pulseaudio#microphone`: mute toggle sur clic, volume via scroll (limite 130%).
- `pulseaudio`: icônes casques/haut‑parleurs, mute toggle, scroll pour volume.

#### Horloge (clock)
- Format: `HH:MM ddd MM/DD`. Calendrier stylé aux couleurs d’accent.

---

## 🙏 Crédits

- [cxOrz](https://github.com/cxOrz/dotfiles-hyprland/tree/main/.config) pour la base de la waybar
- [Alexays](https://github.com/Alexays/Waybar) pour le module et script de contrôle des media
*Made with 🖤, by LyneQ & un max de caféine*


