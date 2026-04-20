# Ribyns Environment

My personalized environment for Arch Linux, Fedora, Neovim, WSL and many other things.

## Arch

`git clone git@github.com:RobinMeow/ribyns-pde.git $HOME/ribyns-pde`

run `~/ribyns-pde/scripts/install.sh --pacman`


## Terminal

### Emulator

using `kitty`

on arch build from source (e.g. `yay wezterm-git`)

install the font commit-mono `yay extra/oft-commit-mono-nerd`
choose the nerd one `otf-commit-mono-nerd`

## Notes on easy to forget keybinds

`CTRL+e` to accept ghost-like zsh-autosuggestions

## WSL

**Wezterm**
Terminal Emulator is `wezterm`. Since kitty is not supported.
The font needs to be installed on windows to be available for wezterm
on windows just go to the [website.org](https://wezterm.org) and download it.

**Neovim**
nvim path `%AppData%/local/nvim`
but Telescope and maybe other features using the Linux ecosystem do not work.

### Scripts

the `scripts` directory is added to the `$PATH`,
and therefore can be invoked using their filename.
e.g. `install.sh --pacman`
