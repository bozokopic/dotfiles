#!/bin/sh

# export GDK_DPI_SCALE=0.95
if command -v gsettings >/dev/null; then
    gsettings set org.gnome.desktop.interface scaling-factor 1
    gsettings set org.gnome.desktop.interface text-scaling-factor 1
    gsettings set org.gnome.desktop.interface cursor-size 32
fi

export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway

os_id=$(. /etc/os-release && echo $ID)

if command -v systemctl >/dev/null; then
    systemctl --user import-environment \
        QT_QPA_PLATFORM \
        SWAYSOCK \
        WAYLAND_DISPLAY \
        XDG_SESSION_TYPE \
        XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd --all

    systemctl --user restart xdg-desktop-portal
    systemctl --user restart xdg-desktop-portal-wlr
    systemctl --user restart xdg-desktop-portal-gtk
    systemctl --user restart plasma-kactivitymanagerd

else
    dbus-update-activation-environment WAYLAND_DISPLAY \
                                       XDG_CURRENT_DESKTOP

    if [ "$os_id" = "alpine" ]; then
        /usr/libexec/pipewire-launcher &
        /usr/libexec/xdg-desktop-portal-wlr &

    elif [ "$os_id" = "void" ]; then
        pipewire &
    fi
fi

~/.config/sway/swayidle.sh &
kanshi &
waybar -c ~/.config/waybar/sway.conf &
