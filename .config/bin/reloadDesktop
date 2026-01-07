#!/bin/bash

# Starts these services even if waybar or swaync weren't launched yet

killall -9 waybar
killall -9 swaync

waybar &
swaync &
hyprctl reload
notify-send -a transient "Desktop Reloaded!"
