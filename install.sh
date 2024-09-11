#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

: ${HOME:?}

DOTFILES_DIR=$HOME/.dotfiles
CONFIG_DIR=$HOME/.config
LOCAL_DIR=$HOME/.local
PICTURES_DIR=$HOME/.pictures
REPOS_DIR=$HOME/repos

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

# aerc
mkdir -p $CONFIG_DIR/aerc
symlink $DOTFILES_DIR/aerc/aerc.conf $CONFIG_DIR/aerc/aerc.conf
symlink $DOTFILES_DIR/aerc/binds.conf $CONFIG_DIR/aerc/binds.conf

# chromium
if [ -f /usr/share/applications/chromium.desktop ]; then
    symlink $DOTFILES_DIR/chromium/chromium $BIN_DIR/chromium
    cp /usr/share/applications/chromium.desktop $APP_DIR
    sed -i "s/^Exec=\\/usr/Exec=$(cd $LOCAL_DIR; pwd | sed 's/\//\\\//g')/g" \
        $APP_DIR/chromium.desktop
fi

# cudatext
mkdir -p $CONFIG_DIR/cudatext/settings
symlink $DOTFILES_DIR/cudatext/user.json $CONFIG_DIR/cudatext/settings/user.json

# drawio
if [ -f /usr/share/applications/draw.io.desktop ]; then
    symlink $DOTFILES_DIR/drawio/drawio $BIN_DIR/drawio
    cp /usr/share/applications/draw.io.desktop $APP_DIR
    sed -i "s/^Exec=\\S*/Exec=$(cd $LOCAL_DIR; pwd | sed 's/\//\\\//g')\\/bin\\/drawio/g" \
        $APP_DIR/draw.io.desktop
fi

# dunst
symlink $DOTFILES_DIR/dunst $CONFIG_DIR/dunst

# fontconfig
symlink $DOTFILES_DIR/fontconfig $CONFIG_DIR/fontconfig

# foot
symlink $DOTFILES_DIR/foot $CONFIG_DIR/foot

# gdb
symlink $DOTFILES_DIR/gdb/.gdbinit $HOME/.gdbinit

# git
symlink $DOTFILES_DIR/git/.gitconfig $HOME/.gitconfig

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

# neovide
symlink $DOTFILES_DIR/neovide $CONFIG_DIR/neovide

# numen
symlink $DOTFILES_DIR/numen $CONFIG_DIR/numen

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
symlink $DOTFILES_DIR/river/run-river.sh $BIN_DIR/run-river

# rofi
symlink $DOTFILES_DIR/rofi $CONFIG_DIR/rofi

# setkbmap
symlink $DOTFILES_DIR/setkbmap/setkbmap $BIN_DIR/setkbmap

# shell
symlink $DOTFILES_DIR/shell/.profile $HOME/.profile

# shell - bash
symlink $DOTFILES_DIR/shell/bash/.bashrc $HOME/.bashrc
symlink $HOME/.profile $HOME/.bash_profile

# shell - fish
symlink $DOTFILES_DIR/shell/fish $CONFIG_DIR/fish

# shell - zsh
symlink $DOTFILES_DIR/shell/zsh/.zshrc $HOME/.zshrc
symlink $HOME/.profile $HOME/.zprofile

# sublime-music
symlink $OPT_DIR/venvs/python312/bin/sublime-music $BIN_DIR/sublime-music
symlink $DOTFILES_DIR/sublime-music/sublime-music.desktop $APP_DIR/sublime-music.desktop

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
symlink $DOTFILES_DIR/vm/run.sh $BIN_DIR/vm

# nvim
mkdir -p $CONFIG_DIR/nvim
symlink $DOTFILES_DIR/nvim/init.lua $CONFIG_DIR/nvim/init.lua

# waybar
symlink $DOTFILES_DIR/waybar $CONFIG_DIR/waybar

# wofi
symlink $DOTFILES_DIR/wofi $CONFIG_DIR/wofi

# xorg
symlink $DOTFILES_DIR/xorg/.xinitrc $HOME/.xinitrc
symlink $DOTFILES_DIR/xorg/.Xresources $HOME/.Xresources
symlink $DOTFILES_DIR/xorg/loadxresources $BIN_DIR/loadxresources
symlink $DOTFILES_DIR/xorg/setwallpaper $BIN_DIR/setwallpaper
