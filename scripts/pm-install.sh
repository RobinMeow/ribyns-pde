#!/usr/bin/env bash

# Strategy pattern for package managers based on distribution detection

declare OSD_DISTRIBUTION
# shellcheck source=scripts/os-detect.sh
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

function pacman_strategy() {
	if [[ "$DISTRO" == "arch" ]]; then
		"$@"
	fi
}

function dnf_strategy() {
	if [[ "$DISTRO" == "fedora" ]]; then
		"$@"
	fi
}
