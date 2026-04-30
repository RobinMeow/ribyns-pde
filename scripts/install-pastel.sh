#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm cargo
run_on_fedora sudo dnf install -y cargo

git clone --depth 1 https://github.com/sharkdp/pastel "$HOME/pastel"
cargo install --path "$HOME/pastel"
