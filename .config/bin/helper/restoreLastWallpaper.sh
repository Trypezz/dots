#!/bin/bash

# where to remember the last static wallpaper
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/setWallpaper_last_image"

# fallback if no last image is known (optional)
DEFAULT_WALLPAPER="$HOME/Pictures/Wallpaper/background/linux/archlinux.png"

# Helper
PRETTY_NAME="$HOME/.config/bin/helper/getPrettyName.sh"

restore_last_image() {
  local img=""

  if [[ -f "$STATE_FILE" ]]; then
    img="$(<"$STATE_FILE")"
  fi

  # If cache empty or file missing -> fallback to default
  if [[ -z "${img:-}" || ! -f "$img" ]]; then
    if [[ -f "$DEFAULT_WALLPAPER" ]]; then
      img="$DEFAULT_WALLPAPER"
    else
      return 1
    fi
  fi

  name="$(${PRETTY_NAME} "$img")"

  swww img "$img" --transition-fps 60 --transition-type top
  notify-send -a transient -i "$img" "Live Wallpaper stopped" "Restored: "$name""
  echo "$STATE_FILE"
  return 0
}

restore_last_image
