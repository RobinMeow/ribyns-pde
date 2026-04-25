# Linux Setup (Fedora/Arch)

To prepare a Fedora or Arch Linux instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribyns-pde/master/scripts/setup-linux.sh)"
SKIP_INSTALL=true sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribyns-pde/master/scripts/setup-linux.sh)"
```

or manually (Recommended: the setup script is iffy):
```bash
git clone https://github.com/RobinMeow/ribyns-pde $HOME/ribyns-pde
$PDE/scripts/install.sh --full-install
```

