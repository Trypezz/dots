#!/bin/bash
set -euo pipefail

themes_dir="$HOME/.config/themes"
rofi="$HOME/.config/rofi/launcher.sh"
mode="dmenu"
menu="menus/theme-menu"
change_theme="$HOME/.config/bin/changeTheme"

if [[ ! -d "$themes_dir" ]]; then
  echo "Themes directory not found: $themes_dir" >&2
  exit 1
fi

if [[ ! -x "$change_theme" ]]; then
  echo "changeTheme script not found or not executable: $change_theme" >&2
  exit 1
fi

mapfile -t themes < <(find "$themes_dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

if ((${#themes[@]} == 0)); then
  echo "No themes found in $themes_dir" >&2
  exit 1
fi

choice="$(printf '%s\n' "${themes[@]}" | "${rofi}" "${mode}" "${menu}")"

[[ -z "$choice" ]] && exit 0
"$change_theme" "$choice"
