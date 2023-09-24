#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

mkdir -p ~/bin
mkdir -p ~/opt
mkdir -p ~/repos
mkdir -p ~/.config
mkdir -p ~/.local/share/applications
symlink $(cd $(dirname "$0"); pwd -P) ~/.dotfiles

# alacritty
symlink ~/.dotfiles/alacritty ~/.config/alacritty

# bspwm
symlink ~/.dotfiles/bspwm ~/.config/bspwm

# chromium
if [ -f /usr/share/applications/chromium.desktop ]; then
    symlink ~/.dotfiles/chromium/chromium ~/bin/chromium
    cp /usr/share/applications/chromium.desktop ~/.local/share/applications
    sed -i "s/^Exec=\\/usr/Exec=$(cd; pwd | sed 's/\//\\\//g')/g" \
        ~/.local/share/applications/chromium.desktop
fi

# claws
symlink ~/.dotfiles/claws/claws-mail ~/bin/claws-mail

# cudatext
mkdir -p ~/.config/cudatext/settings
symlink ~/.dotfiles/cudatext/user.json ~/.config/cudatext/settings/user.json

# drawio
if [ -f /usr/share/applications/drawio.desktop ]; then
    symlink ~/.dotfiles/drawio/drawio ~/bin/drawio
    cp /usr/share/applications/drawio.desktop ~/.local/share/applications
    sed -i "s/^Exec=\\S*/Exec=$(cd; pwd | sed 's/\//\\\//g')\\/bin\\/drawio/g" \
        ~/.local/share/applications/drawio.desktop
fi

# dunst
symlink ~/.dotfiles/dunst ~/.config/dunst

# fontconfig
symlink ~/.dotfiles/fontconfig ~/.config/fontconfig

# foot
symlink ~/.dotfiles/foot ~/.config/foot

# git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig

# i3
symlink ~/.dotfiles/i3 ~/.config/i3

# idasen
symlink ~/.dotfiles/idasen ~/.config/idasen

# kanshi
symlink ~/.dotfiles/kanshi ~/.config/kanshi

# lein
symlink ~/.dotfiles/lein/lein ~/bin/lein

# lf
symlink ~/.dotfiles/lf ~/.config/lf

# lock
symlink ~/.dotfiles/lock/lock ~/bin/lock
symlink ~/.dotfiles/lock/lock.desktop \
        ~/.local/share/applications/lock.desktop

# neomutt
symlink ~/.dotfiles/neomutt ~/.config/neomutt

# pictures
symlink ~/.dotfiles/pictures ~/.pictures

# polybar
symlink ~/.dotfiles/polybar ~/.config/polybar

# qutebrowser
mkdir -p ~/.config/qutebrowser
symlink ~/.dotfiles/qutebrowser/autoconfig.yml \
        ~/.config/qutebrowser/autoconfig.yml

# radio
symlink ~/.dotfiles/radio/student ~/bin/radio-student
symlink ~/.dotfiles/radio/sljeme ~/bin/radio-sljeme
symlink ~/.dotfiles/radio/jaska ~/bin/radio-jaska

# ranger
symlink ~/.dotfiles/ranger ~/.config/ranger

# river
symlink ~/.dotfiles/river ~/.config/river

# rofi
symlink ~/.dotfiles/rofi ~/.config/rofi

# setkbmap
symlink ~/.dotfiles/setkbmap/setkbmap ~/bin/setkbmap

# shell
symlink ~/.dotfiles/shell/.profile ~/.profile

# shell - bash
symlink ~/.dotfiles/shell/bash/.bashrc ~/.bashrc
symlink ~/.profile ~/.bash_profile

# shell - fish
symlink ~/.dotfiles/shell/fish ~/.config/fish

# shell - zsh
symlink ~/.dotfiles/shell/zsh/.zshrc ~/.zshrc
symlink ~/.profile ~/.zprofile

# sublime-text
mkdir -p ~/.config/sublime-text/Packages/User
for i in Adaptive.sublime-theme \
         LSP.sublime-settings \
         "Package Control.sublime-settings" \
         Preferences.sublime-settings \
         Python.sublime-settings \
         PythonImproved.sublime-settings \
         SublimeLinter.sublime-settings
do
    symlink ~/.dotfiles/sublime-text/"$i" ~/.config/sublime-text/Packages/User/"$i"
done

# sway
symlink ~/.dotfiles/sway ~/.config/sway
symlink ~/.dotfiles/sway/run-sway.sh ~/bin/run-sway

# tmux
symlink ~/.dotfiles/tmux ~/.config/tmux

# vm
mkdir -p ~/vm/alpine
mkdir -p ~/vm/archlinux/armv7
mkdir -p ~/vm/debian/armv7
mkdir -p ~/vm/netbsd
mkdir -p ~/vm/openbsd
mkdir -p ~/vm/win11
symlink ~/.dotfiles/vm/alpine/run.sh ~/vm/alpine/run.sh
symlink ~/.dotfiles/vm/archlinux/armv7/run.sh ~/vm/archlinux/armv7/run.sh
symlink ~/.dotfiles/vm/debian/armv7/run.sh ~/vm/debian/armv7/run.sh
symlink ~/.dotfiles/vm/netbsd/run.sh ~/vm/netbsd/run.sh
symlink ~/.dotfiles/vm/openbsd/run.sh ~/vm/openbsd/run.sh
symlink ~/.dotfiles/vm/win11/run.sh ~/vm/win11/run.sh

# nvim
mkdir -p ~/.config/nvim
symlink ~/.dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# waybar
symlink ~/.dotfiles/waybar ~/.config/waybar

# xorg
symlink ~/.dotfiles/xorg/.xinitrc ~/.xinitrc
symlink ~/.dotfiles/xorg/.Xresources ~/.Xresources
symlink ~/.dotfiles/xorg/loadxresources ~/bin/loadxresources
symlink ~/.dotfiles/xorg/setwallpaper ~/bin/setwallpaper
