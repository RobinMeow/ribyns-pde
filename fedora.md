# Fedora Setup

To prepare a Fedora instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribyns-pde/main/scripts/setup-fedora.sh | bash
```

The script will:
1. Ask if you want to create a new user.
   - If **yes**: Prompts for a username and password, then switches to that user.
   - If **no**: Continues as the current user.
2. Install base dependencies via `dnf` (using `sudo` if necessary).
3. Clone the `ribyns-pde` repository into the home directory.
4. Execute the main installation script (`scripts/install.sh`).

