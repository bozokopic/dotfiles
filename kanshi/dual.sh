#!/bin/sh

display1=eDP-1
display2=$(swaymsg -t get_outputs -r |
           jq "map(select(.name != \"$display1\") | .name)[0]" 2> /dev/null |
           tr -d "\"")

swaymsg reload

swaymsg output $display1 pos 0 0 \
                         res 1920x1080 \
                         bg ~/.pictures/bg1.jpg stretch
swaymsg output $display2 pos 1920 0 \
                         bg ~/.pictures/bg2.jpg stretch

for workspace in 1:1 2:2 3:3 4:4; do
    swaymsg workspace $workspace output $display1
done

for workspace in 5:a 6:s 7:d 8:f; do
    swaymsg workspace $workspace output $display2
done
