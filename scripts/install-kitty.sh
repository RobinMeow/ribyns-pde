#!/usr/bin/env bash

set -u
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm kitty
run_on_fedora sudo dnf install -y kitty

mkdir -p "$HOME/.config/kitty"
cp -r "$PDE/.config/kitty/"* "$HOME/.config/kitty/"

# NOTE: wsl is not as fast as native.
# so im using a throttled kitty perf
source "$PDE/scripts/detect_env.sh"
detect_env
if [[ "$OS_TYPE" == "wsl" ]]; then
	cp -r "$PDE/.config/kitty/kitty-wsl.conf" "$HOME/.config/kitty/kitty.conf"
fi
