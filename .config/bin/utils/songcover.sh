#!/bin/bash

# Usage:
#   songcover.sh [player]

COVER_TMP="/tmp/songcover.jpg"
GET_PLAYER="$HOME/.config/bin/utils/getCurrentPlayer.sh"

# Parse the argument player
PLAYER="${1:-}"
if [[ -z "$PLAYER" ]]; then
  PLAYER="$("$GET_PLAYER")"
fi

clear_cover() {
  rm -f "$COVER_TMP"
  exit 0
}

# Deletes the cover file if the player is not the defined ones
if [[ ! "$PLAYER" =~ ^(kew|spotify|spotifast)(\.|$) ]]; then
  clear_cover
fi

if ! command -v playerctl &>/dev/null || ! playerctl -p "$PLAYER" status &>/dev/null; then
  clear_cover
fi

# Clears cover if the status is neither Playing or Paused
status="$(playerctl -p "$PLAYER" status 2>/dev/null || true)"
if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
  clear_cover
fi

# Fetch the cover (Thumbnail)
artUrl=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)

if [[ -z "$artUrl" ]]; then
  clear_cover
fi

# Get cover image from file
# and set it
if [[ "$artUrl" == file://* ]]; then
  src="${artUrl#file://}"
  if [[ -f "$src" ]]; then
    cp "$src" "$COVER_TMP"
    echo "$COVER_TMP"
    exit 0
  fi
  clear_cover
fi

# Get cover Image from link (Spotify)
# and set it
if [[ "$artUrl" == http://* || "$artUrl" == https://* ]]; then
  if command -v curl &>/dev/null; then
    if curl -L -s "$artUrl" -o "$COVER_TMP"; then
      echo "$COVER_TMP"
      exit 0
    fi
  elif command -v wget &>/dev/null; then
    if wget -q "$artUrl" -O "$COVER_TMP"; then
      echo "$COVER_TMP"
      exit 0
    fi
  fi
fi

clear_cover
