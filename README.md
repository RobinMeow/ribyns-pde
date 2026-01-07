# Ribyns Personal Development Environment
TODO: lsp should not auto import angulart

## Arch

`pacman -S git curl zsh tmux vi vim nvim unzip base-devel dotnet-runtime dotnet-sdk aspnet-runtime nodejs npm xclip wl-clipboard openssh`

git clone yay and build it from souce

set zsh as default shell

install dotnet stuff and add `~/.dotnet/tools`  to the path variable
because its recommended tho use those to install the csharp-ls
`dotnet tool install --global csharp-ls`
`https://wiki.archlinux.org/title/.NET`

## Terminal

### Emulator

using wezterm. 
on arch build from souce (e.g. `yay wezterm-git`)
on windoof just go to the [website](https://wezterm.org) and download it.

install the font commit-mono `yay otf-commit-mono` choose the nerd one `otf-commit-mono-nerd`

> when on wsl, you your wezterm config needs to be on you windows home path and the font needs to be installed there.

**zsh theme: ohmyzsh**  
install `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

**ohmyzsh plugins**  
zsh-vi-mode `git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode`  
zsh-autosuggestions `git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`  
zsh-syntax-highlighting `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting`  
zsh-completions `git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions`

### tmux

clone these
`git clone https://github.com/catppuccin/tmux ~/.config/tmux/plugins/catppuccin/tmux/`
`git clone https://github.com/tmux-plugins/tmux-cpu ~/.config/tmux/plugins/tmux-cpu`
`git cloen https://github.com/tmux-plugins/tmux-battery ~/.config/tmux/plugins/tmux-battery`
> TODO: maybe someday https://github.com/tmux-plugins/tmux-pain-control

## Notes on easy to forget keybinds

`CTRL+e` will acception zsh-autosuggestions

## Windows + WSL

so far windows has used the same paths, except for nvim, which is located in `%AppData%/local/nvim`
idk colors origin from the 24-colors.sh `https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6`

## dotnet

2. install the roslyn plugin "seblyng/roslyn.nvim"
1. add registreis to mason.nvim `github:mason-org/mason-registry`, `github:Crashdummyy/mason-registry`.
3. add rosyn as ls
see commit hash [dfa3003](https://github.com/RobinMeow/ribyns-pde/commit/dfa3003391d739122cc15adacb96194c2c8909b3)
