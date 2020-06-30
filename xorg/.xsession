#!/bin/bash

xset -b
autorandr --change
[[ -n $(xrandr | grep "connected 3840x2160") ]] && xrandr --dpi 120
[[ -n $(xrandr | grep "connected 3840x2160") ]] && echo "Xft.dpi: 120" | xrdb -override
sxhkd &
picom &
gajim &
zeal &
