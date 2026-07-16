#!/bin/bash

THEME="$1"
INPUT_FILE="$HOME/.config/waybar/colors/custom/${THEME}.css"
OUTPUT_FILE="$HOME/.config/hypr/hyprlockColor.conf"

if [ ! -f "$INPUT_FILE" ]; then
  echo "❌ Datei nicht gefunden: $INPUT_FILE"
  exit 1
fi

# Farbe extrahieren
HEX=$(grep -oP '@define-color\s+primaryColor\s+\K#[0-9a-fA-F]{6,8}' "$INPUT_FILE" | head -n1)

if [ -z "$HEX" ]; then
  echo "❌ primaryColor nicht gefunden!"
  exit 1
fi

# In rgba(8-stellig) umwandeln
if [ ${#HEX} -eq 7 ]; then
  HEX="${HEX}ff"
fi

RGBA="rgba(${HEX:1})"

# Genau die gewünschte Zeile schreiben
echo "\$primaryColor = $RGBA" >"$OUTPUT_FILE"

echo "✅ Fertig!"
echo "   Theme: $THEME"
echo "   Geschrieben in: $OUTPUT_FILE"
echo "   Inhalt: \$primaryColor = $RGBA"
