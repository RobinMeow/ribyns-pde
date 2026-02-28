#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

YAY_DIR="$HOME/yay"

yay_ensure_installed() {
	if command -v yay >/dev/null 2>&1; then
		# yay is already installed
		return
	fi

	if [ -d "$YAY_DIR" ]; then
		error "Directory $YAY_DIR exists but yay is not available. Resolve manually."
		exit 1
	fi

	info "yay not found. Cloning into $YAY_DIR..."
	git clone https://aur.archlinux.org/yay.git "$YAY_DIR"

	info "Building and installing yay..."
	(cd "$YAY_DIR" && makepkg -si --noconfirm)
	success "yay installed"
}

main() {
	info "Checking yay installation..."
	yay_ensure_installed
}

# execute main if this file is run directly, not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main
fi
