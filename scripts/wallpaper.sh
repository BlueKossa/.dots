#!/usr/bin/env bash

sel=$(ls -1 $HOME/.dots/wallpapers | grep "\.jpg\|\.png\|\.gif" | rofi -dmenu -i -p "Select Wallpaper")

if [ "$sel" ]; then
    echo $sel > $HOME/.cache/current_wallpaper
    wal -q -i $HOME/.dots/wallpapers/$sel
    swww img $HOME/.dots/wallpapers/$sel --transition-step 50
    killall .waybar-wrapped
    killall waybar
    waybar &
    notify-send "Wallpaper changed to $sel"
fi

