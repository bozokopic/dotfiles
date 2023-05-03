#!/bin/sh

display1=eDP-1
display2=DP-5
display3=DP-6

swaymsg reload

swaymsg output $display1 pos 0 1440 \
                         res 1920x1080 \
                         bg ~/.pictures/bg1.jpg stretch
swaymsg output $display2 pos 0 0 \
                         res 2560x1440 \
                         bg ~/.pictures/bg1.jpg stretch
swaymsg output $display3 pos 2560 0 \
                         res 2560x1440 \
                         bg ~/.pictures/bg2.jpg stretch

swaymsg workspace 1:1 output $display1

for workspace in 2:2 3:3 4:4; do
    swaymsg workspace $workspace output $display2
done

for workspace in 5:a 6:s 7:d 8:f; do
    swaymsg workspace $workspace output $display3
done
