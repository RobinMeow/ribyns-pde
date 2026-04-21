#!/usr/bin/env bash

# NOTE: image, audio, video, subtitle and many media files using ffmpeg and mediainfo metainfo
dest_mediainfo="$HOME/.config/yazi/plugins/mediainfo.yazi"
sudo pacman -S --needed --noconfirm \
	yazi \
	chafa \
	ffmpeg \
	7zip \
	jq \
	poppler \
	fd \
	ripgrep \
	fzf \
	resvg \
	imagemagick \
	glow \
	extra/mediainfo \
	feh \
	file \
	mpv

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
