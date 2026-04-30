#!/usr/bin/env bash

# Catppuccin Mocha 8-bit Color Palette
# https://github.com/catppuccin/catppuccin
# These are approximations of the Catppuccin Mocha theme using 8-bit colors
CATSURFACE0="\033[38;5;235m" # #313244 - Very dark gray (backgrounds)
CATSURFACE1="\033[38;5;239m" # #45475a - Dark gray
CATSURFACE2="\033[38;5;243m" # #585b70 - Medium dark gray
CATOVERLAY0="\033[38;5;246m" # #6c7086 - Medium gray
CATOVERLAY1="\033[38;5;248m" # #7f849c - Light gray
CATOVERLAY2="\033[38;5;250m" # #9399b2 - Lighter gray
CATTEXT="\033[38;5;231m"     # #cdd6f4 - Light text
CATSUBTEXT1="\033[38;5;188m" # #bac2de - Subtext (lighter)
CATSUBTEXT0="\033[38;5;246m" # #a6adc8 - Subtext (darker)
CATRED="\033[38;5;203m"      # #f38ba8 - Red/Error
CATORANGE="\033[38;5;215m"   # #fab387 - Orange/Warning
CATYELLOW="\033[38;5;221m"   # #f9e2af - Yellow
CATGREEN="\033[38;5;114m"    # #a6e3a1 - Green/Success
CATCYAN="\033[38;5;115m"     # #94e2d5 - Cyan
CATBLUE="\033[38;5;109m"     # #89b4fa - Blue/Info
CATMAGENTA="\033[38;5;139m"  # #cba6f7 - Magenta/Verbose
CATLAVENDER="\033[38;5;183m" # #b4befe - Lavender
NC="\033[0m"                 # No Color

# Backward compatibility aliases (using Catppuccin colors now)
RED="${CATRED}"
YELLOW="${CATORANGE}"
GREEN="${CATGREEN}"
BLUE="${CATBLUE}"
GRAY="${CATOVERLAY1}"

error() {
	echo -e "${CATRED}[ERROR]${NC} $*"
}

warn() {
	echo -e "${CATORANGE}[WARN]${NC} $*"
}

success() {
	echo -e "${CATGREEN}[SUCCESS]${NC} $*"
}

info() {
	if [[ "${RIBYNS_ENV_LOG_INFO:-false}" =~ ^(true|1|yes)$ ]]; then
		echo -e "${CATBLUE}[INFO]${NC} $*"
	fi
}

verbose() {
	if [[ "${RIBYNS_ENV_LOG_VERBOSE:-false}" =~ ^(true|1|yes)$ ]]; then
		echo -e "${CATSURFACE2}[VERBOSE]${NC} $*"
	fi
}

# Color echo functions
echo_surface0() {
	echo -e "${CATSURFACE0}$*${NC}"
}

echo_surface1() {
	echo -e "${CATSURFACE1}$*${NC}"
}

echo_surface2() {
	echo -e "${CATSURFACE2}$*${NC}"
}

echo_overlay0() {
	echo -e "${CATOVERLAY0}$*${NC}"
}

echo_overlay1() {
	echo -e "${CATOVERLAY1}$*${NC}"
}

echo_overlay2() {
	echo -e "${CATOVERLAY2}$*${NC}"
}

echo_text() {
	echo -e "${CATTEXT}$*${NC}"
}

echo_subtext1() {
	echo -e "${CATSUBTEXT1}$*${NC}"
}

echo_subtext0() {
	echo -e "${CATSUBTEXT0}$*${NC}"
}

echo_red() {
	echo -e "${CATRED}$*${NC}"
}

echo_orange() {
	echo -e "${CATORANGE}$*${NC}"
}

echo_yellow() {
	echo -e "${CATYELLOW}$*${NC}"
}

echo_green() {
	echo -e "${CATGREEN}$*${NC}"
}

echo_cyan() {
	echo -e "${CATCYAN}$*${NC}"
}

echo_blue() {
	echo -e "${CATBLUE}$*${NC}"
}

echo_magenta() {
	echo -e "${CATMAGENTA}$*${NC}"
}

echo_lavender() {
	echo -e "${CATLAVENDER}$*${NC}"
}

# Usage/Help function
usage() {
	cat <<'EOF'
utils.sh - Catppuccin Mocha color utilities for bash scripts

Color Variables:
  CATSURFACE0, CATSURFACE1, CATSURFACE2  - Background colors
  CATOVERLAY0, CATOVERLAY1, CATOVERLAY2  - Overlay colors
  CATTEXT, CATSUBTEXT0, CATSUBTEXT1      - Text colors
  CATRED, CATORANGE, CATYELLOW           - Warm accent colors
  CATGREEN, CATCYAN, CATBLUE             - Cool accent colors
  CATMAGENTA, CATLAVENDER                - Purple accent colors
  NC                                     - No Color (reset)

Logging Functions:
  error <message>        - Print error message (red)
  warn <message>         - Print warning message (orange)
  success <message>      - Print success message (green)
  info <message>         - Print info message (blue, if RIBYNS_ENV_LOG_INFO=true|1|yes)
  verbose <message>      - Print verbose message (magenta, if RIBYNS_ENV_LOG_VERBOSE=true|1|yes)

Color Echo Functions:
  echo_surface0 <text>   - Echo with surface0 color
  echo_surface1 <text>   - Echo with surface1 color
  echo_surface2 <text>   - Echo with surface2 color
  echo_overlay0 <text>   - Echo with overlay0 color
  echo_overlay1 <text>   - Echo with overlay1 color
  echo_overlay2 <text>   - Echo with overlay2 color
  echo_text <text>       - Echo with text color
  echo_subtext0 <text>   - Echo with subtext0 color
  echo_subtext1 <text>   - Echo with subtext1 color
  echo_red <text>        - Echo with red color
  echo_orange <text>     - Echo with orange color
  echo_yellow <text>     - Echo with yellow color
  echo_green <text>      - Echo with green color
  echo_cyan <text>       - Echo with cyan color
  echo_blue <text>       - Echo with blue color
  echo_magenta <text>    - Echo with magenta color
  echo_lavender <text>   - Echo with lavender color

Environment Variables:
  RIBYNS_ENV_LOG_INFO=true|1|yes         - Enable info() output
  RIBYNS_ENV_LOG_VERBOSE=true|1|yes      - Enable verbose() output

Examples:
  source utils.sh
  info "Starting process"
  error "Something went wrong"
  echo_green "Success!"
EOF
}

# Handle --help flag when script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	case "${1:-}" in
	--help | -h)
		usage
		;;
	*)
		usage
		;;
	esac
fi
