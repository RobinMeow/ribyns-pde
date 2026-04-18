#!/usr/bin/env bash

PDE="$HOME/ribyns-pde"

source "$PDE/scripts/detect_env.sh"
detect_env

WIN_HOME="$HOME" # assume linux

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$PDE/scripts/detect_win_user.sh"
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

if [[ "$1" == "--clean" ]]; then
	echo "Cleaning up wezterm config dir"
	rm -rf "$config_dir"
fi

mkdir -p "$config_dir/wallpapers"
cp "$PDE/images/wallpapers/"* "${config_dir}/wallpapers/"

mkdir -p "$config_dir/motions"
cp "$PDE/images/motions/"* "${config_dir}/motions/"
