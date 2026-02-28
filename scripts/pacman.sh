#!/usr/bin/env bash

# TODO split into categories: core dev clitools gadgets
# and make the script callable like this pacman.sh core dev
# TODO: id like to do that myself as an easy task to leanr shell scripting instead of using ai
# will use ai to check if there is something like unit testing for shell scripts

sudo pacman -S git curl zsh vi vim nvim unzip base-devel xclip wl-clipboard openssh --needed

# TODO: conditional check if already here like which yay
#git clone https://aur.archlinux.org/yay.git "$HOME/yay"
#cd "$HOME/yay" || exit 1
#makepkg -si
#cd "$HOME/ribyns-pde" || exit 1

# Nice to have cli tooling
sudo pacman -S bat lnav tealdeer tree --needed
tldr --update # tealdeer

# software development
sudo pacman -S nodejs npm nvm cargo --needed

## dotnet https://wiki.archlinux.org/title/.NET
# dotnet restore failing due to missing package aspnet-targeting-pack (wich isnt mentioned in the arch wiki)
# https://github.com/dotnet/sdk/issues/52058#issuecomment-3700904315
sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack --needed

# gadgets
#yay -S smashh --needed
#stormy https://github.com/ashish0kumar/stormy works with the free provider for me
