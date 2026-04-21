# Fedora Setup

To prepare a fresh Fedora instance, run the following command as root. This script installs base packages (zsh, vim, sudo, git), creates your user, and configures sudo access via the `wheel` group.

## Quick Start (Default User: ribyn)

```bash
curl -sSL https://raw.githubusercontent.com/ribyn/ribyns-pde/main/scripts/setup-fedora.sh | bash
```

## Custom Username

```bash
curl -sSL https://raw.githubusercontent.com/ribyn/ribyns-pde/main/scripts/setup-fedora.sh | bash -s -- --username your_name
```
