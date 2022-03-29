#!/bin/sh

xrandr
xset -b
autorandr --change
loadxresources
xsetroot -cursor_name left_ptr
setwallpaper

#/usr/lib/kactivitymanagerd &

dbus-update-activation-environment --systemd --all

picom -I 1 -O 1 -D 0 -m 1 &
dunst &
exec bspwm
