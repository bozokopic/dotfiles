#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

DOTFILES_DIR=~/.dotfiles
CONFIG_DIR=~/.config
LOCAL_DIR=~/.local
PICTURES_DIR=~/.pictures
REPOS_DIR=~/repos
VM_DIR=~/vm

BIN_DIR=$LOCAL_DIR/bin
OPT_DIR=$LOCAL_DIR/opt
SHARE_DIR=$LOCAL_DIR/share

APP_DIR=$SHARE_DIR/applications

mkdir -p $CONFIG_DIR \
         $REPOS_DIR \
         $BIN_DIR \
         $OPT_DIR \
         $APP_DIR

symlink $(cd $(dirname "$0"); pwd -P) $DOTFILES_DIR

# alacritty
symlink $DOTFILES_DIR/alacritty $CONFIG_DIR/alacritty

# bspwm
symlink $DOTFILES_DIR/bspwm $CONFIG_DIR/bspwm

# chromium
if [ -f /usr/share/applications/chromium.desktop ]; then
    symlink $DOTFILES_DIR/chromium/chromium $BIN_DIR/chromium
    cp /usr/share/applications/chromium.desktop $APP_DIR
    sed -i "s/^Exec=\\/usr/Exec=$(cd; pwd | sed 's/\//\\\//g')/g" \
        $APP_DIR/chromium.desktop
fi

# claws
symlink $DOTFILES_DIR/claws/claws-mail $BIN_DIR/claws-mail

# cudatext
mkdir -p $CONFIG_DIR/cudatext/settings
symlink $DOTFILES_DIR/cudatext/user.json $CONFIG_DIR/cudatext/settings/user.json

# drawio
if [ -f /usr/share/applications/drawio.desktop ]; then
    symlink $DOTFILES_DIR/drawio/drawio $BIN_DIR/drawio
    cp /usr/share/applications/drawio.desktop $APP_DIR
    sed -i "s/^Exec=\\S*/Exec=$(cd; pwd | sed 's/\//\\\//g')\\/bin\\/drawio/g" \
        $APP_DIR/drawio.desktop
fi

# dunst
symlink $DOTFILES_DIR/dunst $CONFIG_DIR/dunst

# fontconfig
symlink $DOTFILES_DIR/fontconfig $CONFIG_DIR/fontconfig

# foot
symlink $DOTFILES_DIR/foot $CONFIG_DIR/foot

# git
symlink $DOTFILES_DIR/git/.gitconfig ~/.gitconfig

# i3
symlink $DOTFILES_DIR/i3 $CONFIG_DIR/i3

# idasen
symlink $DOTFILES_DIR/idasen $CONFIG_DIR/idasen

# kanshi
symlink $DOTFILES_DIR/kanshi $CONFIG_DIR/kanshi

# lein
symlink $DOTFILES_DIR/lein/lein $BIN_DIR/lein

# lf
symlink $DOTFILES_DIR/lf $CONFIG_DIR/lf

# lite-xl
mkdir -p $CONFIG_DIR/lite-xl
symlink $DOTFILES_DIR/lite-xl/init.lua $CONFIG_DIR/lite-xl/init.lua
symlink $DOTFILES_DIR/lite-xl/install.sh $CONFIG_DIR/lite-xl/install.sh

# lock
symlink $DOTFILES_DIR/lock/lock $BIN_DIR/lock
symlink $DOTFILES_DIR/lock/lock.desktop $APP_DIR/lock.desktop

# neomutt
symlink $DOTFILES_DIR/neomutt $CONFIG_DIR/neomutt

# pictures
symlink $DOTFILES_DIR/pictures $PICTURES_DIR

# polybar
symlink $DOTFILES_DIR/polybar $CONFIG_DIR/polybar

# qutebrowser
mkdir -p $CONFIG_DIR/qutebrowser
symlink $DOTFILES_DIR/qutebrowser/autoconfig.yml \
        $CONFIG_DIR/qutebrowser/autoconfig.yml

# radio
symlink $DOTFILES_DIR/radio/student $BIN_DIR/radio-student
symlink $DOTFILES_DIR/radio/sljeme $BIN_DIR/radio-sljeme
symlink $DOTFILES_DIR/radio/jaska $BIN_DIR/radio-jaska

# ranger
symlink $DOTFILES_DIR/ranger $CONFIG_DIR/ranger

# river
symlink $DOTFILES_DIR/river $CONFIG_DIR/river

# rofi
symlink $DOTFILES_DIR/rofi $CONFIG_DIR/rofi

# setkbmap
symlink $DOTFILES_DIR/setkbmap/setkbmap $BIN_DIR/setkbmap

# shell
symlink $DOTFILES_DIR/shell/.profile ~/.profile

# shell - bash
symlink $DOTFILES_DIR/shell/bash/.bashrc ~/.bashrc
symlink ~/.profile ~/.bash_profile

# shell - fish
symlink $DOTFILES_DIR/shell/fish $CONFIG_DIR/fish

# shell - zsh
symlink $DOTFILES_DIR/shell/zsh/.zshrc ~/.zshrc
symlink ~/.profile ~/.zprofile

# sublime-text
mkdir -p $CONFIG_DIR/sublime-text/Packages/User
for i in Adaptive.sublime-theme \
         LSP.sublime-settings \
         "Package Control.sublime-settings" \
         Preferences.sublime-settings \
         Python.sublime-settings \
         PythonImproved.sublime-settings \
         SublimeLinter.sublime-settings
do
    symlink $DOTFILES_DIR/sublime-text/"$i" $CONFIG_DIR/sublime-text/Packages/User/"$i"
done

# sway
symlink $DOTFILES_DIR/sway $CONFIG_DIR/sway
symlink $DOTFILES_DIR/sway/run-sway.sh $BIN_DIR/run-sway

# tmux
symlink $DOTFILES_DIR/tmux $CONFIG_DIR/tmux

# vm
mkdir -p $VM_DIR/alpine
mkdir -p $VM_DIR/archlinux/armv7
mkdir -p $VM_DIR/debian/armv7
mkdir -p $VM_DIR/netbsd
mkdir -p $VM_DIR/openbsd
mkdir -p $VM_DIR/win11
symlink $DOTFILES_DIR/vm/alpine/run.sh $VM_DIR/alpine/run.sh
symlink $DOTFILES_DIR/vm/archlinux/armv7/run.sh $VM_DIR/archlinux/armv7/run.sh
symlink $DOTFILES_DIR/vm/debian/armv7/run.sh $VM_DIR/debian/armv7/run.sh
symlink $DOTFILES_DIR/vm/netbsd/run.sh $VM_DIR/netbsd/run.sh
symlink $DOTFILES_DIR/vm/openbsd/run.sh $VM_DIR/openbsd/run.sh
symlink $DOTFILES_DIR/vm/win11/run.sh $VM_DIR/win11/run.sh

# nvim
mkdir -p $CONFIG_DIR/nvim
symlink $DOTFILES_DIR/nvim/init.lua $CONFIG_DIR/nvim/init.lua

# waybar
symlink $DOTFILES_DIR/waybar $CONFIG_DIR/waybar

# xorg
symlink $DOTFILES_DIR/xorg/.xinitrc ~/.xinitrc
symlink $DOTFILES_DIR/xorg/.Xresources ~/.Xresources
symlink $DOTFILES_DIR/xorg/loadxresources $BIN_DIR/loadxresources
symlink $DOTFILES_DIR/xorg/setwallpaper $BIN_DIR/setwallpaper
