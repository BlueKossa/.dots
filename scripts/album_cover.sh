#!/usr/bin/env bash

CACHE_DIR="$HOME/.cache"
ALBUM_ART_FILE="$CACHE_DIR/album_art"
CURRENT_STATUS_FILE="$CACHE_DIR/current_status"
LAST_URL_FILE="$CACHE_DIR/last_album_art_url"

last_url=$(cat "$LAST_URL_FILE")
res=$(
playerctl -p spotify metadata --format "{{mpris:artUrl}}
{{artist}} - {{title}}"
)

if [ $? -ne 0 ]; then
    echo ""
    exit 1
fi

url=$(echo "$res" | head -n 1)
status=$(echo "$res" | tail -n 1)
if [ "$url" != "$last_url" ]; then
    last_url="$url"
    curl -s "$url" > "$ALBUM_ART_FILE"
    echo "$last_url" > "$LAST_URL_FILE"
fi

echo "$ALBUM_ART_FILE"
echo "$status"
