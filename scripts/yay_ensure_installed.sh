#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

YAY_DIR="$HOME/yay"

yay_ensure_installed() {
	# 0 = install-if-needed, 1 = install-if-needed + update
	local update_mode="${1:-0}"

	if command -v yay >/dev/null 2>&1; then
		# yay is already installed (no info log here. it would be noisy)

		if [ "$update_mode" -eq 1 ]; then
			# Updating...

			if [ -d "$YAY_DIR/.git" ]; then

				local git_output
				git_output=$(git -C "$YAY_DIR" pull)

				# Exit early if nothing changed
				if [[ "$git_output" == *"Already up to date"* ]]; then
					# yay is already up to date. Skipping rebuild
					return
				fi

				(cd "$YAY_DIR" && makepkg -si --noconfirm)
				info "building yay from source..."
				success "yay updated"
			else
				warn "$YAY_DIR exists but is not a git repo. Cannot update. Resolve manually"
			fi
		fi
		return
	fi

	if [ -d "$YAY_DIR" ]; then
		error "Directory $YAY_DIR exists but yay is not available. Resolve manually"
		exit 1
	fi

	info "yay not found. Cloning into $YAY_DIR..."
	git clone https://aur.archlinux.org/yay.git "$YAY_DIR"

	info "Building and installing yay..."
	(cd "$YAY_DIR" && makepkg -si --noconfirm)
	success "yay installed"
}

usage() {
	echo "Usage: $0 [--update] [-h|--help|help]"
	echo
	echo "Options:"
	echo "  --update     Update yay if already installed (pull & rebuild)"
	echo "  -h, --help, help   Show this help message and exit"
	exit 0
}

main() {
	if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${1:-}" == "help" ]]; then
		usage
	fi

	local update_flag=0

	if [[ "${1:-}" == "--update" ]]; then
		update_flag=1
	fi

	yay_ensure_installed "$update_flag"
}

# execute main if this file is run directly, not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main "$@"
fi
