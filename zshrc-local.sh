#!/usr/bin/env bash

# export RIBYNS_ENV_LOG_VERBOSE=true
# export RIBYNS_ENV_LOG_INFO=true
# export CODE_COMPANION_DEFAULT_ADAPTER="ollama"
# export CODE_COMPANION_OLLAMA_MODEL="qwen2.5-coder:3b"

# NOTE: Extend CDPATH with annoying to reach sub-dirs
# allows you to cd into the sub-dirs of the added dirs
# export CDPATH="$HOME/Projects:$HOME/Projects/Domain:$CDPATH"
# cd ProjectA (~/Projects/Domain/ProjectA)
# cd Domain (~/Projects/Domain)

# NOTE: example on navigating the filesystem for a specific env more easy using fzf
#
# customerabbr() {
# 	# associative array (apparently scoped to this fn)
# 	declare -A commands=(
# 		[build]="dotnet build /p:NuGetAudit=false -v m"
# 		[cd]="cd \$( (fd --max-depth 1 --type d . ~/customer; fd --max-depth 1 --type d . ~/customer/other-projects) | fzf )"
# 	)
#
# 	if [[ -n "$1" && -n "${commands[$1]}" ]]; then
# 		eval "${commands[$1]}"
# 	else
# 		echo "ribyn: unknown key '$1'"
# 		for k in "${!commands[@]}"; do
# 			echo "  $k"
# 		done
# 		return 1
# 	fi
# }
# # tab completion
# complete -W "build cd" ropa
