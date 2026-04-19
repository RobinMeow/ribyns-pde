#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$PDE/.config/kwalletrc" "$HOME/.config/kwalletrc"
