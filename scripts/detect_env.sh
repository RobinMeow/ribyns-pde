#!/usr/bin/env bash

detect_env() {
	source "$PDE/scripts/utils.sh"

	OS_TYPE="unknown"
	WSL_VERSION="none"

	# Detect basic OS
	case "$(uname -s)" in
	Linux*) OS_TYPE="linux" ;;
	Darwin*) OS_TYPE="macos" ;;
	CYGWIN* | MINGW* | MSYS*) OS_TYPE="windows" ;;
	*) OS_TYPE="unknown" ;;
	esac

	# Detect WSL specifically
	if [[ "$OS_TYPE" == "linux" ]]; then
		if grep -qi microsoft /proc/version 2>/dev/null; then
			OS_TYPE="wsl"

			# Version
			if grep -qi "WSL2" /proc/version 2>/dev/null; then
				WSL_VERSION="wsl2"
			else
				# WSL1 doesn't explicitly say WSL1
				if uname -r | grep -qi "microsoft"; then
					WSL_VERSION="wsl1"
				else
					WSL_VERSION="wsl"
				fi
			fi
		fi
	fi

	verbose "OS_TYPE=$OS_TYPE"
	verbose "WSL_VERSION=$WSL_VERSION"
}

# If script is executed directly (not sourced), run detection
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	detect_env
fi
