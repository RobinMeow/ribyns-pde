#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

# Defaults
fps=30
height=1440
quality=80

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	--input)
		INPUT_DIR="$2"
		shift
		;;
	--fps)
		fps="$2"
		shift
		;;
	--height)
		height="$2"
		shift
		;;
	--quality)
		quality="$2"
		shift
		;;
	*)
		error "Unknown parameter: $1"
		exit 1
		;;
	esac
	shift
done

[[ -z "${INPUT_DIR:-}" ]] && {
	error "--input <input-dir/file> is required"
	exit 1
}

PDE="$SCRIPT_DIR/.."

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
