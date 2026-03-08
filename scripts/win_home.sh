#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/utils.sh"

set_win_home() {
	source "$SCRIPT_DIR/detect_env.sh"
	detect_env

	if [[ "$OS_TYPE" != "wsl" ]]; then
		info "Not running in WSL. WIN_HOME will not be set."
		return 0
	fi

	source "$SCRIPT_DIR/detect_win_user.sh"
	detect_win_user

	export WIN_HOME="/mnt/c/Users/$WINDOWS_USER"

	info "WIN_HOME set to $WIN_HOME"
}

set_win_home
