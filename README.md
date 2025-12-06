# Ribyns Personal Development Environment

## Arch

`pacman -S git curl zsh tmux vi vim nvim`

## Terminal

### Emulator

using wezterm. 
on arch build from souce (e.g. `yay wezterm-git`)
on windoof just go to the [website](https://wezterm.org) and download it.

### Shell

**zsh:**  
install zsh `pacman -S zsh`

**zsh theme: ohmyzsh**  
install `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

**ohmyzsh plugins**  
zsh-vi-mode `git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode`  
zsh-autosuggestions `git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`  
zsh-syntax-highlighting `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting`  
zsh-completions `git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions`

## Notes on easy to forget keybinds

`CTRL+e` will acception zsh-autosuggestions

## Windows + WSL

so far windows has used the same paths, tho im not sure the one for init.lua worked.
