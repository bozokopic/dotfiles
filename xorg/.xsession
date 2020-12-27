#!/bin/sh

xrandr
xset -b
autorandr --change
~/.dotfiles/xorg/loadxresources
~/.dotfiles/xorg/setwallpaper

picom -I 1 -O 1 -D 0 -m 1 &
