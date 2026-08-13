#!/bin/bash

# Usage:
#   songmeta.sh title|artist|album [player]
#
# Examples:
#   songmeta.sh title spotify
#   songmeta.sh artist spotify

GET_PLAYER="$HOME/.config/bin/utils/getCurrentPlayer.sh"

mode="$1"
PLAYER="$("$GET_PLAYER")"

if [[ ! "$PLAYER" =~ ^(kew|spotify)(\.|$) ]]; then
  exit 0
fi

# If playerctl is missing or Player is not available -> nothing to show
if ! command -v playerctl &>/dev/null || ! playerctl -p "$PLAYER" status &>/dev/null; then
  exit 0
fi

title=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)
artist=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)
album=$(playerctl -p "$PLAYER" metadata album 2>/dev/null)

# If no info then don't show anything
if [[ -z "$title" && -z "$artist" && -z "$album" ]]; then
  exit 0
fi

case "$mode" in
title)
  if [[ -n "$title" ]]; then
    echo "$title"
  else
    # Fallback if player detected something
    echo "Unknown Title"
  fi
  ;;
artist)
  if [[ -n "$artist" ]]; then
    echo "$artist"
  else
    echo "Unknown Artist"
  fi
  ;;
album)
  # Show album if available
  if [[ -n "$album" ]]; then
    echo "$album"
  fi
  ;;
*)
  # Default: title
  [[ -n "$title" ]] && echo "$title"
  ;;
esac
