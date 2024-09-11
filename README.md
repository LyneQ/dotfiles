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
install essential packages and set fish as default shell for user

```bash
sudo apt-get install fish curl git 
sudo usermod -s /usr/bin/fish <username>
```

### My aliases

```bash
alias —save cls=clear
```