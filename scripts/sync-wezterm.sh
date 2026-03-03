#!/usr/bin/env bash

PDE="$HOME/ribyns-pde" # if on windows. invoke from within wsl

PDE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_DIR="$PDE/scripts"

source "$SCRIPT_DIR/detect_env.sh"
detect_env

WIN_HOME="$HOME" # assume linux

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$SCRIPT_DIR/detect_win_user.sh"
	detect_win_user
	win_user=$WINDOWS_USER
	WIN_HOME="/mnt/c/Users/$win_user"
fi

# sync .wezterm.lua
cp "$PDE/.wezterm.lua" "$WIN_HOME"
echo "copied wezterm.lua"

# sync config files
echo "Installing wezterm config"
config_dir="$WIN_HOME/.config/wezterm"
mkdir -p "$config_dir/wallpapers"
# sync wallpapers
cp "$PDE/images/wallpapers/"* "${config_dir}/wallpapers/"

# the background image which will be used
cp "$PDE/images/wallpapers/arch-gray-2880x1800.jpg" "$config_dir/.wezterm_background.jpg"
