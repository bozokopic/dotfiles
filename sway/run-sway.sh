#!/bin/sh

if pidof dbus-daemon > /dev/null; then
    exec sway > ~/.sway.log
else
    exec dbus-run-session -- sway > ~/.sway.log
fi
