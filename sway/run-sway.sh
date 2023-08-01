#!/bin/sh

if pidof dbus-daemon > /dev/null; then
    exec sway > ~/.sway.log 2>&1
else
    exec dbus-run-session -- sway > ~/.sway.log 2>&1
fi
