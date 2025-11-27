#!/bin/bash
# $HOME/.config/hypr/configs/scripts/songmeta.sh
# Usage:
#   songmeta.sh title
#   songmeta.sh artist
#   songmeta.sh album

mode="$1"

title=""
artist=""
album=""

# Try getting meta data
if command -v playerctl &>/dev/null && playerctl status &>/dev/null; then
    title=$(playerctl metadata title 2>/dev/null)
    artist=$(playerctl metadata artist 2>/dev/null)
    album=$(playerctl metadata album 2>/dev/null)
fi

# Global fallback
if [[ -z "$title" && -z "$artist" && -z "$album" ]]; then
    title="Music Playing"
    artist="Unknown Source"
    album=""
fi

case "$mode" in
    title)
        # Title or Fallback
        if [[ -n "$title" ]]; then
            echo "$title"
        else
            echo "Music Playing"
        fi
        ;;
    artist)
        # Artist or Fallback
        if [[ -n "$artist" ]]; then
            echo "$artist"
        else
            echo "Unknown Artist"
        fi
        ;;
    album)
        # Only show Album if available
        if [[ -n "$album" ]]; then
            echo "$album"
        fi
        ;;
    *)
        # Default: Title
        echo "${title:-Music Playing}"
        ;;
esac
