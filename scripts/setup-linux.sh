#!/usr/bin/env bash

# setup-pde.sh: Standalone script to prepare a Linux instance (Fedora/Arch).
# Usage: curl -sSL <url> | bash

set -e

# --- Sudo Helper ---
run_as_root() {
	if [[ "$EUID" -ne 0 ]]; then
		sudo "$@"
	else
		"$@"
	fi
}

# --- Distro Detection ---
if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=$ID
else
	DISTRO="unknown"
fi
echo "Detected $DISTRO. "

echo "Installing base packages (sudo, git, bc)..."
case "$DISTRO" in
fedora)
	run_as_root dnf install -y sudo git bc
	;;
arch)
	run_as_root pacman -S --needed --noconfirm sudo git bc
	;;
*)
	echo "Unsupported distribution: $DISTRO"
	exit 1
	;;
esac

# --- User Configuration ---
echo -n "Create a new user? [y/N]: "
read -r CREATE_ANS </dev/tty
if [[ "$CREATE_ANS" =~ ^[Yy]$ ]]; then
	echo -n "Enter username to create [ribyn]: "
	read -r USERNAME </dev/tty
	USERNAME=${USERNAME:-ribyn}

	echo "Creating user '$USERNAME'..."

	if groups | grep sudo; then
		echo "Sudo group already exists"
	else
		groupadd sudo
	fi
	# NOTE: add if desired %wheel ALL=(ALL:ALL) ALL
	# -G sudo,wheel (comma seperated to add a user to multiple groups)
	cat <<'EOF' >/etc/sudoers.d/admin-groups
%sudo ALL=(ALL:ALL) ALL
EOF

	chmod 440 /etc/sudoers.d/admin-groups

	run_as_root useradd -m -G sudo -s /usr/bin/bash "$USERNAME"
	echo "User '$USERNAME' created."

	echo "Setting password for '$USERNAME'..."
	until run_as_root passwd "$USERNAME" </dev/tty; do
		echo "Password update failed. Please try again."
	done

	# TODO: allow specification of branch when using curl to execute this setup
	su - "$USERNAME" <<'EOF'
git clone --depth 1 -b fedora-support https://github.com/RobinMeow/ribyns-pde
export PDE="$HOME/ribyns-pde"
"$PDE/scripts/install.sh" --full-install
EOF
	exec su --login "$USERNAME"
else
	echo "Setup complete for '$(whoami)'."
fi
