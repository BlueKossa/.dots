#!/usr/bin/env bash

sel=$(ls -1 $HOME/.dots/wallpapers | grep "\.jpg\|\.png" | rofi -dmenu -i -p "Select Wallpaper")

if [ "$sel" ]; then
    cp $HOME/.dots/wallpapers/$sel $HOME/.cache/wallpaper
    swww img $HOME/.cache/wallpaper
    notify-send "Wallpaper changed to $sel"
fi

