#!/bin/sh

exec swayidle -w timeout 600 'swaymsg "output * power off"' \
                 resume 'swaymsg "output * power on"'
