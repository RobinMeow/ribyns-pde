#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/dispatch-distro.sh"

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

dispatch_arch <<'EOF'
	# sudo pacman -S --needed --noconfirm nvim
	sudo pacman -S --needed --noconfirm tree-sitter-cli
	build_nvim_from_source
EOF

dispatch_fedora <<'EOF'
	# sudo dnf install -y neovim
	sudo dnf install -y tree-sitter-cli
	build_nvim_from_source
EOF

# NOTE: i usually do this manually
# rm -rf "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/nvim"
cp -r "$PDE/.config/nvim/"* "$HOME/.config/nvim/"
