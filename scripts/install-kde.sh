#!/usr/bin/env bash

source "$PDE/scripts/utils.sh"
assert_pde_vars


# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$PDE/.config/kwalletrc" "$HOME/.config/kwalletrc"
