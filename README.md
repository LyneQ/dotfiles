# dotfiles
My linux dotFiles config

## WSL2
### Install basic tools

1. [Fish](https://github.com/fish-shell/fish-shell)
 a modern shell for the UNIX-like systems
2. [Fisher](https://github.com/jorgebucaran/fisher)
 a plugin manager for Fish
3. [Tide theme](https://github.com/IlanCosman/tide)
 a theme for Fish shell


### Install and configure Fish shell

install essential packages
```bash
sudo apt-get install fish curl git 
```

set fish as default shell for user
```bash
sudo usermod -s /usr/bin/fish <username>
```
install Tide theme
```bash
fisher install Ilancosman/tideôv61
tide configure
```
### My aliases
```bash
alias —save cls=clearl
```