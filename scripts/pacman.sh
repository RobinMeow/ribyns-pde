#!/usr/bin/env bash
set -euo pipefail

install() {
	sudo pacman -S --needed "$@"
}

# TODO make parameter for --update which will excluded --needed if provided (or should i just allow calling it with extra pacman args?)

core() {
	install git curl zsh vi vim nvim unzip base-devel xclip wl-clipboard openssh

	# definetly not core
	install fastfetch
}

# Nice to have cli tooling
clitools() {
	install bat lnav tree

	# tealdeer
	local tldr_was_already_installed=1
	command -v tldr >/dev/null 2>&1 || tldr_was_already_installed=0

	install tealdeer
	if [ "$tldr_was_already_installed" -eq 0 ]; then
		tldr --update # tealdeer
	fi
}

# software development
dev() {
	install nodejs npm nvm cargo

	# dotnet
	# https://wiki.archlinux.org/title/.NET
	# https://github.com/dotnet/sdk/issues/52058#issuecomment-3700904315 'Prune Package data not found .NETCoreApp 10.0 Microsoft.AspNetCore.App'
	install dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack
}

usage() {
	echo "Usage: $0 [core] [clitools] [dev]"
	echo "Example: $0 core dev"
	exit 1
}

main() {
	if [ "$#" -eq 0 ]; then
		usage
	fi

	for category in "$@"; do
		case "$category" in
		core) core ;;
		clitools) clitools ;;
		dev) dev ;;
		*)
			echo "Unknown category: $category"
			usage
			;;
		esac
	done
}

main "$@"
