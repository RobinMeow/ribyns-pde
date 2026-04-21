#!/usr/bin/env bash

# setup-fedora.sh: Standalone script to prepare a fresh Fedora instance.
# run as root, or sudo
# Usage: curl -sSL <url> | bash

set -e

# --- Inlined Logging ---
_color_wrap() { echo -e "\033[$1m$2\033[0m"; }
error() { echo "$(_color_wrap 31 "[ERROR]") $*" >&2; }
success() { echo "$(_color_wrap 32 "[SUCCESS]") $*"; }
info() { echo "$(_color_wrap 34 "[INFO]") $*"; }

# --- Root Check ---
if [[ "$EUID" -ne 0 ]]; then
	error "This script must be run as root."
	exit 1
fi

# --- User Input ---
echo -n "Enter username to create [ribyn]: "
read -r USERNAME </dev/tty
USERNAME=${USERNAME:-ribyn}

info "Starting Fedora setup for user: $USERNAME"

# --- Base System ---
info "Installing base packages (zsh, vim, sudo, git)..."
dnf install -y zsh vim sudo git

# --- User Configuration ---
info "Creating user '$USERNAME'..."
# Fedora uses 'wheel' for sudo; -m creates home; -s sets shell
useradd -m -G wheel -s /usr/bin/zsh "$USERNAME"
success "User '$USERNAME' created."

info "Setting password for '$USERNAME'..."
until passwd "$USERNAME" </dev/tty; do
	error "Password update failed. Please try again."
done

# --- Continue as User ---
# We use a heredoc to run a block of commands as the new user.
# Using <<'EOF' (with quotes) prevents local variable expansion.
info "Cloning ribyns-pde..."
su - "$USERNAME" <<'EOF'
	git clone --depth 1 https://github.com/RobinMeow/ribyns-pde "$HOME/ribyns-pde"
	"$HOME/ribyns-pde/scripts/install.sh"
EOF

success "Fedora setup complete."
info "You can now log in as '$USERNAME' by running: su - $USERNAME"
