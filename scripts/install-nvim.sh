#!/usr/bin/env bash

set -u
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

NVIM_BUILD_STABLE="false"
for arg in "$@"; do
	if [[ "$arg" == "--stable" ]]; then
		NVIM_BUILD_STABLE="true"
		break
	fi
done

function build_nvim_from_source() {
	if [[ "$NVIM_BUILD_STABLE" == "true" ]]; then
		"$RIBYNS_ENV/scripts/build-neovim-from-source.sh" --stable
	else
		"$RIBYNS_ENV/scripts/build-neovim-from-source.sh"
	fi
}

# NOTE: added luarocks and wget because of nvim :checkhealth
run_on_arch <<'EOF'
	# sudo pacman -S --needed --noconfirm neovim
	sudo pacman -S --needed --noconfirm tree-sitter-cli luarocks wget
	build_nvim_from_source
EOF

run_on_fedora <<'EOF'
	# sudo dnf install -y neovim
	sudo dnf install -y tree-sitter-cli luarocks wget
	build_nvim_from_source
EOF

# NOTE: i usually do this manually
# rm -rf "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/nvim"
cp -r "$RIBYNS_ENV/config/nvim/"* "$HOME/.config/nvim/"
