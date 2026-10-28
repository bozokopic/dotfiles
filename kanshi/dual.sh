#!/bin/sh

. $(dirname "$(realpath "$0")")/env.sh

secondary=$(display_names ".name != \"$primary\"")

wlr-randr --output $primary --pos 0,0
wlr-randr --output $secondary --right-of $primary

pkill -x swaybg >/dev/null
swaybg -o $primary -i $bg1 \
       -o $secondary -i $bg2 &

if [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    for workspace in 1:1 2:2 3:3 4:4; do
        swaymsg -q workspace $workspace output $primary
    done

    for workspace in 5:a 6:s 7:d 8:f; do
        swaymsg -q workspace $workspace output $secondary
    done

elif [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
    for workspace in 1:1 2:2 3:3 4:4; do
        niri msg action move-workspace-to-monitor --reference $workspace $primary
    done

    for workspace in 5:a 6:s 7:d 8:f; do
        niri msg action move-workspace-to-monitor --reference $workspace $secondary
    done

    niri msg action move-workspace-to-index --reference 1:1 1
    niri msg action move-workspace-to-index --reference 2:2 2
    niri msg action move-workspace-to-index --reference 3:3 3
    niri msg action move-workspace-to-index --reference 4:4 4

    niri msg action move-workspace-to-index --reference 5:a 1
    niri msg action move-workspace-to-index --reference 6:s 2
    niri msg action move-workspace-to-index --reference 7:d 3
    niri msg action move-workspace-to-index --reference 8:f 4
fi

