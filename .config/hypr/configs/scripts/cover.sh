#!/bin/bash
# $HOME/.config/hypr/configs/scripts/cover.sh

COVER_TMP="/tmp/hyprlock_cover.jpg"
DEFAULT_COVER="♪" # optional Fallback

# Check if playerctl & a Player is running
if command -v playerctl &>/dev/null && playerctl status &>/dev/null; then
    artUrl=$(playerctl metadata mpris:artUrl 2>/dev/null)

    if [[ -n "$artUrl" ]]; then
        # Local File
        if [[ "$artUrl" == file://* ]]; then
            src="${artUrl#file://}"
            [[ -f "$src" ]] && cp "$src" "$COVER_TMP" 2>/dev/null
        # HTTP/HTTPS (ex. Spotify)
        elif [[ "$artUrl" == http://* || "$artUrl" == https://* ]]; then
            if command -v curl &>/dev/null; then
                curl -L -s "$artUrl" -o "$COVER_TMP" >/dev/null 2>&1
            elif command -v wget &>/dev/null; then
                wget -q "$artUrl" -O "$COVER_TMP"
            fi
        fi
    fi
fi

# Fallback-Pic
if [[ ! -f "$COVER_TMP" && -f "$DEFAULT_COVER" ]]; then
    cp "$DEFAULT_COVER" "$COVER_TMP"
fi

# Hyprlock needs real path
if [[ -f "$COVER_TMP" ]]; then
    realpath "$COVER_TMP"
fi
