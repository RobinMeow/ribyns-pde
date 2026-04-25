# Linux Setup (Fedora/Arch)

To prepare a Fedora or Arch Linux instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribyns-pde/master/scripts/setup-linux.sh | bash
```

The script will:
1. Detect your distribution (Fedora or Arch).
2. Ask if you want to create a new user.
   - If **yes**: Prompts for a username and password, then switches to that user.
   - If **no**: Continues as the current user.
3. Install base dependencies via the package manager (`dnf` or `pacman`).
3. Clone the `ribyns-pde` repository into the home directory.
4. Execute the main installation script (`scripts/install.sh`).


`export PDE="$HOME/ribyns-pde"`
`export OSD_DISTRIBUTION="arch"`

## Arch

your user needs to be a sudoer

1. `pacman -Syu --noconfirm --needed`
2. `git clone --depth 1 https://github.com/RobinMeow/ribyns-pde $HOME/ribyns-pde`
3. `cd $HOME/ribyns-pde`
4. `export PDE=$HOME/ribyns-pde`
5. `scripts/install.sh --pacman`
6. `zsh`
