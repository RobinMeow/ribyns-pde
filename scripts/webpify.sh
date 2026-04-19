#!/usr/bin/env bash
set -euo pipefail

usage() {
	cat <<EOF
Usage: $(basename "$0") [OPTIONS] --input <path>

Converts MP4- to WebP-files.

Options:
  -i, --input <path>     Directory of MP4s or path to a single .mp4 file
  --fps <int>        Frames per second (default: 30)
  --height <int>     Target height in pixels (default: 1440)
  -q, --quality <int>    WebP quality 0-100 (default: 80)
  -h, --help         Show this help message and exit
EOF
	exit 0
}

PDE="${PDE:-$HOME/ribyns-pde}"
source "$PDE/scripts/utils.sh"

# Defaults
fps=30
height=1440
quality=80

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	-i | --input)
		INPUT_DIR="$2"
		shift 2
		;;
	--fps)
		fps="$2"
		shift 2
		;;
	--height)
		height="$2"
		shift 2
		;;
	-q | --quality)
		quality="$2"
		shift 2
		;;
	-h | --help) usage ;;
	*)
		error "Unknown parameter: $1"
		usage
		;;
	esac
done

[[ -z "${INPUT_DIR:-}" ]] && {
	error "--input <input-dir/file> is required"
	usage
}

if [ -d "$INPUT_DIR" ]; then
	# Directory mode: loop through files
	OUTPUT_DIR="$PDE/tmp/$(basename "$INPUT_DIR")"
	FILES=("$INPUT_DIR"/*.mp4)
else
	# Single file mode: just one item
	OUTPUT_DIR="$PDE/tmp"
	FILES=("$INPUT_DIR")
fi

mkdir -p "$OUTPUT_DIR"

for file in "${FILES[@]}"; do
	name=$(basename "$file" .mp4) # strip .mp4 from basename
	info "Processing: $name"

	ffmpeg -i "$file" \
		-vf "fps=$fps,scale=-1:$height:flags=lanczos" \
		-c:v libwebp -q:v "$quality" -loop 0 -an \
		"$OUTPUT_DIR/$name.webp"
done

success "webify-cation done! Output: $OUTPUT_DIR"
