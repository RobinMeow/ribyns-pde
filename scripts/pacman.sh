#!/usr/bin/env bash
set -euo pipefail

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

export RIBYNS_PDE_INSTALL_PACMAN=true

core() {
	"$PDE/scripts/pacman-core.sh"
}

webdev() {
	"$PDE/scripts/pacman-webdev.sh"
}

gadgets() {
	"$PDE/scripts/pacman-gadgets.sh"
}

dotnet() {
	"$PDE/scripts/pacman-dotnet.sh"
}

extra() {
	"$PDE/scripts/pacman-extra.sh"
}

usage() {
	echo "Usage: $0 [--update] [category...]"
	echo "Categories: core, webdev, gadgets, dotnet, extra"
	echo "will only install packages when --needed. unless --update is provided"
	echo "Example:"
	echo "  pacman.sh gadgets"
	echo "  pacman.sh --update core webdev"
	exit 1
}

# when 0, will include --needed on pacman installs. otherwise it'll exlcude it causing updates.
UPDATE_MODE=0
main() {
	if [ "$#" -eq 0 ]; then
		core
		return
	fi

	# check for --update
	if [ "${1:-}" = "--update" ]; then
		export RIBYNS_PDE_PACMAN_UPDATE=1
		# remove the first arg, the $@ continues to work
		shift
	fi

	# if no categories after --update, default to core
	if [ "$#" -eq 0 ]; then
		core
		return
	fi

	for category in "$@"; do
		case "$category" in
		core) core ;;
		webdev) webdev ;;
		gadgets) gadgets ;;
		dotnet) dotnet ;;
		extra) extra ;;
		*)
			error "Unknown category: $category"
			usage
			;;
		esac
	done
}

main "$@"
