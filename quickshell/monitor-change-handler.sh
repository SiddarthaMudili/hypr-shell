#!/bin/bash
# Event-driven monitor change handler for quickshell
# Listens to Hyprland socket2 for monitoradded/monitorremoved events

LOG_FILE="/tmp/quickshell-monitor-handler.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

restart_quickshell() {
    log "Monitor event: $1 — restarting quickshell"
    killall quickshell 2>/dev/null
    sleep 0.5
    nohup quickshell &
    log "Quickshell restarted (pid: $!)"
}

log "Monitor change handler started (event-driven)"

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

if [ ! -S "$SOCKET" ]; then
    log "ERROR: Hyprland socket not found at $SOCKET"
    exit 1
fi

socat -u UNIX-CONNECT:"$SOCKET" - | while IFS= read -r event; do
    case "$event" in
        monitoradded*|monitorremoved*)
            restart_quickshell "$event"
            ;;
    esac
done
