#!/bin/bash

xrandr
xrdb -merge ~/.Xresources
xset -b
autorandr --change
[[ -n $(xrandr | grep "connected 3840x2160") ]] && xrandr --dpi 120
[[ -n $(xrandr | grep "connected 3840x2160") ]] && echo "Xft.dpi: 120" | xrdb -override

feh --bg-scale ~/.pictures/bg1.jpg \
               ~/.pictures/bg2.jpg

picom &
#gajim &
