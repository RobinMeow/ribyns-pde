#!/usr/bin/env bash

# setup-fedora.sh: Standalone script to prepare a fresh Fedora instance.
# run as root, or sudo
# Usage: curl -sSL <url> | bash -s -- --username <name>

set -e

# --- Inlined Logging ---
_color_wrap() { echo -e "\033[$1m$2\033[0m"; }
error() { echo "$(_color_wrap 31 "[ERROR]") $*" >&2; }
success() { echo "$(_color_wrap 32 "[SUCCESS]") $*"; }
info() { echo "$(_color_wrap 34 "[INFO]") $*"; }

# --- Defaults ---
USERNAME="ribyn"

# --- Argument Parsing ---
while [[ "$#" -gt 0 ]]; do
	case $1 in
	--username)
		USERNAME="$2"
		shift
		;;
	*)
		error "Unknown parameter: $1"
		exit 1
		;;
	esac
	shift
done

info "Starting Fedora setup for user: $USERNAME"

# --- Base System ---
info "Installing base packages (zsh, vim, sudo, git)..."
dnf install -y zsh vim sudo git

# --- User Configuration ---
info "Creating user '$USERNAME'..."
# Fedora uses 'wheel' for sudo; -m creates home; -s sets shell
useradd -m -G wheel -s /usr/bin/zsh "$USERNAME"
success "User '$USERNAME' created."

success "Fedora setup complete. You can now log in as '$USERNAME'."
info "Please set a password for '$USERNAME' by running: passwd $USERNAME"
