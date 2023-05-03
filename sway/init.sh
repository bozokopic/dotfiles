#!/bin/sh

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

~/.config/sway/swayidle.sh &

kanshi &

waybar -c ~/.config/waybar/sway.conf &
