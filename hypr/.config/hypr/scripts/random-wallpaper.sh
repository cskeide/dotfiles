#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SOCK="/run/user/$(id -u)/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.hyprpaper.sock"

# Ensure hyprpaper is running
if ! pgrep -x hyprpaper >/dev/null; then
    echo "Starting hyprpaper..."
    hyprpaper & disown
    # Wait a bit for socket to appear
    for i in {1..10}; do
        [[ -S "$SOCK" ]] && break
        sleep 0.3
    done
fi

# If socket still missing, give up gracefully
if [[ ! -S "$SOCK" ]]; then
    echo "Error: Could not connect to hyprpaper socket at $SOCK"
    exit 1
fi

CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.gif' \) ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
