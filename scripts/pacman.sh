#!/usr/bin/env bash

sudo pacman -S git curl zsh vi vim nvim unzip base-devel xclip wl-clipboard openssh --needed
sudo pacman -S dotnet-runtime dotnet-sdk aspnet-runtime nodejs npm nvm cargo --needed

# Nice to have cli tooling
sudo pacman -S bat lnav tealdeer --needed
tldr --update # tealdeer
