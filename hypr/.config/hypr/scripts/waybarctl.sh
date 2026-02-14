#!/usr/bin/env bash

STATE_FILE="$XDG_RUNTIME_DIR/waybar.state"

get_waybar_pids() {
    pgrep -x waybar
}

show() {
    echo "shown" > "$STATE_FILE"
    for pid in $(get_waybar_pids); do
        kill -SIGUSR2 "$pid" 2>/dev/null
    done
}

hide() {
    echo "hidden" > "$STATE_FILE"
    for pid in $(get_waybar_pids); do
        kill -SIGUSR1 "$pid" 2>/dev/null
    done
}

toggle() {
    if [[ ! -f "$STATE_FILE" ]]; then
        echo "shown" > "$STATE_FILE"
    fi

    state=$(cat "$STATE_FILE")

    if [[ "$state" == "shown" ]]; then
        hide
    else
        show
    fi
}

case "$1" in
    show) show ;;
    hide) hide ;;
    toggle) toggle ;;
    *)
        echo "Usage: waybar-ctl {show|hide|toggle}"
        exit 1
        ;;
esac

