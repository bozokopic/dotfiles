#!/bin/sh

exec >~/.sway.log 2>&1

export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway

if [ "$(ps -p 1 -o comm=)" = "systemd" ] || [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
    exec sway

else
    exec dbus-run-session -- sway
fi
