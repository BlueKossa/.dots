
#!/usr/bin/env bash

swww init &

wp=$(cat ~/.cache/current_wallpaper)
swww img ~/.dots/wallpapers/$wp &

wal -R &

nm-applet --indicator &

blueman-applet &

waybar &

dunst &

xwaylandvideobridge &

/home/bluecore/.config/hypr/autostart.sh &
