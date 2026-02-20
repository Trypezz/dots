#!/bin/bash

STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/setWallpaper_last_image"

GET_SYSTEM_THEME="$HOME/.config/bin/helper/getSystemTheme.sh"
RELOAD_DESKTOP="$HOME/.config/bin/helper/reloadDesktop.sh"

apply_theme() {
  local requested="$1"
  local themes_dir="$HOME/.config/themes"
  local env_file="$HOME/.config/zsh/env.sh"
  local wallpaper_dir="$HOME/.config/themes/$requested/wallpaper"
  local wallpaper=$(find "$wallpaper_dir" -type f | head -n1)

  # ---- basic checks ----
  if [[ -z "$requested" ]]; then
    echo "Usage: apply_theme <theme>" >&2
    return 2
  fi

  local current
  current="$(${GET_SYSTEM_THEME} || true)"

  if [[ -n "$current" && "$current" == "$requested" ]]; then
    echo "Theme '$requested' is already active. Nothing to do."
    notify-send -a transient "Theme already active." "Theme: $requested"
    return 0
  fi

  if [[ ! -d "$themes_dir" ]]; then
    echo "Error: themes directory not found: $themes_dir" >&2
    return 1
  fi

  if [[ ! -d "$themes_dir/$requested" ]]; then
    echo "Error: theme '$requested' does not exist in $themes_dir" >&2
    return 1
  fi

  # ---- mapping: source -> destination ----
  # These are the "selector" files that contain @import/source custom/<theme>...
  local -a MAP=(
    "$themes_dir/$requested/hypr/colors.conf::$HOME/.config/hypr/colors/colors.conf"
    "$themes_dir/$requested/rofi/colors.rasi::$HOME/.config/rofi/colors/colors.rasi"
    "$themes_dir/$requested/waybar/colors.css::$HOME/.config/waybar/colors/colors.css"
    "$themes_dir/$requested/swaync/colors.css::$HOME/.config/swaync/colors/colors.css"
    "$themes_dir/$requested/wlogout/colors.css::$HOME/.config/wlogout/colors/colors.css"
    "$themes_dir/$requested/yazi/theme.toml::$HOME/.config/yazi/theme.toml"
  )

  # ---- preflight integrity ----
  local missing=0
  local src dest

  for pair in "${MAP[@]}"; do
    src="${pair%%::*}"
    dest="${pair##*::}"

    if [[ ! -f "$src" ]]; then
      echo "Preflight FAIL: missing source: $src" >&2
      missing=1
      continue
    fi

    # Ensure destination directory exists
    if [[ ! -d "$(dirname "$dest")" ]]; then
      echo "Preflight FAIL: dest dir missing: $(dirname "$dest")" >&2
      missing=1
      continue
    fi

    # Check writability of dest dir (we replace via mv)
    if [[ ! -w "$(dirname "$dest")" ]]; then
      echo "Preflight FAIL: dest dir not writable: $(dirname "$dest")" >&2
      missing=1
      continue
    fi
  done

  if ((missing)); then
    echo "Aborting: preflight integrity failed." >&2
    return 1
  fi

  # ---- copy atomically + post-verify per file ----
  local tmp
  for pair in "${MAP[@]}"; do
    src="${pair%%::*}"
    dest="${pair##*::}"

    tmp="$(mktemp --tmpdir="$(dirname "$dest")" ".theme_apply.XXXXXX")" || {
      echo "Error: could not create temp file in $(dirname "$dest")" >&2
      return 1
    }

    # copy -> tmp
    if ! cp -f -- "$src" "$tmp"; then
      echo "Copy FAIL: $src -> $tmp" >&2
      rm -f -- "$tmp"
      return 1
    fi

    # move tmp -> dest (atomic on same filesystem)
    if ! mv -f -- "$tmp" "$dest"; then
      echo "Move FAIL: $tmp -> $dest" >&2
      rm -f -- "$tmp"
      return 1
    fi

    # verify bit-identical
    if ! cmp -s -- "$src" "$dest"; then
      echo "Verify FAIL: destination differs: $dest" >&2
      return 1
    fi
  done

  # ---- update env file (only SYSTEM_THEME line, keep rest, put on top) ----
  mkdir -p "$(dirname "$env_file")"
  touch "$env_file"

  local key="SYSTEM_THEME"
  local val="$requested"
  local tmpenv
  tmpenv="$(mktemp)" || return 1

  # remove old SYSTEM_THEME lines
  grep -vE "^(export[[:space:]]+)?${key}=" "$env_file" >"$tmpenv" || true

  {
    printf 'export %s=%q\n' "$key" "$val"
    cat "$tmpenv"
  } >"$env_file"
  rm -f -- "$tmpenv"

  ${RELOAD_DESKTOP}

  swww img "$wallpaper" --transition-fps 60 --transition-type grow

  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s' "$wallpaper" >"$STATE_FILE"

  echo "Theme applied successfully: $requested"
  notify-send -a transient "Theme applied successfully!" "Theme: $requested"
}

apply_theme "$1"
