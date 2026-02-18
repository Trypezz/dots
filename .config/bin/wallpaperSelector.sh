#!/bin/bash

set -euo pipefail

rofi="$HOME/.config/rofi/launcher.sh"
mode="dmenu"
menu="menus/dialog"
rofi_theme="$HOME/.config/rofi/menus/wallpaper-grid.rasi"

# Directories to scan (edit as needed)
WALL_DIRS=(
  "$HOME/Pictures/Wallpaper/"
  "$HOME/Videos/LiveWallpapers/"
)

SET_WALLPAPER="$HOME/.config/bin/setWallpaper"

# Thumbnail cache (matches setWallpaper)
THUMB_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/setWallpaper_thumbs"
mkdir -p "$THUMB_DIR"

is_video() {
  local f="${1,,}"
  case "$f" in
  *.mp4 | *.mkv | *.webm | *.mov | *.avi | *.m4v) return 0 ;;
  *) return 1 ;;
  esac
}

video_thumb() {
  local vid="$1"
  local key out
  key="$(printf '%s' "$vid" | sha256sum | awk '{print $1}')"
  out="$THUMB_DIR/$key.jpg"

  if [[ ! -f "$out" || "$vid" -nt "$out" ]]; then
    if command -v ffmpegthumbnailer >/dev/null 2>&1; then
      ffmpegthumbnailer -i "$vid" -o "$out" -s 512 -q 8 >/dev/null 2>&1 || return 1
    elif command -v ffmpeg >/dev/null 2>&1; then
      ffmpeg -hide_banner -loglevel error -y -ss 1 -i "$vid" -frames:v 1 -vf "scale=512:-1" "$out" || return 1
    else
      return 1
    fi
  fi

  printf '%s' "$out"
}

# Collect files
files=()
for dir in "${WALL_DIRS[@]}"; do
  [[ -d "$dir" ]] || continue
  while IFS= read -r -d '' f; do
    files+=("$f")
  done < <(
    find "$dir" -type f \( \
      -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.tiff' -o \
      -iname '*.mp4' -o -iname '*.mkv' -o -iname '*.webm' -o -iname '*.mov' -o -iname '*.avi' -o -iname '*.m4v' -o -iname '*.gif' \
      \) -print0
  )
done

if [[ "${#files[@]}" -eq 0 ]]; then
  notify-send -a transient "Wallpaper" "No wallpapers found"
  exit 1
fi

# Build menu and get selection index
idx="$(
  for f in "${files[@]}"; do
    name="$(basename -- "$f")"
    icon=""
    if is_video "$f"; then
      icon="$(video_thumb "$f" 2>/dev/null || true)"
    else
      icon="$f"
    fi

    if [[ -n "$icon" && -f "$icon" ]]; then
      printf '%s\x00icon\x1f%s\n' "$name" "$icon"
    else
      printf '%s\n' "$name"
    fi
  done | rofi -dmenu -i -p "" -show-icons -format i -theme "$rofi_theme"
)"

[[ -n "${idx:-}" ]] || exit 0

sel="${files[$idx]}"

# sel ist der gewählte Pfad
sound_arg="--mute"

if is_video "$sel"; then
  choice="$(
    printf "No\nYes\n" | rofi -dmenu -p "Play sound?" -mesg "Video detected" -selected-row 0 -theme ${menu}
  )" || exit 0

  if [[ "$choice" == "Yes" ]]; then
    sound_arg="--sound"
  fi
fi

if [[ ! -x "$SET_WALLPAPER" ]]; then
  notify-send -a transient "Wallpaper" "setWallpaper not found or not executable"
  exit 2
fi

echo "$SET_WALLPAPER" "$sel" "$sound_arg"

"$SET_WALLPAPER" "$sel" "$sound_arg"
