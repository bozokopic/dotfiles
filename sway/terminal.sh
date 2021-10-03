#!/bin/sh

DESKTOP=term
INSTANCE=tmux_term

TERM_WORKSPACE="9:term"
TERM_APP_ID=tmux_term

FOCUSED_OUTPUT=$(swaymsg -t get_outputs -r |
                 jq '.[] | select(.focused == true) | .name' |
                 tr -d '"')
FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces -r |
                    jq '.[] | select(.focused == true) | .name' |
                    tr -d '"')

if [ "$FOCUSED_WORKSPACE" = "$TERM_WORKSPACE" ]; then
    swaymsg workspace back_and_forth
else
    swaymsg workspace $TERM_WORKSPACE
    swaymsg move workspace to $FOCUSED_OUTPUT
    swaymsg workspace $TERM_WORKSPACE

    if ! (swaymsg -t get_tree -r |
          jq -e "recurse(.nodes[]) | select(.app_id == \"$TERM_APP_ID\")" > /dev/null); then
        exec alacritty --class $TERM_APP_ID -e \
            tmux new-session -A -s default
    fi
fi
