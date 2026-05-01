#!/bin/bash

# Simple Stopwatch with Lap/Note functionality
# The clock keeps running while you type your note.

# Initialize variables
START_TIME=$(date +%s)
LAST_LAP_TIME=$START_TIME
LAP_COUNT=0
TOTAL_TYPING_TIME=0
LAPS=()

# Terminal colors and formatting
BOLD="\033[1m"
RESET="\033[0m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
GRAY="\033[90m"

# Cleanup function to restore cursor and exit
cleanup() {
	tput cnorm
	local end_time=$(date +%s)
	local total_elapsed=$((end_time - START_TIME))
	local net_time=$((total_elapsed - TOTAL_TYPING_TIME))
	local session_date=$(date +"%Y-%m-%d %H:%M:%S")

	# Prepare Log File
	local log_dir="$HOME/.local/share/ribyns-env/stopwatch"
	mkdir -p "$log_dir"
	local log_file="$log_dir/session_$(date +"%Y-%m-%d_%H-%M-%S").log"

	# Write to Log File (Stripping ANSI colors)
	{
		echo "======================================================================"
		echo " Session: $session_date"
		echo "======================================================================"
		echo "----------------------------------------------------------------------"
		echo " #  | Lap Time | Split Time | Note"
		for lap in "${LAPS[@]}"; do
			echo -e "$lap" | sed 's/\x1b\[[0-9;]*m//g'
		done
		echo "----------------------------------------------------------------------"
		echo "Total Duration:  $(format_time $total_elapsed)"
		echo "Total Typing:    $(format_time $TOTAL_TYPING_TIME)"
		echo "Total Net Time:  $(format_time $net_time)"
	} >"$log_file"

	echo -e "\n${BOLD}Final Summary (Saved to $log_file):${RESET}"
	print_laps
	echo -e "${CYAN}Total Duration:  $(format_time $total_elapsed)${RESET}"
	echo -e "${GRAY}Total Typing:    $(format_time $TOTAL_TYPING_TIME)${RESET}"
	echo -e "${YELLOW}${BOLD}Total Net Time:  $(format_time $net_time)${RESET}"
	exit
}
trap cleanup SIGINT SIGTERM

# Format seconds to HH:MM:SS
format_time() {
	local seconds=$1
	local h=$((seconds / 3600))
	local m=$(((seconds % 3600) / 60))
	local s=$((seconds % 60))
	printf "%02d:%02d:%02d" $h $m $s
}

# Print the lap table
print_laps() {
	echo "----------------------------------------------------------------------"
	echo -e "${BOLD} #  | Lap Time | Split Time | Note${RESET}"
	for lap in "${LAPS[@]}"; do
		echo -e "$lap"
	done
	echo "----------------------------------------------------------------------"
}

# Clear screen and hide cursor
clear
tput civis

# Main Loop
while true; do
	CURRENT_TIME=$(date +%s)
	TOTAL_ELAPSED=$((CURRENT_TIME - START_TIME))

	# UI Header
	tput cup 0 0
	echo -e "${CYAN}======================================================================${RESET}"
	echo -e "   ${BOLD}STOPWATCH: $(format_time $TOTAL_ELAPSED)${RESET}"
	echo -e "${CYAN}======================================================================${RESET}"
	echo -e " [n] Lap/Note  |  [q] Stop & Exit"
	print_laps

	# Check for input: read returns 0 if a key was pressed, >128 on timeout
	if read -t 1 -n 1 -s key; then
		if [[ $key == "q" || $key == "n" ]]; then
			# Both 'n' and 'q' trigger a lap end and note prompt
			NOTE_START_TIME=$(date +%s)

			# Calculate Lap (from last lap/start to keypress)
			READ_LAP_TIME=$((NOTE_START_TIME - LAST_LAP_TIME))
			READ_SPLIT_TIME=$((NOTE_START_TIME - START_TIME))

			tput cnorm
			echo -en "\n ${BOLD}Note for Lap $((LAP_COUNT + 1)) (Exit with q): ${RESET}"
			read note
			tput civis

			# Auto-generate note if empty and exiting
			if [[ -z "$note" && $key == "q" ]]; then
				note="Exit (q)"
			fi

			# Capture time AFTER typing the note
			LAP_END_TIME=$(date +%s)
			TYPING_DURATION=$((LAP_END_TIME - NOTE_START_TIME))
			TYPING_SPLIT_TIME=$((LAP_END_TIME - START_TIME))
			TOTAL_TYPING_TIME=$((TOTAL_TYPING_TIME + TYPING_DURATION))

			# Record the lap (Yellow/Raised)
			((LAP_COUNT++))
			LAP_STR=$(printf "${YELLOW} %-2d | %-8s | %-10s | %s${RESET}" $LAP_COUNT "$(format_time $READ_LAP_TIME)" "$(format_time $READ_SPLIT_TIME)" "$note")
			LAPS+=("$LAP_STR")

			# Record the Note Typing lap (Gray/Faded) - Skip if exiting
			if [[ $key != "q" ]]; then
				TYPING_STR=$(printf "${GRAY}    | %-8s | %-10s | Note Typing${RESET}" "$(format_time $TYPING_DURATION)" "$(format_time $TYPING_SPLIT_TIME)")
				LAPS+=("$TYPING_STR")
			fi
			LAST_LAP_TIME=$LAP_END_TIME

			if [[ $key == "q" ]]; then
				break
			fi
			clear
		fi
	fi
done
cleanup
