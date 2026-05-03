# Ribyns Environment

My personalized environment for Arch Linux, Fedora, Neovim, WSL and many other things.

![gource](./gource.png)

## Arch

`git clone ssh://git@codeberg.com:Ribyn/ribyns-env.git $HOME/ribyns-env`

if zsh is not yet synced, ake sure to export the `RIBYNS_ENV` environment variable before running any scripts:
`export RIBYNS_ENV="$HOME/ribyns-env"`

> if zsh is already installed, .zshrc exports this variable

Run the install script:
`~/ribyns-env/scripts/install.sh --pacman`


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

### MonkeyType 

100% acc
![monkeytype](./monkey.png)

<100% acc
![monkeytype](./monkey-fastest-with-errors.png)

