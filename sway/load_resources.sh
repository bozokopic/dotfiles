#!/bin/sh

xrdb -load ~/.Xresources
(swaymsg -p -t get_outputs | grep -q "Current mode: 3840x2160") && \
    echo "Xft.dpi: 120" | xrdb -override

