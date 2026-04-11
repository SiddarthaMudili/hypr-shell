#!/bin/bash

# Watches .desktop file directories for changes and reloads Quickshell
# so the app launcher stays up-to-date when new apps are installed.
# Installed to: ~/.local/bin/watch_apps.sh
# Started by: hypr/autostart.conf

WATCH_DIR1="/usr/share/applications"
WATCH_DIR2="$HOME/.local/share/applications"

fswatch -o "$WATCH_DIR1" "$WATCH_DIR2" | while read -r _; do
    echo "App change detected. Reloading Quickshell..."
    killall -HUP quickshell 2>/dev/null || (killall quickshell 2>/dev/null; sleep 0.5 && quickshell &)
done
