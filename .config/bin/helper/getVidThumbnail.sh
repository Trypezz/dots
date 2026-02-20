#!/bin/bash

# For Video-Thumbnail
THUMB_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/setWallpaper_thumbs"
mkdir -p "$THUMB_DIR"

video_thumb() {
  local vid="$1"
  # stable name for each file (even if same filename in different directories)
  local key
  key="$(printf '%s' "$vid" | sha256sum | awk '{print $1}')"
  local out="$THUMB_DIR/$key.jpg"

  # only create if not exists or video is new
  if [[ ! -f "$out" || "$vid" -nt "$out" ]]; then
    if command -v ffmpegthumbnailer >/dev/null 2>&1; then
      ffmpegthumbnailer -i "$vid" -o "$out" -s 512 -q 8 >/dev/null 2>&1 || return 1
    elif command -v ffmpeg >/dev/null 2>&1; then
      # Get frame in first second
      ffmpeg -hide_banner -loglevel error -y -ss 1 -i "$vid" -frames:v 1 -vf "scale=512:-1" "$out" || return 1
    else
      return 1
    fi
  fi

  printf '%s' "$out"
}

video_thumb "$1"
