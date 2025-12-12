#!/bin/bash
# $HOME/.config/hypr/configs/scripts/songmeta.sh
# Usage:
#   songmeta.sh title | artist | album

mode="$1"

# If no player -> Nothing to show
if ! command -v playerctl &>/dev/null || ! playerctl status &>/dev/null; then
    exit 0
fi

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
album=$(playerctl metadata album 2>/dev/null)

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
        # Default: Title
        [[ -n "$title" ]] && echo "$title"
        ;;
esac
