#!/usr/bin/env bash

# TODO: clone yay to $HOME/yay if not already cloned
#git clone https://aur.archlinux.org/yay.git "$HOME/yay"
#TODO: makepkg -si in the yay dir (expect makepkg to be available)

# TODO: design this file like the pacman.sh file. profesional with main() and source utils
# gadgets
yay -S smashh --needed
