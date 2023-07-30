#!/bin/sh

term_workspace="9:term"
term_app_id=tmux_term

focused_output=$(swaymsg -t get_outputs -r |
                 jq -r '.[] | select(.focused == true) | .name')
focused_workspace=$(swaymsg -t get_workspaces -r |
                    jq -r '.[] | select(.focused == true) | .name')

if [ "$focused_workspace" = "$term_workspace" ]; then
    swaymsg workspace back_and_forth

else
    swaymsg workspace $term_workspace
    swaymsg move workspace to $focused_output
    swaymsg workspace $term_workspace

    if ! (swaymsg -t get_tree -r |
          jq -e "recurse(.nodes[]) | select(.app_id == \"$term_app_id\")" > /dev/null); then
        # exec alacritty --class $term_app_id -e \
        #     tmux new-session -A -s default
        exec foot --app-id $term_app_id \
            tmux new-session -A -s default
    fi
fi
