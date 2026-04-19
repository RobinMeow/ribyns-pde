# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- BENCHMARK START ---
# TODO: extract benchmarking into a util file
# Set to: "quiet" | "info" | "verbose"
ZSH_STARTUP_MODE="info"
zmodload zsh/datetime
_start_time=$EPOCHREALTIME
_last_time=$_start_time

_benchmark() {
	[[ "$ZSH_STARTUP_MODE" != "verbose" ]] && return
	local now=$EPOCHREALTIME
	local elapsed=$(printf "%.1fs" $(( now - _start_time )))
	local diff=$(printf "%.1fs" $(( now - _last_time )))
	echo "⏱️  $1: ${elapsed} (+${diff})"
	_last_time=$now
}
# --- END BENCHMARK START ---

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# source .local/bin/env some apps are installed there (e.g. copilot_cli and claude)
if [[ -f "$HOME/.local/bin/env" ]] . "$HOME/.local/bin/env"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ -f "$HOME/.p10k.zsh" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME="avit"
fi

zstyle ':omz:update' mode reminder

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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
_benchmark "Before Completions/Compinit"

# load zsh-completions not as a standard plugin but manually
# this prevents compinit from being called twice and significantly improves startup time
fpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
_benchmark "Completions/Compinit"

source $ZSH/oh-my-zsh.sh
_benchmark "source oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

if [[ -d "$HOME/ribyns-pde" ]]; then
  export PDE="$HOME/ribyns-pde"
else
  YELLOW="\033[1;33m"
	echo -e "${YELLOW}[WARN] $*${NC}"
fi

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Self defined aliases
# treeview of all git tracked files (ripgrep respects .gitignore)
alias rgtree='rg --files | tree --fromfile'
alias nvimconfig='cd ~/.config/nvim && nvim'
alias ribyns-pde='cd ~/ribyns-pde'
#
alias gpl='git pull'
#
# override the defaults from the git plugin:
alias gpf='git push --force-with-lease' # exlude flag: --force-if-includes
alias gl='git l' # reference my global .gitconfig alias

# Add .dotnet/dotnet to PATH if not already present.
# local script installs should take preceedence over the normal arch install
case ":$PATH:" in
  *":$HOME/.dotnet:"*) ;;
	# needs to pre-prended to take precedence over other installs
  *) PATH="$HOME/.dotnet:$PATH" ;; 
esac

# Add .dotnet/tools to PATH if not already present
case ":$PATH:" in
  *":$HOME/.dotnet/tools:"*) ;;
  *) PATH="$PATH:$HOME/.dotnet/tools" ;;
esac

# TODO: should be okay to just append without checking
# Add ribyns-pde/scripts to PATH if not already present
case ":$PATH:" in
  *":$HOME/ribyns-pde/scripts:"*) ;;
  *) PATH="$PATH:$HOME/ribyns-pde/scripts" ;;
esac
_benchmark "add dotnet and ribyns-pde scripts to PATH"

# nvm node version manager
nvm() {
  unfunction nvm
  [ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"
  nvm "$@"
}
_benchmark "source init-nvm.sh (Node Version Manager)"

# Then use y instead of yazi to start, and press q to quit, you'll see 
# the CWD changed. Sometimes, you don't want to change, press Q to quit.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export PATH

_benchmark "setup yazi"

# TODO: rename .zshrc-local.sh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# --- FINAL TOTAL ---
if [[ "$ZSH_STARTUP_MODE" != "quiet" ]]; then
	_total_ms=$(printf "%.2f" $(( ($EPOCHREALTIME - _start_time) * 1000 )))
	echo "✅ ZSH Startup Complete: ${_total_ms}ms"
fi
unset -f _benchmark
unset _start_time _last_time _total_ms

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
