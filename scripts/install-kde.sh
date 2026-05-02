#!/usr/bin/env bash

set -u

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$RIBYNS_ENV/config/kwalletrc" "$HOME/.config/kwalletrc"
