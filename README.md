# Ribyns Personal Development Environment
TODO: status line should not show branch and only filename, not the whole path
TODO: better terminal integration. nice would be if i could show the terminal state as a split/pane show/hide as needed
TODO: harpoon
TODO: yazi / fzf / oil some sort of file manager
TODO: zoxide a smarter cd commadn
TODO: auto show the diagnostic window when using diagnostic jump https://github.com/nvim-lua/kickstart.nvim/commit/21d5aabc22ac44fc9404953a0b77944879465dd0
TODO: Keybind for folding methods in csharp with and without namespaces maybe also for ts? or keybinds like vs code, based on indent level
TODO: i get a locale error every now and then. i should re-read the [locales wiki](https://wiki.archlinux.org/title/Locale)

Deferred TODOs: (low benefit)
- nvim restore previous session `:mksession filename.vim` and load with `nvim -S filename.vim`. doesnt work for quick fix list. so a plugin is probably worthline. perfeable one which supports different nvim workspaces
_ consider hand written workspice files in lua. BUt for that I wanna collect more lua experience
- markdown viewer? https://github.com/iamcco/markdown-preview.nvim not sure if i need sth like that


## Arch

git clone ribyns-pde (TODO: move to ribyns-pde.sh and make it curl invokable)
git clone yay and build it from souce (TODO: move to yay.sh)
run `bash pacman.sh` (does not clone)
run `bash install.sh`

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

install the font commit-mono `yay commit-mono` choose the nerd one `otf-commit-mono-nerd`

> when on wsl, you your wezterm config needs to be on you windows home path and the font needs to be installed there.

**zsh theme: ohmyzsh**  
install `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

**ohmyzsh plugins**  
zsh-vi-mode `git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode`  
zsh-autosuggestions `git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`  
zsh-syntax-highlighting `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting`  
zsh-completions `git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions`

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


### Scripts

to be able to use the scripts directly add execution permission by running the setup
`bash ~/ribyns-pde/setup.sh`
now yow can run scripts without invoking bash and if in zsh the script folder is on the path `ng-test.sh`

### WSL Versions

on aralap (2026-02-27)
$ wsl --version
WSL version: 2.6.1.0
Kernel version: 6.6.87.2-1
WSLg version: 1.0.66
MSRDC version: 1.2.6353
Direct3D version: 1.611.1-81528511
DXCore version: 10.0.26100.1-240331-1435.ge-release
Windows version: 10.0.26100.7840
