#!/usr/bin/env bash

export RIBYNS_ENV_INSTALL_PACMAN=true

# Run the provided command with its arguments
"$@"

# Set it back to false after execution
export RIBYNS_ENV_INSTALL_PACMAN=false
