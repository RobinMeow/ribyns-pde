# Ribyns Personal Development Environment

## Arch

`git clone git@github.com:RobinMeow/ribyns-pde.git $HOME/ribyns-pde`
run `~/ribyns-pde/scripts/install.sh --pacman`

> if executable bits are not set (permission error) run
`bash scripts/set_executable_bit.sh` then run the others scripts.

set `/usr/bin/zsh` as default shell

install .NET stuff and add `~/.dotnet/tools`  to the path variable
because its recommended tho use those to install the csharp-ls
`dotnet tool install --global csharp-ls`
`https://wiki.archlinux.org/title/.NET`

## Terminal

### Emulator

using `kitty`

on arch build from source (e.g. `yay wezterm-git`)
on windows just go to the [website](https://wezterm.org) and download it.

install the font commit-mono `yay extra/oft-commit-mono-nerd`
choose the nerd one `otf-commit-mono-nerd`

## Notes on easy to forget keybinds

`CTRL+e` to accept ghost-like zsh-autosuggestions

## WSL

Terminal Emulator is `wezterm`. Since kitty is not supported.
The font needs to be installed on windows to be available for wezterm

nvim path `%AppData%/local/nvim`
but Telescope and maybe other features using the Linux ecosystem do not work.

## .NET

dotnet (meaning, microslop) is a mess, I use easy-dotnet nvim plugin now, 
which is bloated but works pretty reliably at least.

### Scripts

the `scripts` directory is added to the `$PATH`,
and therefore can be invoked using their filename.
e.g. `install.sh --pacman`
