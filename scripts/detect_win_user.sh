#!/usr/bin/env bash

PDE="${PDE:-$HOME/ribyns-pde}"

detect_win_user() {
	source "$PDE/scripts/utils.sh"
	local user_dir="/mnt/c/Users"

	# Determine Windows user directory
	if [[ "$OS_TYPE" == "wsl" ]]; then
		# Get all directories in user_dir
		mapfile -t all_dirs < <(find "$user_dir" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" 2>/dev/null)

		local _users=()
		for user in "${all_dirs[@]}"; do
			if [[ "$user" =~ ^(Public|Default.*)$ ]] || [[ "$user" == *"bara"* ]] || [[ "$user" == *"test"* ]]; then
				info "Excluding user: $user"
				continue
			fi
			_users+=("$user")
		done

		if [[ ${#_users[@]} -eq 0 ]]; then
			error "No Windows users found in $user_dir"
			return 1
		elif [[ ${#_users[@]} -eq 1 ]]; then
			WINDOWS_USER="${_users[0]}"
			WINDOWS_HOME="$user_dir/$WINDOWS_USER"
			info "Detected single Windows user: $WINDOWS_USER"
		else
			# this is not yet tested but if the use case arises i'll
			info "Multiple Windows users found:"
			local i=1
			for user in "${_users[@]}"; do
				echo "  $i) $user"
				((i++))
			done

			read -rp "Select user by number: " choice
			while ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#_users[@]})); do
				warn "Invalid choice. Enter a number between 1 and ${#_users[@]}"
				read -rp "Select user by number: " choice
			done
			WINDOWS_USER="${_users[choice - 1]}"
			info "Selected Windows user: $WINDOWS_USER"
		fi
	else
		error "Not a windows environment. Do not call for windows user detection by checking detect_env beforehand"
		exit 1
	fi
}

# Run detection if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	source "$PDE/scripts/detect_env.sh"
	detect_env
	detect_win_user
	verbose "WINDOWS_USER=$WINDOWS_USER"
	verbose "WINDOWS_HOME=$WINDOWS_HOME"
fi
