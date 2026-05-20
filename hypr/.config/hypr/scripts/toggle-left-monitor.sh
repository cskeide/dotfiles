#!/bin/bash
# Toggle the left Dell U2515H 25" monitor (sydney dual-monitor setup)
SCRIPTS_DIR="$(dirname "$0")"

MONITOR_JSON=$(hyprctl monitors all -j | jq -r '.[] | select(.description | contains("U2515H"))')

# Exit silently if monitor is not connected
[ -z "$MONITOR_JSON" ] && exit 0

CONNECTOR=$(echo "$MONITOR_JSON" | jq -r '.name')
DISABLED=$(echo "$MONITOR_JSON" | jq -r '.disabled')

if [ "$DISABLED" = "false" ]; then
    hyprctl eval "hl.monitor({ output = \"$CONNECTOR\", disabled = true })"
else
    hyprctl eval "hl.monitor({ output = \"$CONNECTOR\", mode = \"2560x1440\", position = \"0x0\", scale = 1, disabled = false })"
fi

sleep 0.5
"$SCRIPTS_DIR/waybarctl.sh" restart

sleep 0.5
"$SCRIPTS_DIR/waybarctl.sh" restart
