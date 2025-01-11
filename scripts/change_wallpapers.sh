#!/bin/bash

WALLPAPER_DIRECTORY=/home/barmanji/Downloads/ColorWall

WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

echo "$WALLPAPER" > ~/.config/hypr/current_wallpaper.txt #saves the currect wallpaper data
sed -i "s|path = .*|path = $WALLPAPER|" ~/.config/hypr/hyprlock.conf # Update hyprlock.conf with the new wallpaper path


hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"

sleep 1

hyprctl hyprpaper unload unused
