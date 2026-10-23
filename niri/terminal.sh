#!/bin/sh

term_workspace=9:term
term_app_id=tmux_term

focused_output=$(niri msg -j workspaces |
                 jq -r '.[] | select(.is_focused == true) | .output')
focused_workspace=$(niri msg -j workspaces |
                    jq -r '.[] | select(.is_focused == true) | .name')

if [ "$focused_workspace" = "$term_workspace" ]; then
    niri msg action focus-workspace-previous

else
    niri msg action focus-workspace $term_workspace
    niri msg action move-workspace-to-monitor $focused_output
    niri msg action focus-workspace $term_workspace

    if ! (niri msg -j windows |
          jq -e ".[] | select(.app_id == \"$term_app_id\")" > /dev/null); then

        exec foot --app-id $term_app_id \
           tmux new-session -A -s default
    fi
fi
