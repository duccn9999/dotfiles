#!/usr/bin/env bash

choice=$(printf " Power Off\n󰜉 Reboot\n Suspend\n Lock\n" | rofi -dmenu -i -p "Power")

case "$choice" in
  " Power Off")
    systemctl poweroff
    ;;
  "󰜉 Reboot")
    systemctl reboot
    ;;
  " Suspend")
    systemctl suspend
    ;;
  " Lock")
    xdg-screensaver lock
    ;;
esac
