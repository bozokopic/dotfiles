#!/bin/sh

mod=Mod4
primary=eDP-1
secondary=$(swaymsg -t get_outputs -r |
            jq "map(select(.name != \"$primary\") | .name)[0]" 2> /dev/null |
            tr -d "\"")

swaymsg output $primary pos 0 0 res 1920x1080 bg ~/.pictures/bg1.jpg stretch
[ ! -z "$secondary" ] && swaymsg output $secondary pos 1920 0 bg ~/.pictures/bg2.jpg stretch

swaymsg workspace 1:1 output $primary
swaymsg workspace 2:2 output $primary
swaymsg workspace 3:3 output $primary
swaymsg workspace 4:4 output $primary
swaymsg workspace 5:a output ${secondary:-$primary}
swaymsg workspace 6:s output ${secondary:-$primary}
swaymsg workspace 7:d output ${secondary:-$primary}
swaymsg workspace 8:f output ${secondary:-$primary}

swaymsg font "pango:Inter Medium 12"
swaymsg floating_modifier $mod
swaymsg default_border pixel 4

swaymsg assign "[app_id=\"^tmux_term\$\"]" 9:term

# export GDK_DPI_SCALE=0.95
gsettings set org.gnome.desktop.interface scaling-factor 1
gsettings set org.gnome.desktop.interface text-scaling-factor 1
gsettings set org.gnome.desktop.interface cursor-size 32

export QT_QPA_PLATFORM=wayland
systemctl --user import-environment \
    QT_QPA_PLATFORM \
    SWAYSOCK \
    WAYLAND_DISPLAY \
    XDG_SESSION_TYPE \
    XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd --all

systemctl --user restart plasma-kactivitymanagerd.service
