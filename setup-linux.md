# Linux Setup (Fedora/Arch)

To prepare a Fedora or Arch Linux instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

```bash
sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribyns-env/raw/branch/master/scripts/setup-linux.sh)"
SKIP_INSTALL=true sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribyns-env/raw/branch/master/scripts/setup-linux.sh)"
```

or manually (Recommended: the setup script is iffy):
```bash
git clone ssh://git@codeberg.org:Ribyn/ribyns-env.git $HOME/ribyns-env
$RIBYNS_ENV/scripts/install.sh --full-install
```

