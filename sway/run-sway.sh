#!/bin/sh

exec >~/.sway.log 2>&1

export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway

if ( ( command -v systemctl && systemctl --user is-system-running ) ||
     pgrep -U $(id -u) dbus-daemon ) >/dev/null; then
    exec sway

else
    exec dbus-run-session -- sway
fi
