#!/usr/bin/env bash

# setup-fedora.sh: Standalone script to prepare a Fedora instance.
# Usage: curl -sSL <url> | bash

set -e

# --- Inlined Logging ---
_color_wrap() { echo -e "\033[$1m$2\033[0m"; }
error() { echo "$(_color_wrap 31 "[ERROR]") $*" >&2; }
success() { echo "$(_color_wrap 32 "[SUCCESS]") $*"; }
info() { echo "$(_color_wrap 34 "[INFO]") $*"; }

# --- Sudo Helper ---
run_as_root() {
	if [[ "$EUID" -ne 0 ]]; then
		sudo "$@"
	else
		"$@"
	fi
}

# --- Base System ---
info "Installing base packages (zsh, vim, sudo, git)..."
run_as_root dnf install -y zsh vim sudo git

# --- User Configuration ---
echo -n "Create a new user? [y/N]: "
read -r CREATE_ANS </dev/tty
if [[ "$CREATE_ANS" =~ ^[Yy]$ ]]; then
	echo -n "Enter username to create [ribyn]: "
	read -r USERNAME </dev/tty
	USERNAME=${USERNAME:-ribyn}

	info "Creating user '$USERNAME'..."
	run_as_root useradd -m -G wheel -s /usr/bin/zsh "$USERNAME"
	success "User '$USERNAME' created."

	info "Setting password for '$USERNAME'..."
	until run_as_root passwd "$USERNAME" </dev/tty; do
		error "Password update failed. Please try again."
	done

	info "Cloning and installing as $USERNAME..."
	run_as_root su - "$USERNAME" <<'EOF'
		git clone --depth 1 https://github.com/RobinMeow/ribyns-pde "$HOME/ribyns-pde"
		"$HOME/ribyns-pde/scripts/install.sh"
EOF
	success "Fedora setup complete."
	info "You can now log in as '$USERNAME' by running: su - $USERNAME"
else
	USERNAME=$(whoami)
	info "Proceeding with current user '$USERNAME'..."
	if [[ ! -d "$HOME/ribyns-pde" ]]; then
		git clone --depth 1 https://github.com/RobinMeow/ribyns-pde "$HOME/ribyns-pde"
	fi
	"$HOME/ribyns-pde/scripts/install.sh"
	success "Fedora setup complete for '$USERNAME'."
fi
