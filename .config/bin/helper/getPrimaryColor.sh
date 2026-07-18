#!/bin/bash

THEME="$1"
INPUT_FILE="$HOME/.config/waybar/colors/custom/${THEME}.css"
OUTPUT_FILE="$HOME/.config/hypr/hyprlockColor.conf"

if [ ! -f "$INPUT_FILE" ]; then
  echo "❌ File not found: $INPUT_FILE"
  exit 1
fi

# Extract color
HEX=$(grep -oP '@define-color\s+primaryColor\s+\K#[0-9a-fA-F]{6,8}' "$INPUT_FILE" | head -n1)

if [ -z "$HEX" ]; then
  echo "❌ primaryColor not found!"
  exit 1
fi

# Transform to rgba (8 chars)
if [ ${#HEX} -eq 7 ]; then
  HEX="${HEX}ff"
fi

RGBA="rgba(${HEX:1})"
