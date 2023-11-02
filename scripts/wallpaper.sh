#!/usr/bin/env bash

sel=$(ls -1 $HOME/.dots/wallpapers | grep "\.jpg\|\.png" | rofi -dmenu -i -p "Select Wallpaper")

if [ "$sel" ]; then
    cp $HOME/.dots/wallpapers/$sel $HOME/.cache/current_wallpaper.jpg
    wal -q -i $HOME/.dots/wallpapers/$sel
    swww img $HOME/.cache/current_wallpaper.jpg
    killall .waybar-wrapped
    killall waybar
    waybar &
    notify-send "Wallpaper changed to $sel"
fi

