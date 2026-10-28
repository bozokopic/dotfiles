#!/bin/sh

exec >~/.niri.log 2>&1

export QT_QPA_PLATFORM=wayland

if [ "$(ps -p 1 -o comm=)" = "systemd" ]; then
    exec niri-session

elif [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
    exec niri --session

else
    exec dbus-run-session -- niri --session
fi
