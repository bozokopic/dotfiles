#!/bin/sh

. $(dirname "$(realpath "$0")")/env.sh

swaymsg -q reload

swaymsg -q output $primary pos 0 0 \
                           res $primary_res \
                           bg $bg1 stretch

for workspace in 1:1 2:2 3:3 4:4 5:a 6:s 7:d 8:f; do
    swaymsg -q workspace $workspace output $primary
done
