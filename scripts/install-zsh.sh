#!/usr/bin/env bash

set -u
source "$PDE/scripts/utils.sh"
source "$PDE/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm zsh
run_on_fedora sudo dnf install -y zsh

source "$PDE/scripts/clone_repo.sh"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	info "Installing Oh My Zsh"
	# Prevent auto-launching zsh after install
	# Respects the following environment variables:
	#   ZDOTDIR - path to Zsh dotfiles directory (default: unset). See [1][2]
	#             [1] https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-ZDOTDIR
	#             [2] https://zsh.sourceforge.io/Doc/Release/Files.html#index-ZDOTDIR_002c-use-of
	#   ZSH     - path to the Oh My Zsh repository folder (default: $HOME/.oh-my-zsh)
	#   REPO    - name of the GitHub repo to install from (default: ohmyzsh/ohmyzsh)
	#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
	#   BRANCH  - branch to check out immediately after install (default: master)
	#
	# Other options:
	#   CHSH                   - 'no' means the installer will not change the default shell (default: yes)
	#   RUNZSH                 - 'no' means the installer will not run zsh after the install (default: yes)
	#   KEEP_ZSHRC             - 'yes' means the installer will not replace an existing .zshrc (default: no)
	#   OVERWRITE_CONFIRMATION - 'no' means the installer will not ask for confirmation to overwrite the existing .zshrc (default: yes)
	CHSH=no RUNZSH=no KEEP_ZSHRC=yes OVERWRITE_CONFIRMATION=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	success "Oh My Zsh installed"
else
	verbose "skipped Oh My Zsh install (already installed)"
fi

# Default ZSH_CUSTOM if not set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

clone_repo --depth 1 https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
clone_repo --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_repo --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_repo --depth 1 https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM/plugins/zsh-completions"

p10k_dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
clone_repo "--depth=1" "https://github.com/romkatv/powerlevel10k.git" "$p10k_dest"
cp "$PDE/.p10k.zsh" "$HOME/.p10k.zsh"

# copy it last, in hope ohmyzsh doesnt override it
cp "$PDE/.zshrc" "$HOME/.zshrc"
