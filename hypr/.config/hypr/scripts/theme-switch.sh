#!/usr/bin/env bash

# theme-switch.sh — Toggle or set the active theme across the Hyprland ecosystem
# Usage: theme-switch.sh [catppuccin|tokyonight]
#   No argument: toggle between catppuccin and tokyonight

set -euo pipefail

HYPR_DIR="$HOME/.config/hypr"
WAYBAR_DIR="$HOME/.config/waybar"
WOFI_DIR="$HOME/.config/wofi"
SWAYNC_DIR="$HOME/.config/swaync"
WLOGOUT_DIR="$HOME/.config/wlogout"
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
WALKER_CONFIG="$HOME/.config/walker/config.toml"
STATE_FILE="$HYPR_DIR/.current-theme"

# Map of themes to their source files
declare -A HYPR_THEME=( [catppuccin]="mocha.conf" [tokyonight]="tokyonight.conf" )
declare -A WAYBAR_THEME=( [catppuccin]="mocha.css" [tokyonight]="tokyonight.css" )
declare -A WOFI_THEME=( [catppuccin]="colors-catppuccin.css" [tokyonight]="colors-tokyonight.css" )
declare -A SWAYNC_THEME=( [catppuccin]="style-catppuccin.css" [tokyonight]="style-tokyonight.css" )
declare -A WLOGOUT_THEME=( [catppuccin]="style-catppuccin.css" [tokyonight]="style-tokyonight.css" )
declare -A GHOSTTY_THEME=( [catppuccin]="Catppuccin Mocha" [tokyonight]="TokyoNight Night" )
declare -A WALKER_THEME=( [catppuccin]="catppuccin" [tokyonight]="tokyonight" )

# Pretty names for notifications
declare -A THEME_LABEL=( [catppuccin]="Catppuccin Mocha" [tokyonight]="Tokyo Night" )

# Determine current theme
get_current_theme() {
	if [[ -f "$STATE_FILE" ]]; then
		cat "$STATE_FILE"
	else
		echo "catppuccin"
	fi
}

# Determine target theme
if [[ $# -ge 1 ]]; then
	TARGET="$1"
else
	CURRENT=$(get_current_theme)
	if [[ "$CURRENT" == "catppuccin" ]]; then
		TARGET="tokyonight"
	else
		TARGET="catppuccin"
	fi
fi

# Validate target
if [[ -z "${HYPR_THEME[$TARGET]+_}" ]]; then
	echo "Unknown theme: $TARGET" >&2
	echo "Available themes: catppuccin, tokyonight" >&2
	exit 1
fi

echo "Switching to theme: ${THEME_LABEL[$TARGET]}"

# --- Update symlinks ---

# Hyprland / Hyprlock color definitions
ln -sf "${HYPR_THEME[$TARGET]}" "$HYPR_DIR/theme.conf"

# Waybar color definitions
ln -sf "${WAYBAR_THEME[$TARGET]}" "$WAYBAR_DIR/catppuccin/themes/theme.css"

# Wofi color definitions
ln -sf "${WOFI_THEME[$TARGET]}" "$WOFI_DIR/colors.css"

# Swaync style
ln -sf "${SWAYNC_THEME[$TARGET]}" "$SWAYNC_DIR/style.css"

# Wlogout style
ln -sf "${WLOGOUT_THEME[$TARGET]}" "$WLOGOUT_DIR/style.css"

# --- Update config files via sed ---

# Ghostty
if [[ -f "$GHOSTTY_CONFIG" ]]; then
	sed -i "s/^theme = .*/theme = ${GHOSTTY_THEME[$TARGET]}/" "$GHOSTTY_CONFIG"
fi

# Walker
if [[ -f "$WALKER_CONFIG" ]]; then
	sed -i "s/^theme = .*/theme = \"${WALKER_THEME[$TARGET]}\"/" "$WALKER_CONFIG"
fi

# --- Save current theme ---
echo "$TARGET" > "$STATE_FILE"

# --- Reload services ---

# Reload Hyprland
hyprctl reload &>/dev/null || true

# Restart Waybar
killall -q waybar || true
sleep 0.3
waybar &>/dev/null &
disown

# Reload swaync
swaync-client -rs &>/dev/null || true

# Reload Ghostty (SIGUSR1 triggers config reload)
pkill -USR1 ghostty || true

# Restart Walker (to pick up new config)
pkill walker || true
# Restart the walker service using the launcher script (as background job)
nohup "$HOME/.config/hypr/scripts/launcher.sh" >/dev/null 2>&1 &

# --- Send notification ---
notify-send -a "Theme Switch" \
	-i preferences-desktop-theme \
	"Theme Changed" \
	"Switched to ${THEME_LABEL[$TARGET]}" \
	-t 3000 || true

echo "Done! Switched to ${THEME_LABEL[$TARGET]}"
