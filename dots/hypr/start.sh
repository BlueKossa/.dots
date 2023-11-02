
#!/usr/bin/env bash

swww init &

swww img ~/.cache/current_wallpaper.jpg &

wal -R &

nm-applet --indicator &

waybar &

dunst &

xwaylandvideobridge &
