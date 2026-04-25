#!/usr/bin/env bash

set -u

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$PDE/.config/kwalletrc" "$HOME/.config/kwalletrc"
