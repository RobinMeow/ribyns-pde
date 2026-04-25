#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/run_on_distro.sh"

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
    chafa ffmpeg 7zip jq poppler fd ripgrep fzf resvg imagemagick extra/mediainfo feh file mpv
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
    chafa ffmpeg 7zip jq poppler fd-find ripgrep fzf resvg ImageMagick mediainfo feh file mpv
EOF

"$PDE/scripts/ensure-homebrew-installed.sh"
# NOTE: optional dependencies, tho i got em all using dnf/pacman (excluding zoxide i dont use that)
# brew install ffmpeg-full sevenzip jq poppler fd ripgrep fzf resvg imagemagick-full
# brew link ffmpeg-full imagemagick-full -f --overwrite
brew install yazi

# NOTE: image, audio, video, subtitle and many media files using ffmpeg and mediainfo metainfo
dest_mediainfo="$HOME/.config/yazi/plugins/mediainfo.yazi"

if [[ ! -d $dest_mediainfo ]]; then
	# install
	mkdir -p "$dest_mediainfo"
	git clone https://github.com/boydaihungst/mediainfo.yazi "$dest_mediainfo"
else
	# update
	git -C "$dest_mediainfo" pull
fi

mkdir -p "$HOME/.config/yazi"
cp -r "$PDE/.config/yazi/"* "$HOME/.config/yazi/"
