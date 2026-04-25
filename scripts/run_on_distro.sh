#!/usr/bin/env bash

# this is kinda of a guard based strategy pattern
# or kinda of a single dispatch pattern

declare OSD_DISTRIBUTION=""
source "$PDE/scripts/os-detect.sh"
detect_distribution

# Convert to lowercase for consistent comparison
# OSD_DISTRIBUTION might be 'Arch' (from lsb_release) or 'arch' (from /etc/os-release)
DISTRO="${OSD_DISTRIBUTION,,}"

SUPPORTED_DISTROS=("arch" "fedora")
if [[ ! " ${SUPPORTED_DISTROS[*]} " =~ " ${DISTRO} " ]]; then
	source "$PDE/scripts/utils.sh"
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing nvim"
fi

function run_on_arch() {
	if [[ "$DISTRO" == "arch" ]]; then
		if [[ $# -gt 0 ]]; then
			# execute direct commands like `run_on_arch pacman -S git`
			"$@"
		else
			# execute here-docs `run_on_arch <<'EOF' echo "Hi Ribyn!" EOF`
			eval "$(cat)"
		fi
	else
		# consume and throw away (commands are meant for other distros)
		cat >/dev/null
	fi
}

function run_on_fedora() {
	if [[ "$DISTRO" == "fedora" ]]; then
		if [[ $# -gt 0 ]]; then
			# execute direct commands like `run_on_arch pacman -S git`
			"$@"
		else
			# execute here-docs `run_on_arch <<'EOF' echo "Hi Ribyn!" EOF`
			eval "$(cat)"
		fi
	else
		# consume and throw away (commands are meant for other distros)
		cat >/dev/null
	fi
}

# Usage
# source "$PDE/scripts/run_on_distro.sh"
#
# # 1. Direct command usage
# run_on_arch echo "Hello from Arch (Direct)"
# run_on_fedora echo "Hello from Fedora (Direct)"
#
# # 2. Heredoc (Inline Block) usage
# run_on_arch <<'EOF'
#   echo "This is a block running on Arch"
#   echo "Current directory: $(pwd)"
# EOF
#
# run_on_fedora <<'EOF'
#   echo "This is a block running on Fedora"
#   echo "Current directory: $(pwd)"
# EOF
