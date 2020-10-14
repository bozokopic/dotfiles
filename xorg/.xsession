#!/bin/sh

xrandr
xset -b
autorandr --change
~/.dotfiles/xorg/load_resources.sh
~/.dotfiles/xorg/set_wallpaper.sh

picom -I 1 -O 1 -D 0 &
