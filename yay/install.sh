#!/bin/sh

yay --save --sudo doas
yay -S --needed --noconfirm \
    $(cat ~/.dotfiles/yay/packages.txt | \
      xargs -I{} sh -c \
        "(pacman -Q {} &> /dev/null) || echo {}")

