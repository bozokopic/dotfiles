#!/bin/sh

if ! (which yay > /dev/null); then
    cd $(dirname "$0")
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

yay -S --needed --noconfirm \
    $(cat ~/.dotfiles/yay/packages.txt | \
      xargs -I{} sh -c \
        "(pacman -Q {} &> /dev/null) || echo {}")
