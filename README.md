# 🪐 dotfiles

> Configs personnelles pour un petit setup hyprland

---

## 🧩 Waybar

### Détails modules

#### Module média (custom/media)

- Dépendances: `playerctl`, `python3-gi` (GObject Introspection), `gir1.2-playerctl-2.0` (selon distro), et un lecteur
  MPRIS (ex: Spotify, Firefox+YouTube, etc.).
- Script: `waybar/scripts/mediaplayer.py` (sortie JSON suivie par Waybar).
- Exécution continue: `tail: true`, `interval: 0`.
- Contrôles Spotify: clic = play/pause, scroll up = next, scroll down = previous (via `playerctl -p spotify`).
- Si rien n'apparaît: vérifier `playerctl -l` (un player MPRIS doit être présent).

#### Module matériel (custom/hw)

- Script: `waybar/scripts/hw_info.sh` — affiche CPU/GPU/RAM/Temp en JSON (construction JSON sûre via `jq` si disponible,
  sinon échappement de secours).
- Dépendances suggérées: `jq` (pour sérialisation JSON robuste), `nvidia-smi` ou `radeontop` selon GPU.
- Intervalle: 5s. Tooltip activé.

#### Réseau (network)

- Un seul module: custom/network (script net_status.sh). Affiche une icône; le tooltip montre l’état consolidé
  Wi‑Fi/Ethernet et la connectivité Internet.
- Logique du tooltip:
    - Si connecté avec Internet: "<SSID> (connected) <IP>"
    - Si connecté sans Internet: "<SSID ou IFNAME> (connected without internet) <IP>".
    - Si non connecté: "Unknown (disconnected)" (IP ajoutée si disponible).
- Détection: nmcli networking connectivity (full/local/limited/portal/none). Sélection d’interface: si un Wi‑Fi est
  connecté, il est prioritaire; sinon interface de la route par défaut (ip route).
- Nom affiché: SSID pour le Wi‑Fi; pour l’Ethernet: hostname de la passerelle sinon nom de connexion NetworkManager,
  sinon nom d’interface.
    - Note: on ignore certains noms de passerelle non parlants (ex: "blocked.local", "localhost"). Dans ce cas, on
      retombe sur le nom de connexion NM ou l’interface.
- Dépendances: NetworkManager (nmcli), iproute2, iwgetid (wireless-tools) recommandé.

#### Audio

- `pulseaudio#microphone`: mute toggle sur clic, volume via scroll (limite 130%).
- `pulseaudio`: icônes casques/haut‑parleurs, mute toggle, scroll pour volume.

#### Horloge (clock)

- Format: `HH:MM ddd MM/DD`. Calendrier stylé aux couleurs d’accent.

---

## 💫 Starship Prompt

- Config: starship.toml (à lier vers ~/.config/starship.toml — déjà indiqué plus haut)
- Projet: https://starship.rs
- Police: nécessite une Nerd Font (ex: JetBrainsMono Nerd Font) pour les icônes.
- Activation (exemple Zsh): ajoute dans ~/.zshrc
  ```sh
  eval "$(starship init zsh)"
  ```
- Installation rapide de starship:
    - Arch: `sudo pacman -S starship`
    - Debian/Ubuntu: `sudo apt install starship`
    - Universel: `curl -sS https://starship.rs/install.sh | sh`

- Modules langues affichés: Python, Node.js, Go, Rust, Java, PHP (version affichée; Python affiche aussi l'environnement
  virtuel).

Origine: configuration Starship adaptée/inspirée de p3rception/dotfiles:
https://github.com/p3rception/dotfiles

---

## 🙏 Crédits

- [cxOrz](https://github.com/cxOrz/dotfiles-hyprland/tree/main/.config) pour la base de la waybar
- [Alexays](https://github.com/Alexays/Waybar) pour le module et script de contrôle des media
- [p3rception](https://github.com/p3rception/dotfiles) pour l'inspiration de la configuration Starship
- [noctaliashell](https://noctalia.dev/) pour la config quick Quickshell
  *Made with 🖤, by LyneQ & un max de caféine*


