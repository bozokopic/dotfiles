#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

mkdir -p ~/bin
symlink $(cd $(dirname "$0"); pwd -P) ~/.dotfiles
~/.dotfiles/yay/install.sh

# alacritty
symlink ~/.dotfiles/alacritty ~/.config/alacritty

# atom
mkdir -p ~/.atom
symlink ~/.dotfiles/atom/config.cson ~/.atom/config.cson
symlink ~/.dotfiles/atom/init.coffee ~/.atom/init.coffee
symlink ~/.dotfiles/atom/keymap.cson ~/.atom/keymap.cson
symlink ~/.dotfiles/atom/styles.less ~/.atom/styles.less

# bspwm
symlink ~/.dotfiles/bspwm ~/.config/bspwm

# git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig

# i3
symlink ~/.dotfiles/i3 ~/.config/i3

# lein
symlink ~/.dotfiles/lein/lein ~/bin/lein

# neomutt
symlink ~/.dotfiles/neomutt ~/.config/neomutt

# pictures
symlink ~/.dotfiles/pictures ~/.pictures

# polybar
symlink ~/.dotfiles/polybar ~/.config/polybar

# python
~/.dotfiles/python/install.sh

# qutebrowser
mkdir -p ~/.config/qutebrowser
symlink ~/.dotfiles/qutebrowser/autoconfig.yml ~/.config/qutebrowser/autoconfig.yml

# ranger
mkdir -p ~/.config/ranger
symlink ~/.dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf

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

# sublime
mkdir -p ~/.config/sublime-text-3/Packages/User
for i in Adaptive.sublime-theme \
         "Package Control.sublime-settings" \
         Preferences.sublime-settings \
         Python.sublime-settings \
         PythonImproves.sublime-settings \
         SublimeLinter.sublime-settings
do
    symlink ~/.dotfiles/subl3/"$i" ~/.config/sublime-text-3/Packages/User/"$i"
done

# sway
symlink ~/.dotfiles/sway ~/.config/sway

# tmux
symlink ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# vim / nvim
mkdir -p ~/.vim/autoload
mkdir -p ~/.config
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
symlink ~/.vimrc ~/.vim/init.vim
symlink ~/.vim ~/.config/nvim

# xorg
symlink ~/.dotfiles/xorg/.xsession ~/.xsession
symlink ~/.dotfiles/xorg/.Xresources ~/.Xresources
symlink ~/.dotfiles/xorg/loadxresources ~/bin/loadxresources
symlink ~/.dotfiles/xorg/setwallpaper ~/bin/setwallpaper
