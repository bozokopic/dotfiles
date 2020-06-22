#!/bin/bash

CLASSNAME=scratchpad_term
RESIZE_CMD="resize set 100 ppt 100 ppt"

if ps -C i3 > /dev/null ; then
    CMD=i3-msg
    PROP=instance
    RESIZE_CMD+=", resize shrink height 22 px"
    MOVE_CMD="move position center"
elif ps -C sway > /dev/null ; then
    CMD=swaymsg
    PROP=app_id
    MOVE_CMD="move position 0 0"
else
    exit 1
fi

$CMD -t get_tree | jq -e "[.. | .$PROP? | . == \"$CLASSNAME\"] | any"
[[ $? -ne 0 ]] && alacritty --class $CLASSNAME -e tmux new-session -A -s default

$CMD [$PROP=\"$CLASSNAME\"] scratchpad show, $RESIZE_CMD, $MOVE_CMD
