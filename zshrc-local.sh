# export RIBYNS_ENV_LOG_VERBOSE=true
# export RIBYNS_ENV_LOG_INFO=true
# export CODE_COMPANION_DEFAULT_ADAPTER="ollama"
# export CODE_COMPANION_OLLAMA_MODEL="qwen2.5-coder:3b"
alias mpdd='mpd --no-daemon &'
alias book='zathura --mode=fullscreen "$HOME/books/Efficient Linux at the Command Line (Daniel J. Barrett) (Z-Library).pdf"'

# find history (fzf a history cmd and select it for prompt editing and fire it off)
fh() {
	local choice
	choice=$(cut -d';' -f2 "$HISTFILE" | sort -u | uniq | grep '..........' | fzf)
	print -z "$choice"
}

# example for creating many aliases without worrying about conflicts or pollution or long startuptime:
ribyn() {
	# associative array (scoped to this fn)
	declare -A temp_dirs=(
		[env]="$HOME/ribyns-env/"
		[state]="$HOME/ribyns-state/"
	)

	# Use the associative array to perform the "cd" operation
	if [[ -n "$1" && -n "${temp_dirs[$1]}" ]]; then
		cd "${temp_dirs[$1]}" || return 1
	else
		echo "ribyn: unknown key '$1'"
		# echo "Available keys: ${(k)temp_dirs}" NOTE: this is zsh syntax and bashls doesnt like it
		for k in "${!temp_dirs[@]}"; do
			echo "  $k"
		done
		return 1
	fi
}
# tab completion
complete -W "env state" ribyn

# NOTE: Extend CDPATH with annoying to reach sub-dirs
# allows you to cd into the sub-dirs of the added dirs
# export CDPATH="$HOME/Projects:$HOME/Projects/Domain:$CDPATH"
# cd ProjectA (~/Projects/Domain/ProjectA)
# cd Domain (~/Projects/Domain)
