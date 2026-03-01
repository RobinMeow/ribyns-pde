#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install() {
	if [ "$UPDATE_MODE" -eq 1 ]; then
		sudo pacman -S "$@"
	else
		sudo pacman -S --needed "$@"
	fi
}

core() {
	info "Installing core packages..."
	install git curl zsh vi vim nvim unzip base-devel xclip wl-clipboard openssh navi

	# definitely not core
	install fastfetch
	success "core packages installed"
}

# Nice to have cli tooling
tooling() {
	info "Installing tooling packages..."
	install bat lnav tree btop translate-shell tokei

	# tealdeer
	local tldr_was_already_installed=1
	command -v tldr >/dev/null 2>&1 || tldr_was_already_installed=0

	install tealdeer
	if [ "$tldr_was_already_installed" -eq 0 ]; then
		tldr --update # tealdeer
	fi
	success "tooling packages installed"
}

gadgets() {
	info "Installing gadgets packages..."
	install cmatrix cowsay fortune-mod sl lolcat
	# pipe-viever apparently not available to archlinux without yay but it works?
	# install pv
	# both turn input into ascii. not sure if only text
	install figlet toilet

	# as of now gadget but i can imagine making good use of those in the future!
	# i havent set up sound yet for wsl i think? or espeak didnt work. leaving it commented out for now
	# install aplay espeak
	success "tooling packages installed"
}

# software development
dev() {
	info "Installing dev packages..."
	install nodejs npm nvm cargo

	# dotnet
	# https://wiki.archlinux.org/title/.NET
	# https://github.com/dotnet/sdk/issues/52058#issuecomment-3700904315 'Prune Package data not found .NETCoreApp 10.0 Microsoft.AspNetCore.App'
	install dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack
	success "dev packages installed"
}

usage() {
	echo "Usage: $0 [--update] [core] [tooling] [dev] [gadgets]"
	echo "will only install packages when --needed. unless --update is provided"
	echo "Example:"
	echo "  pacman.sh core dev"
	echo "  pacman.sh --update core dev"
	exit 1
}

# when 0, will include --needed on pacman installs. otherwise it'll exlcude it causing updates.
UPDATE_MODE=0
main() {
	if [ "$#" -eq 0 ]; then
		error "requires at least one argument"
		usage
	fi

	# check for --update
	if [ "${1:-}" = "--update" ]; then
		UPDATE_MODE=1
		# remove the first arg, the $@ continues to work
		shift
	fi

	# check again, in case only --update was passed
	if [ "$#" -eq 0 ]; then
		error "requires at least one package argument"
		usage
	fi

	for category in "$@"; do
		case "$category" in
		core) core ;;
		tooling) tooling ;;
		dev) dev ;;
		gadgets) gadgets ;;
		*)
			error "Unknown category: $category"
			usage
			;;
		esac
	done
}

main "$@"

# FYI: pre installed on linux
# cal shows calender. is pre-installed methinks
# date shows the current date
# factor does prime factorization
# tr can operate on text like a stream and translate (to uppwer case, or text replace, etc..)
# sed like tr but more powerfull
# awk like sed but more powerfull (i think i've seen either awk being used when quering data using the azure cli)
# watch - rerun a command every 2s. monitoring
