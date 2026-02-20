#!/bin/bash

set -euo pipefail

# Usage:
#   setWallpaper [--sound|--mute] <file>
#   setWallpaper --stop
#
# Examples:
#   setWallpaper ~/Pictures/wall.png
#   setWallpaper --mute ~/Videos/live.webm
#   setWallpaper --sound ~/Videos/live.mp4
#   setWallpaper --stop

sound="mute"
file=""
stop=false

# where to remember the last static wallpaper
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/setWallpaper_last_image"

# ---- args ----
while [[ $# -gt 0 ]]; do
  case "$1" in
  --sound)
    sound="sound"
    shift
    ;;
  --mute)
    sound="mute"
    shift
    ;;
  --stop)
    stop=true
    shift
    ;;
  -h | --help)
    echo "Usage: setWallpaper [--sound|--mute|--stop] <file>"
    exit 0
    ;;
  *)
    file="$1"
    shift
    ;;
  esac
done

# ---- helpers ----
IS_VIDEO="$HOME/.config/bin/helper/isVideo.sh"

IS_IMAGE="$HOME/.config/bin/helper/isImage.sh"

PRETTY_NAME="$HOME/.config/bin/helper/getPrettyName.sh"

VIDEO_THUMB="$HOME/.config/bin/helper/getVidThumbnail.sh"

RESTORE_WALLPAPER="$HOME/.config/bin/helper/restoreLastWallpaper.sh"

# ---- stop mode ----
if $stop; then
  pgrep -x mpvpaper >/dev/null || exit 0

  # stop old live wallpaper if running
  pkill -x mpvpaper 2>/dev/null || true

  if ! ${RESTORE_WALLPAPER}; then
    notify-send -a transient "Live Wallpaper stopped" "No static wallpaper found to restore"
  fi
  exit 0
fi

# ---- validate file for normal mode ----
[[ -n "${file:-}" ]] || {
  echo "Missing <file>. Try: setWallpaper --help"
  exit 1
}
[[ -f "$file" ]] || {
  echo "File not found: $file"
  exit 1
}

# stop old live wallpaper if running (switching modes)
pkill -x mpvpaper 2>/dev/null || true

if ${IS_VIDEO} "$file"; then
  thumb=""
  # get all monitor names (Hyprland)

  echo "Check monitors"
  mapfile -t outputs < <(hyprctl monitors -j | jq -r '.[].name')

  if [[ "${#outputs[@]}" -eq 0 ]]; then
    echo "No monitors found via hyprctl."
    exit 2
  fi

  for mon in "${outputs[@]}"; do
    echo "$mon"
  done

  # pick the monitor that should output the sound
  # - focused monitor if available
  # - otherwise first monitor
  sound_out=""
  echo "Check what monitor should have sound!"
  if [[ "$sound" == "sound" ]]; then
    sound_out="$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name' | head -n1)"
    [[ -n "$sound_out" ]] || sound_out="${outputs[0]}"
  fi

  echo "$sound_out" "has Sound!"
  echo "Applying Live Wallpapers"

  for out in "${outputs[@]}"; do
    if [[ "$sound" == "sound" && "$out" == "$sound_out" ]]; then
      echo "$out"
      mpvpaper -o "loop-file=inf" "$out" "$file" >/dev/null 2>&1 &
      echo "Now has sound!"
    else
      echo "$out"
      mpvpaper -o "loop-file=inf --no-audio" "$out" "$file" >/dev/null 2>&1 &
      echo "Has no sound!"
    fi
  done

  echo "DONE!"

  name="$(${PRETTY_NAME} "$file")"

  thumb="$(${VIDEO_THUMB} "$file" 2>/dev/null || true)"

  if [[ -n "$thumb" && -f "$thumb" ]]; then
    notify-send -a transient -i "$thumb" "Live Wallpaper started" "$name (${sound})"
  else
    notify-send -a transient "Live Wallpaper started" "$name (${sound})"
  fi

  exit 0
fi

if ${IS_IMAGE} "$file"; then

  if ! pgrep -x swww; then
    swww-daemon &
  fi

  name="$(${PRETTY_NAME} "$file")"
  last=""
  [[ -f "$STATE_FILE" ]] && last="$(<"$STATE_FILE")"

  if [[ "$file" == "$last" ]]; then
    notify-send -a transient -i "$file" "No Change" "Same Wallpaper: $name"
    exit 0
  fi

  swww img "$file" --transition-fps 60 --transition-type top
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s' "$file" >"$STATE_FILE"
  notify-send -a transient -i "$file" "Wallpaper changed" "$name"
  echo "$STATE_FILE"
  exit 0
fi

echo "Unknown file type: $file"
exit 3
