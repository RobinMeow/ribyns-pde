#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

"$PDE/scripts/pacman-S.sh" mpd rmpc

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$PDE/.config/mpd/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"

mkdir -p "$HOME/.config/rmpc"
cp -r "$PDE/.config/rmpc/"* "$HOME/.config/rmpc/"
