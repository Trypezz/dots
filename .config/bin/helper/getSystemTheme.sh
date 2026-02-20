#!/bin/bash

get_current_theme() {
  local env_file="$HOME/.config/zsh/env.sh"
  [[ -f "$env_file" ]] || return 1

  # get export SYSTEM_THEME=xyz
  sed -nE 's/^(export[[:space:]]+)?SYSTEM_THEME=//p' "$env_file" | head -n1
}

get_current_theme
