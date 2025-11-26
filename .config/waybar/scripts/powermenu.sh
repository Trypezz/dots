#!/bin/bash

chosen=$(echo -e "  Logout\n  Shutdown\n  Restart" | rofi -dmenu -i -p "Power Options" -theme ~/.config/rofi/themes/current.rasi)

case "$chosen" in
  *Logout)    hyprctl dispatch exit ;;
  *Shutdown) systemctl poweroff ;;
  *Restart)  systemctl reboot ;;
esac
