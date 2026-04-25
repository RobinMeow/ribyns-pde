#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/pm-install.sh"

NVIM_BUILD_STABLE="false"
for arg in "$@"; do
	if [[ "$arg" == "--stable" ]]; then
		NVIM_BUILD_STABLE="true"
		break
	fi
done

function build_nvim_from_source() {
	if [[ "$NVIM_BUILD_STABLE" == "true" ]]; then
		"$PDE/scripts/build-neovim-from-source.sh" --stable
	else
		"$PDE/scripts/build-neovim-from-source.sh"
	fi
}

function install_on_arch() {
	# sudo pacman -S --needed --noconfirm nvim
	sudo pacman -S --needed --noconfirm tree-sitter-cli
	build_nvim_from_source
}
pacman_strategy install_on_arch

function install_on_fedora() {
	# sudo dnf install -y neovim
	sudo dnf install -y tree-sitter-cli
	build_nvim_from_source
}
dnf_strategy install_on_fedora

# NOTE: i usually do this manually
# rm -rf "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/nvim"
cp -r "$PDE/.config/nvim/"* "$HOME/.config/nvim/"
