#!/usr/bin/env bash
set -u

PLAYER="${1:-spotify}"
VISIBLE_MIN=15

# Defaults
TICK="${TICK:-0.10}" # Update
STEP="${STEP:-0.25}" # Speed

SCROLL_FP_FILE="$HOME/.cache/nowplaying_scroll_pos_fp"
MEDIA_FILE="$HOME/.cache/nowplaying_last_track"
PAUSE_UNTIL_FILE="$HOME/.cache/nowplaying_pause_until"

mkdir -p "$HOME/.cache"
[[ -f "$SCROLL_FP_FILE" ]] || echo "0" >"$SCROLL_FP_FILE"
[[ -f "$PAUSE_UNTIL_FILE" ]] || echo "0" >"$PAUSE_UNTIL_FILE"

now_ms() { date +%s%3N; }

emit_json() {
  local text="$1" status="$2"
  text="${text//\\/\\\\}"
  text="${text//\"/\\\"}"
  echo "{\"text\":\"$text\",\"class\":\"${status,,}\"}"
}

# Fixed-point setup
SCALE=1000

# STEP -> step_fp (Integer in thousandths)
step_fp="$(awk -v s="$STEP" -v sc="$SCALE" 'BEGIN{
  gsub(",", ".", s);
  if (s == "" || s ~ /[^0-9.]/) { s = 0 }
  # round to nearest int
  printf "%d", (s * sc) + 0.5
}')"

# If STEP is 0, set a default
((step_fp <= 0)) && step_fp=1

while true; do
  if ! playerctl -p "$PLAYER" status >/dev/null 2>&1; then
    rm -f "$SCROLL_FP_FILE" "$MEDIA_FILE" "$PAUSE_UNTIL_FILE"
    sleep 0.5
    continue
  fi

  player_status="$(playerctl -p "$PLAYER" status 2>/dev/null || true)"
  artist="$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null || true)"
  title="$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null || true)"

  if [[ -z "${artist}${title}" ]]; then
    emit_json "" "$player_status"
    sleep 0.3
    continue
  fi

  track="${title} ─ ${artist} ─ "

  last_track="$(cat "$MEDIA_FILE" 2>/dev/null || true)"
  if [[ "$track" != "$last_track" ]]; then
    echo "$track" >"$MEDIA_FILE"
    echo "0" >"$SCROLL_FP_FILE"
    echo "0" >"$PAUSE_UNTIL_FILE"
  fi

  scroll_fp="$(cat "$SCROLL_FP_FILE" 2>/dev/null || echo 0)"
  pause_until="$(cat "$PAUSE_UNTIL_FILE" 2>/dev/null || echo 0)"

  # clamp visible_chars
  visible_chars=$((${#track} / 2))
  ((visible_chars < VISIBLE_MIN)) && visible_chars=$VISIBLE_MIN
  ((visible_chars > ${#track})) && visible_chars=${#track}

  if [[ "$player_status" != "Paused" ]]; then
    now="$(now_ms)"
    if ((now >= pause_until)); then
      scroll_fp=$((scroll_fp + step_fp))

      # wrap check in fixed-point
      if ((scroll_fp > ${#track} * SCALE)); then
        scroll_fp=0
        echo $((now + 1200)) >"$PAUSE_UNTIL_FILE"
      fi

      echo "$scroll_fp" >"$SCROLL_FP_FILE"
    fi
  fi

  # integer index for slicing
  scroll_pos=$((scroll_fp / SCALE))

  if ((scroll_pos + visible_chars <= ${#track})); then
    display_text="${track:scroll_pos:visible_chars}"
  else
    wrap_len=$((scroll_pos + visible_chars - ${#track}))
    display_text="${track:scroll_pos}${track:0:wrap_len}"
  fi

  emit_json "$display_text" "$player_status"
  sleep "$TICK"
done
