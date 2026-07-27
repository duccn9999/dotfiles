#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

choice=$(printf "󰍹  Full Screen\n󰹑  Select Area\n󰖲  Active Window" | \
  rofi -dmenu -i -p "Screenshot")

[ -z "$choice" ] && exit

(
  # Give Rofi time to close
  sleep 0.2

  case "$choice" in
    "󰍹  Full Screen")
      maim "$FILE"
      ;;
    "󰹑  Select Area")
      maim -s "$FILE"
      ;;
    "󰖲  Active Window")
      maim -i "$(xdotool getactivewindow)" "$FILE"
      ;;
  esac

  if [ -f "$FILE" ]; then
    xclip -selection clipboard -t image/png -i "$FILE"
    notify-send "Screenshot" \
      "Saved to $(basename "$FILE") and copied to clipboard."
  fi
  ) &
