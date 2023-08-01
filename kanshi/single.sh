#!/bin/sh

display=eDP-1

swaymsg -q reload

swaymsg -q output $display pos 0 0 \
                           res 1920x1080 \
                           bg ~/.pictures/bg1.jpg stretch

for workspace in 1:1 2:2 3:3 4:4 5:a 6:s 7:d 8:f; do
    swaymsg -q workspace $workspace output $display
done
