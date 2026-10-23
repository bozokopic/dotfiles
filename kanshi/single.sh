#!/bin/sh

. $(dirname "$(realpath "$0")")/env.sh

killall swaybg >/dev/null
swaybg -o $primary -i $bg1 &

if [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    for workspace in 1:1 2:2 3:3 4:4 5:a 6:s 7:d 8:f; do
        swaymsg -q workspace $workspace output $primary
    done

elif [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
    for workspace in 1:1 2:2 3:3 4:4 5:a 6:s 7:d 8:f; do
        niri msg action move-workspace-to-monitor --reference $workspace $primary
    done
fi

