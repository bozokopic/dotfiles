#!/bin/bash

CLASSNAME=scratchpad_term

[[ -z $(xdotool search --classname $CLASSNAME) ]] && \
    alacritty --class $CLASSNAME -e tmux new-session -A -s default

i3-msg [instance=\"$CLASSNAME\"] scratchpad show, \
                                 resize set 100 ppt 100 ppt, \
                                 resize shrink height 22 px, \
                                 move position center
