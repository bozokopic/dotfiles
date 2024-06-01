#!/bin/sh

. $(dirname "$(realpath "$0")")/env.sh

tv=$(display_names '.model == "LG TV"')
secondary=$(display_names ".name != \"$primary\" and .name != \"$tv\"")
secondary_width=$(display_widths ".name == \"$secondary\"")

swaymsg -q reload

swaymsg -q output $primary pos 0 0 \
                           res $primary_res \
                           bg $bg1 stretch
swaymsg -q output $secondary pos $primary_width 0 \
                             bg $bg2 stretch

swaymsg -q output $tv pos $(($primary_width + $secondary_width)) 0 \
                      bg $bg1 stretch

for workspace in 1:1 2:2 3:3; do
    swaymsg -q workspace $workspace output $primary
done

for workspace in 5:a 6:s 7:d 8:f; do
    swaymsg -q workspace $workspace output $secondary
done

for workspace in 4:4; do
    swaymsg -q workspace $workspace output $tv
done
