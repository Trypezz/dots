#!/bin/bash

SONGMETA="$HOME/.config/bin/utils/songmeta.sh"
COVER="$HOME/.config/bin/utils/songcover.sh"
GET_PLAYER="$HOME/.config/bin/utils/getCurrentPlayer.sh"

last_track=""

# Listening to events of playerctl
playerctl --follow metadata --format '{{playerName}}|||{{artist}}|||{{title}}' 2>/dev/null |
  while IFS='|||' read -r player artist title; do

    # Skipping empty events
    [[ -z "$artist" && -z "$title" ]] && continue

    # Only continue if players are kew or spotify
    if [[ ! "$player" =~ ^(kew|spotify)(\.|$) ]]; then
      continue
    fi

    track="$artist - $title"
    [[ "$track" == "$last_track" ]] && continue
    last_track="$track"

    # Gathering metadata
    artist="$("$SONGMETA" artist "$player")"
    title="$("$SONGMETA" title "$player")"
    album="$("$SONGMETA" album "$player")"

    # Getting cover
    cover_path="$("$COVER" "$player")"

    body="$artist"
    [[ -n "$album" ]] && body="$body"$'\n'"$album"

    if [[ -n "$cover_path" && -f "$cover_path" ]]; then
      notify-send -a transient -i "$cover_path" "$title" "$body"
    else
      notify-send -a transient "$title" "$body"
    fi

  done
