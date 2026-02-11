#!/bin/bash

file="$HOME/Videos/LiveWallpapers/Assassin's Creed Trailer ｜ Tribute - Angels (GMV).mp4"
sound="sound"

echo "Check monitors"
mapfile -t outputs < <(hyprctl monitors -j | jq -r '.[].name')

if [[ "${#outputs[@]}" -eq 0 ]]; then
  echo "No monitors found via hyprctl."
  exit 2
fi

for mon in "${outputs[@]}"; do
  echo "$mon"
done

sound_out=""
echo "Check what monitor should have sound!"
if [[ "$sound" == "sound" ]]; then
  sound_out="$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name' | head -n1)"
  [[ -n "$sound_out" ]] || sound_out="DP-3"
fi

echo "$sound_out" "has Sound!"
echo "Applying Live Wallpapers"

for out in "${outputs[@]}"; do
  if [[ "$sound" == "sound" && "$out" == "$sound_out" ]]; then
    echo "$out"
    mpvpaper -o "loop-file=inf" "$out" "$file" >/dev/null 2>&1 &
    echo "Now has sound!"
  else
    echo "$out"
    mpvpaper -o "loop-file=inf --no-audio" "$out" "$file" >/dev/null 2>&1 &
    echo "Has no sound!"
  fi
done

echo "DONE!"
