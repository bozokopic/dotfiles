#!/bin/sh


if ( ( command -v systemctl && systemctl --user is-system-running ) ||
     pgrep -U $(id -u) dbus-daemon ) > /dev/null; then
    exec sway > ~/.sway.log 2>&1
else
    exec dbus-run-session -- sway > ~/.sway.log 2>&1
fi
