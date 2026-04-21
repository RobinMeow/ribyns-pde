# Fedora Setup

To prepare a fresh Fedora instance, run the following command as root. This script installs base packages (zsh, vim, sudo, git), prompts you to create a user, clones the repository, and starts the installation.

## Quick Start

```bash
curl -sSL https://raw.githubusercontent.com/RobinMeow/ribyns-pde/main/scripts/setup-fedora.sh | bash
```

The script will:
1. Ensure it is running as root.
2. Prompt you for a username (defaults to `ribyn`).
3. Install base dependencies via `dnf`.
4. Create the user and prompt for a password.
5. Clone the `ribyns-pde` repository into the new user's home directory.
6. Execute the main installation script (`scripts/install.sh`) as that user.

