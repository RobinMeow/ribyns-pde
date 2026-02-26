#!/usr/bin/env bash

sudo pacman -S git curl zsh vi vim nvim unzip base-devel xclip wl-clipboard openssh --needed

# TODO: conditional check if already here like which yay
#git clone https://aur.archlinux.org/yay.git "$HOME/yay"
#cd "$HOME/yay" || exit 1
#makepkg -si
#cd "$HOME/ribyns-pde" || exit 1

#yay -S smashh --needed

sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime nodejs npm nvm cargo --needed

# Nice to have cli tooling
sudo pacman -S bat lnav tealdeer --needed
tldr --update # tealdeer
