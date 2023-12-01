
#!/usr/bin/env bash

swww init &

wp=$(cat ~/.cache/current_wallpaper)
swww img ~/.dots/wallpapers/$wp &

wal -R &

nm-applet --indicator &

waybar &

dunst &

xwaylandvideobridge &
