#!/bin/sh

. $(dirname "$(realpath "$0")")/env.sh

display_width=2560
display_height=1440
display_res=${display_width}x${display_height}

display1=$(display_names '.model == "DELL U2722DE"')
display2=$(display_names '.model == "DELL U2722D"')

swaymsg reload

swaymsg -q output $primary pos 0 1440 \
                            res $primary_res \
                            bg $bg1 stretch
swaymsg -q output $display1 pos 0 0 \
                            res $display_res \
                            bg $bg1 stretch
swaymsg -q output $display2 pos $display_width 0 \
                            res $display_res \
                            bg $bg2 stretch

swaymsg -q workspace 1:1 output $primary

for workspace in 2:2 3:3 4:4; do
    swaymsg -q workspace $workspace output $display1
done

for workspace in 5:a 6:s 7:d 8:f; do
    swaymsg -q workspace $workspace output $display2
done
