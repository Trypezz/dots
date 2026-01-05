#!/usr/bin/env bash
set -u

PLAYER="${1:-spotify}"
VISIBLE_MIN=10
TICK="${TICK}" # Update (Needs to be set in Waybar Modules)
STEP="${STEP}" # Speed (Needs to be set in Waybar Modules)

SCROLL_FILE="$HOME/.cache/nowplaying_scroll_pos"
MEDIA_FILE="$HOME/.cache/nowplaying_last_track"
PAUSE_UNTIL_FILE="$HOME/.cache/nowplaying_pause_until"

mkdir -p "$HOME/.cache"
[[ -f "$SCROLL_FILE" ]] || echo "0" > "$SCROLL_FILE"
[[ -f "$PAUSE_UNTIL_FILE" ]] || echo "0" > "$PAUSE_UNTIL_FILE"

now_ms() { date +%s%3N; }

emit_json() {
  local text="$1" status="$2"
  # minimal JSON escaping
  text="${text//\\/\\\\}"
  text="${text//\"/\\\"}"
  echo "{\"text\":\"$text\",\"class\":\"${status,,}\"}"
}

while true; do
  # If player is not found
  if ! playerctl -p "$PLAYER" status >/dev/null 2>&1; then
    rm -f "$SCROLL_FILE" "$MEDIA_FILE" "$PAUSE_UNTIL_FILE"
    # Tail mode, better sleep
    sleep 0.5
    continue
  fi

  player_status="$(playerctl -p "$PLAYER" status 2>/dev/null || true)"
  artist="$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null || true)"
  title="$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null || true)"

  # If nothing there, return valid JSON
  if [[ -z "${artist}${title}" ]]; then
    emit_json "" "$player_status"
    sleep 0.3
    continue
  fi

  track="${title} ─ ${artist} ─ "

  last_track="$(cat "$MEDIA_FILE" 2>/dev/null || true)"
  if [[ "$track" != "$last_track" ]]; then
    echo "$track" > "$MEDIA_FILE"
    echo "0" > "$SCROLL_FILE"
    echo "0" > "$PAUSE_UNTIL_FILE"
  fi

  scroll_pos="$(cat "$SCROLL_FILE" 2>/dev/null || echo 0)"
  pause_until="$(cat "$PAUSE_UNTIL_FILE" 2>/dev/null || echo 0)"

  visible_chars=$(( ${#track} / 2 ))
  (( visible_chars < VISIBLE_MIN )) && visible_chars=$VISIBLE_MIN
  (( visible_chars > ${#track} )) && visible_chars=${#track}

  if [[ "$player_status" != "Paused" ]]; then
    now="$(now_ms)"
    if (( now >= pause_until )); then
      scroll_pos=$((scroll_pos + STEP))

      if (( scroll_pos > ${#track} )); then
        scroll_pos=0
        echo $((now + 1200)) > "$PAUSE_UNTIL_FILE"
      fi

      echo "$scroll_pos" > "$SCROLL_FILE"
    fi
  fi

  if (( scroll_pos + visible_chars <= ${#track} )); then
    display_text="${track:scroll_pos:visible_chars}"
  else
    wrap_len=$(( scroll_pos + visible_chars - ${#track} ))
    display_text="${track:scroll_pos}${track:0:wrap_len}"
  fi

  emit_json "$display_text" "$player_status"
  sleep "$TICK"
done
