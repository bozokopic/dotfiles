#!/bin/sh

exec >~/.niri.log 2>&1

export QT_QPA_PLATFORM=wayland

if ( command -v systemctl && systemctl --user is-system-running ) >/dev/null; then
    exec niri-session

elif pgrep -U $(id -u) dbus-daemon >/dev/null; then
    exec niri --session

else
    exec dbus-run-session -- niri --session
fi
