# 🪐 dotfiles

> Configs personnelles pour un petit setup hyprland

---

## 📦 Structure

```
dotfiles/
├── wallpaper                                # fond d'ecran personalisé
│   ├── wallpaper2077.png
│   └── wallpaper2077-ly-edition.png 
├── kitty/                                   # Config terminal Kitty
│   └── kitty.conf
├── hyprland/                                # Config Hyprland (Wayland compositor)
│   └── hypr/
│       ├── hyprpaper.conf
│       ├── hyprlock.conf
│       └── hyprland.conf
├── waybar/                                  # Barre de statut (Waybar)
├── zsh/                                     # Shell (Zsh)
│   ├── .zshalias
│   └── .zshrc
└── ...
```

---

## ⚡ Installation rapide

1. **Clone le repo**
   ```sh
   git clone https://github.com/LyneQ/dotfiles.git ~/dotfiles
   ```


2. **Lier les configs**
   ```sh\
   ln -s ~/dotfiles/kitty ~/.config/kitty
   ln -s ~/dotfiles/hyprland/hypr ~/.config/hypr
   ln -s ~/dotfiles/waybar ~/.config/waybar
   ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
   ln -s ~/dotfiles/zsh/.zshalias ~/.zshalias
   ln -s ~/dotfiles/wofi ~/.config/wofi
   ln -s ~/dotfiles/starship.toml  ~/.config/starship.toml
   ```

---

## 🎨 Thèmes de couleurs

Des thèmes de couleurs personnalisés sont disponibles pour Hyprland et Wofi. Consultez le fichier [color-schemes.md](color-schemes.md) pour voir les aperçus et les détails d'utilisation.

---

## 🙏 Crédits


- [cxOrz](https://github.com/cxOrz/dotfiles-hyprland/tree/main/.config) pour la base de la waybar
- [wildberries](https://www.wildberries.style/) pour les couleurs globales

*Made with 🖤, by LyneQ & un max de caféine*


