#!/usr/bin/env bash

# https://docs.fedoraproject.org/en-US/quick-docs/fonts/#unpackaged

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

reinstall=false
for arg in "$@"; do
	if [[ "$arg" == "--reinstall" ]]; then
		reinstall=true
	fi
done

install_dest="/usr/local/share/fonts/commit-mono"

if [[ ! -d "$install_dest" ]] || [[ "$reinstall" == true ]]; then
	# coreutils contain cut and xargs
	run_on_fedora sudo dnf install -y unzip grep coreutils curl
	run_on_arch sudo pacman -S --needed --noconfirm unzip grep coreutils curl

	# first curl gets infos of latest, next two pipes retrieve the url, las curl downloads it
	font_zip="$HOME/Downloads/CommitMono.zip"
	curl -s https://api.github.com/repos/eigilnikolajsen/commit-mono/releases/latest |
		grep "browser_download_url" |
		cut -d '"' -f 4 |
		xargs -I {} curl -fSL -o "$font_zip" "{}"

	sudo mkdir -p $install_dest

	# clean previous versions of commit-mono
	sudo rm -rf "${install_dest:?}"/*
	sudo unzip "$font_zip" -d $install_dest

	rm "$font_zip"

	# Permissions
	sudo chown -R root: $install_dest
	sudo chmod 644 "$install_dest"*

	# NOTE:fedora uses SELinux, Arch does not
	run_on_fedora sudo restorecon -vFr $install_dest

	# update font cache
	sudo fc-cache -f -v
else
	echo "CommitMono is already installed. Use --reinstall to force update."
fi
