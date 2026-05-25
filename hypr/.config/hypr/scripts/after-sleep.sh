#!/bin/bash
# Run after system wakes from sleep.
# Always turn DPMS back on, and re-enable the built-in display if the lid is open
# (opening the lid to wake consumes the switch:off event, so Hyprland never sees it).

hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "on" }))'

if grep -q open /proc/acpi/button/lid/*/state 2>/dev/null; then
    sleep 0.5
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.2, disabled = false })'
fi
