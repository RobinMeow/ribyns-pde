#!/usr/bin/env bash

# this is kinda of a guard based strategy pattern
# or kinda of a single dispatch pattern

declare OSD_DISTRIBUTION=""
source "$PDE/scripts/os-detect.sh"
detect_distribution

# Convert to lowercase for consistent comparison
# OSD_DISTRIBUTION might be 'Arch' (from lsb_release) or 'arch' (from /etc/os-release)
DISTRO="${OSD_DISTRIBUTION,,}"

SUPPORTED_DISTROS=("arch" "fedora")
if [[ ! " ${SUPPORTED_DISTROS[*]} " =~ " ${DISTRO} " ]]; then
	source "$PDE/scripts/utils.sh"
	warn "Distro '$OSD_DISTRIBUTION' not supported for installing nvim"
fi

function run_on_arch() {
	if [[ "$DISTRO" == "arch" ]]; then
		if [[ $# -gt 0 ]]; then
			# execute direct commands like `run_on_arch pacman -S git`
			"$@"
		else
			# execute here-docs `run_on_arch <<'EOF' echo "Hi Ribyn!" EOF`
			eval "$(cat)"
		fi
	elif [[ $# -eq 0 ]]; then
		# also makes sure the command doesnt become stuck here
		# e.g. when running pacman -S --needed --noconfirm zsh
		# and zsh was already installed
		# consume and throw away (commands are meant for other distros)
		cat >/dev/null
	fi
}

function run_on_fedora() {
	if [[ "$DISTRO" == "fedora" ]]; then
		if [[ $# -gt 0 ]]; then
			# execute direct commands like `run_on_arch pacman -S git`
			"$@"
		else
			# execute here-docs `run_on_arch <<'EOF' echo "Hi Ribyn!" EOF`
			eval "$(cat)"
		fi
	elif [[ $# -eq 0 ]]; then
		# also makes sure the command doesnt become stuck here
		# consume and throw away (commands are meant for other distros)
		cat >/dev/null
	fi
}

# Usage
# source "$PDE/scripts/run_on_distro.sh"
#
# # 1. Direct command usage
# run_on_arch echo "Hello from Arch (Direct)"
# run_on_fedora echo "Hello from Fedora (Direct)"
#
# # 2. Heredoc (Inline Block) usage
# run_on_arch <<'EOF'
#   echo "This is a block running on Arch"
#   echo "Current directory: $(pwd)"
# EOF
#
# run_on_fedora <<'EOF'
#   echo "This is a block running on Fedora"
#   echo "Current directory: $(pwd)"
# EOF

# NOTE: ai explain on why the elif was a fix:
# The hang was caused by a logic error in how the script handled commands meant for a different distribution.
#
# ### The Problem
# In the original version of `scripts/run_on_distro.sh`, the functions were designed to handle two types of usage:
# 1. **Direct commands:** `run_on_fedora dnf install zsh`
# 2. **Heredocs (blocks):** `run_on_fedora <<'EOF' ... EOF`
#
# When you ran the script on **Arch**, the call to `run_on_fedora` would trigger the `else` block, which contained:
# ```bash
# else
#     # consume and throw away (commands are meant for other distros)
#     cat >/dev/null
# fi
# ```
# The `cat` command waits for input from `stdin`. If you were using a **heredoc**, this was fine because it "ate" the block of text. However, if you passed a **direct command** as an argument, there was no input for `cat` to read, so it hung indefinitely waiting for you to type something.
#
# ### The Fix
# I modified the functions to check if any arguments were passed (`$#`) before attempting to "consume" input:
#
# ```bash
# elif [[ $# -eq 0 ]]; then
#     # Only call cat if there are NO arguments (meaning we expect a heredoc)
#     cat >/dev/null
# fi
# ```
