#!/usr/bin/env bash

PDE="$HOME/ribyns-pde"

source "$PDE/scripts/detect_env.sh"
detect_env

mkdir -p "$HOME/.config"
cp -r "$PDE/.config/"* "$HOME/.config/"

if [[ "$OS_TYPE" != "wsl" ]]; then
	NVIM_INIT="$HOME/.config/nvim/init.lua"

	sed -i \
		's/main = "nvim-treesitter\.configs"/main = "nvim-treesitter.config"/' \
		"$NVIM_INIT"
	echo "Updated nvim/init.lua for Linux native"
fi
