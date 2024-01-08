#!/bin/sh

exec > ~/.river.log 2>&1

if ( ( command -v systemctl && systemctl --user is-system-running ) ||
     pgrep -U $(id -u) dbus-daemon ) > /dev/null; then
    exec river
else
    exec dbus-run-session -- river
fi
