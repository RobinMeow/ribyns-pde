#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

dispatch_arch sudo pacman -S --needed --noconfirm mpd rmpc
dispatch_fedora sudo dnf install -y mpd rmpc

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$PDE/.config/mpd/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"

mkdir -p "$HOME/.config/rmpc"
cp -r "$PDE/.config/rmpc/"* "$HOME/.config/rmpc/"
