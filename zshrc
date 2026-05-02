# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/datetime
_start_time=$EPOCHREALTIME

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
HISTCONTROL=ignoredups

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ -f "$HOME/.p10k.zsh" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME="avit"
fi

zstyle ':omz:update' mode reminder

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    git
    zsh-vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
		# nvm # adds around 120ms. on pc-white from 85ms -> 200+ms avrg.
)

# load zsh-completions not as a standard plugin but manually
# this prevents compinit from being called twice and significantly improves startup time
fpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

export PATH="$PATH:$HOME/ribyns-env/scripts"
export RIBYNS_ENV="$HOME/ribyns-env"

# treeview of all git tracked files (ripgrep respects .gitignore)
alias lstree='eza -1T'
alias nvimconfig='cd $HOME/.config/nvim && nvim'

alias gpl='git pull'

# override the defaults from the omz git plugin:
alias gpf='git push --force-with-lease' # exlude flag: --force-if-includes
alias gl='git log -7 --graph --pretty=format:\"%C(auto)%h%d%Creset %s %C(green)%cn%Creset %C(cyan)(%cr)%Creset\"'
alias gss='git status --short --untracked-files=all'

# shadow ls to use eza instead
alias ls='eza'
# lsdefault :)
alias lsd='eza -1 --group-directories-first --git-ignore'

export PATH="$HOME/.dotnet:$PATH"
# prepend to take preceedence over windows/wsl passthrough paths
export PATH="$PATH:$HOME/.dotnet/tools"

export PATH="$PATH:$HOME/.cargo/bin"

if [[ -d "/home/linuxbrew/" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# nvm node version manager
nvm() {
  unfunction nvm
  [ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"
  nvm "$@"
}

# Then use y instead of yazi to start, and press q to quit, you'll see 
# the CWD changed. Sometimes, you don't want to change, press Q to quit.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

[[ -f "$HOME/.zshrc-local.sh" ]] && source "$HOME/.zshrc-local.sh"

_total_ms=$(printf "%.2f" $(( ($EPOCHREALTIME - _start_time) * 1000 )))
echo ".zshrc startup duration: ${_total_ms}ms"
unset _start_time _total_ms

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
