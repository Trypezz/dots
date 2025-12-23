#!/bin/bash
# $HOME/.config/hypr/configs/scripts/cover.sh

COVER_TMP="/tmp/hyprlock_cover.jpg"
PLAYER="${1:-spotify}"

# If playerctl is missing or Spotify is not available -> remove cover and exit
if ! command -v playerctl &>/dev/null || ! playerctl -p "$PLAYER" status &>/dev/null; then
    rm -f "$COVER_TMP"
    exit 0
fi

artUrl=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)

# If no art URL -> remove cover and exit
if [[ -z "$artUrl" ]]; then
    rm -f "$COVER_TMP"
    exit 0
fi

# Local file
if [[ "$artUrl" == file://* ]]; then
    src="${artUrl#file://}"
    if [[ -f "$src" ]]; then
        cp "$src" "$COVER_TMP"
        echo "$COVER_TMP"
        exit 0
    else
        rm -f "$COVER_TMP"
        exit 0
    fi
fi

# HTTP/HTTPS (e.g. Spotify)
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

# If something fails -> do not show cover
rm -f "$COVER_TMP"
exit 0
