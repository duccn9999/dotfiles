#!/usr/bin/env bash

DIR="$HOME/Pictures/Wallpapers"

wall=$(find "$DIR" -type f | sort | rofi -dmenu -i -p "Wallpaper")

[ -z "$wall" ] && exit

feh --bg-fill "$wall"
