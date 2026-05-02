# export RIBYNS_ENV_LOG_VERBOSE=true
# export RIBYNS_ENV_LOG_INFO=true
# export CODE_COMPANION_DEFAULT_ADAPTER="ollama"
# export CODE_COMPANION_OLLAMA_MODEL="qwen2.5-coder:3b"
alias mpdd='mpd --no-daemon &'
alias book='zathura --mode=fullscreen "$HOME/books/Efficient Linux at the Command Line (Daniel J. Barrett) (Z-Library).pdf"'

# find history (fzf a history cmd and select it for prompt editing and fire it off)
fh() {
	local choice
	choice=$(cut -d';' -f2 "$HISTFILE" | grep '..........' | fzf)
	print -z "$choice"
}
