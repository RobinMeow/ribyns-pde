#!/usr/bin/env bash
source "$PDE/scripts/utils.sh"
assert_pde_vars

source "$PDE/scripts/run_on_distro.sh"

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		yazi chafa ffmpeg 7zip jq poppler fd ripgrep fzf resvg imagemagick glow extra/mediainfo feh file mpv
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
		yazi chafa ffmpeg 7zip jq poppler fd-find ripgrep fzf resvg ImageMagick glow mediainfo feh file mpv
EOF

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
