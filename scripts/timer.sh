#!/bin/bash

# Function to play a soft alert (terminal bell)
play_alarm() {
	while true; do
		# echo -e "\a" # System bell
		ffplay -volume 25 -nodisp -autoexit -loglevel quiet "$PDE/sounds/tuturu.mp3"
		sleep 1
	done
}

# Function to format time as MM:SS
format_time() {
	printf "%02d:%02d" $(($1 / 60)) $(($1 % 60))
}

# Default values
TOTAL_SECONDS=0

# Parse arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	-m | --minutes)
		TOTAL_SECONDS=$((TOTAL_SECONDS + $2 * 60))
		shift
		;;
	-s | --seconds)
		TOTAL_SECONDS=$((TOTAL_SECONDS + $2))
		shift
		;;
	*)
		echo "Unknown parameter: $1"
		exit 1
		;;
	esac
	shift
done

# --- Interactive TUI Mode ---
if [ $TOTAL_SECONDS -eq 0 ]; then
	clear
	while true; do
		tput cup 0 0
		echo "=== TIMER SETUP ==="
		echo "Current Time: $(format_time $TOTAL_SECONDS)"
		echo "-------------------"
		echo "m) +1 Minute"
		echo "s) +10 Seconds"
		echo "r) Reset"
		echo "Enter) START"
		echo "q) Quit"

		read -rsn1 input
		case $input in
		m) TOTAL_SECONDS=$((TOTAL_SECONDS + 60)) ;;
		s) TOTAL_SECONDS=$((TOTAL_SECONDS + 10)) ;;
		r) TOTAL_SECONDS=0 ;;
		"") [[ $TOTAL_SECONDS -gt 0 ]] && break ;;
		q) exit 0 ;;
		esac
	done
fi

# --- Countdown Logic ---
clear
# Hide cursor
tput civis

# Trap Ctrl+C to restore cursor and exit
trap 'tput cnorm; echo -e "\nStopped."; exit' SIGINT

while [ $TOTAL_SECONDS -gt 0 ]; do
	tput cup 0 0
	echo "Time remaining: $(format_time $TOTAL_SECONDS)"
	sleep 1
	: $((TOTAL_SECONDS--))
done

# --- Alarm Logic ---
tput cup 0 0
echo "TIME IS UP! (Press Ctrl+C to stop)"
play_alarm
