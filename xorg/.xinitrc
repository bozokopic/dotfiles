#!/bin/sh

xrandr
xset -b
autorandr --change
loadxresources
xsetroot -cursor_name left_ptr
setwallpaper

#/usr/lib/kactivitymanagerd &

picom -I 1 -O 1 -D 0 -m 1 &
dunst &
exec bspwm
