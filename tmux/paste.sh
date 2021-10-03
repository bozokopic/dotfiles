#!/bin/sh

if [ -z "$WAYLAND_DISPLAY" ]; then
    xclip -o -selection clipboard | tmux load-buffer - && tmux paste-buffer
else
    wl-paste --no-newline | tmux load-buffer - && tmux paste-buffer
fi
