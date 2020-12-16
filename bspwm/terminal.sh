#!/bin/sh

DESKTOP=term
INSTANCE=tmux_term

(xdo id -n $INSTANCE > /dev/null) || \
    alacritty --class $INSTANCE -e \
        tmux new-session -A -s default

if [ $(bspc query -D --names -d focused) = $DESKTOP ]; then
    bspc desktop -f last.local
else
    bspc desktop $DESKTOP -m focused
    bspc desktop -f $DESKTOP
fi
