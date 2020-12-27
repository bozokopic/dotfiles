#!/bin/sh

xrdb -load ~/.Xresources
(xrandr | grep -q "connected 3840x2160") && \
    xrandr --dpi 120 && \
    echo "Xft.dpi: 120" | xrdb -override

