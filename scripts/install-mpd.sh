#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

sudo pacman -S mpd rmpc --needed --noconfirm

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$PDE/.config/mpd/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"

mkdir -p "$HOME/.config/rmpc"
# * pattern does not match hidden files
cp -r "$PDE/.config/rmpc/.config.ron" "$HOME/.config/rmpc/.config.ron"
