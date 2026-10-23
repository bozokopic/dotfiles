#!/bin/sh

if command -v gsettings >/dev/null; then
    gsettings set org.gnome.desktop.interface scaling-factor 1
    gsettings set org.gnome.desktop.interface text-scaling-factor 1
    gsettings set org.gnome.desktop.interface cursor-size 32
fi

os_id=$(. /etc/os-release && echo $ID)

if command -v systemctl >/dev/null; then
    systemctl --user restart plasma-kactivitymanagerd

else
    dbus-update-activation-environment WAYLAND_DISPLAY \
                                       XDG_CURRENT_DESKTOP

    if [ "$os_id" = "alpine" ]; then
        /usr/libexec/pipewire-launcher &

    elif [ "$os_id" = "void" ]; then
        pipewire &
    fi
fi

~/.config/niri/swayidle.sh &
kanshi &
waybar -c ~/.config/waybar/niri.conf &
