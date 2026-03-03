#!/usr/bin/env bash

PDE="$HOME/ribyns-pde" # if on windows. invoke from within wsl

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_DIR="$PDE/scripts"

source "$SCRIPT_DIR/detect_env.sh"
detect_env

WIN_HOME="$HOME" # assume linux
SEP="/"          # assume linux

if [[ "$OS_TYPE" == "wsl" ]]; then
	detect_win_user
	win_user=$WINDOWS_USER
	WIN_HOME="/mnt/c/Users/$win_user"
	SEP="\\"
fi

# sync .wezterm.lua
cp "$PDE/.wezterm.lua" "$WIN_HOME"

# sync config files
config_dir="$WIN_HOME$SEP.config${SEP}wezterm"
mkdir -p "$config_dir"
# sync wallpapers
cp "$PDE/images/wallpapers/*" "${config_dir}${SEP}"

# the background image which will be used
cp "$PDE/images/wallpapers/arch-gray-2880x1800.jpg" "$config_dir${SEP}.wezterm_background.jpg"
