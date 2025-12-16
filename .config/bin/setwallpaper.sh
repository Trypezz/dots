#!/bin/bash

setWallpaper() {
	swww img $1 --transition-type top
	notify-send "Wallpaper changed!" "Changed Wallpaper to $1"
}
