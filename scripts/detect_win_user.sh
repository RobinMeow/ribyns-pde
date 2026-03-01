#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"
source "$SCRIPT_DIR/detect_env.sh"

detect_win_user() {
	local user_dir="C:/Users"

	# Determine Windows user directory
	if [[ "$OS_TYPE" == "windows" ]]; then
		# Get all directories in user_dir (excluding Public and Default)
		mapfile -t _users < <(find "$user_dir" -mindepth 1 -maxdepth 1 -type d ! -iname "Public" ! -iname "Default*" -printf "%f\n" 2>/dev/null)

		if [[ ${#_users[@]} -eq 0 ]]; then
			error "No Windows users found in $user_dir"
			return 1
		elif [[ ${#_users[@]} -eq 1 ]]; then
			WINDOWS_USER="${_users[0]}"
			success "Detected single Windows user: $WINDOWS_USER"
		else
			# this is not yet tested but if the use case arises i'll
			info "Multiple Windows users found:"
			local i=1
			for u in "${_users[@]}"; do
				echo "  $i) $u"
				((i++))
			done

			read -rp "Select user by number: " choice
			while ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#_users[@]})); do
				warn "Invalid choice. Enter a number between 1 and ${#_users[@]}"
				read -rp "Select user by number: " choice
			done
			WINDOWS_USER="${_users[choice - 1]}"
			success "Selected Windows user: $WINDOWS_USER"
		fi
	else
		error "Not a windows environment. Do not call for windows user detection by checking detect_env beforehand"
		WINDOWS_USER=""
	fi
}

# Run detection if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	detect_env
	detect_win_user
	echo "WINDOWS_USER=$WINDOWS_USER"
fi
