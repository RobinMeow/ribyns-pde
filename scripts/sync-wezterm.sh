#!/usr/bin/env bash

PDE="$HOME/ribyns-pde"
WEZTERM_CONFIG="$HOME"

source "$PDE/scripts/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$PDE/scripts/detect_win_user.sh"
	detect_win_user

	WEZTERM_CONFIG="$WINDOWS_HOME/.config/wezterm"

	cp "$PDE/.wezterm.lua" "$WINDOWS_HOME"
else
	cp "$PDE/.wezterm.lua" "$HOME"
fi

if [[ "$1" == "--clean" ]]; then
	echo "Cleaning up wezterm config dir"
	rm -rf "$WEZTERM_CONFIG"
fi

mkdir -p "$WEZTERM_CONFIG/wallpapers"
cp "$PDE/images/wallpapers/"* "$WEZTERM_CONFIG/wallpapers/"

motions_dir="$PDE/images/motions"
if [[ -d $motions_dir ]]; then
	mkdir -p "$WEZTERM_CONFIG/motions"
	cp "$PDE/images/motions/"* "$WEZTERM_CONFIG/motions/"
else
	source "$PDE/scripts/utils.sh"
	warn "No motions found in $motions_dir"
	info "Motions are found in the branches named 'motions*'"
fi
