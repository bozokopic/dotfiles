#!/bin/sh

set -e

ln -sf -T $(cd $(dirname "$0"); pwd) ~/.dotfiles

# alacritty
ln -sf -T ~/.dotfiles/alacritty ~/.config/alacritty

# atom
mkdir -p ~/.atom
ln -sf ~/.dotfiles/atom/config.cson ~/.atom/config.cson
ln -sf ~/.dotfiles/atom/init.coffee ~/.atom/init.coffee
ln -sf ~/.dotfiles/atom/keymap.cson ~/.atom/keymap.cson
ln -sf ~/.dotfiles/atom/styles.less ~/.atom/styles.less

# bspwm
ln -sf -T ~/.dotfiles/bspwm ~/.config/bspwm

# git
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig

# i3
ln -sf -T ~/.dotfiles/i3 ~/.config/i3

# mbsync (isync)
mkdir -p ~/mail/ket
ln -sf ~/.dotfiles/mbsync/.mbsyncrc ~/.mbsyncrc

# neomutt
ln -sf -T ~/.dotfiles/neomutt ~/.config/neomutt

# pictures
ln -sf -T ~/.dotfiles/pictures ~/.pictures

# polybar
ln -sf -T ~/.dotfiles/polybar ~/.config/polybar

# qutebrowser
mkdir -p ~/.config/qutebrowser
ln -sf ~/.dotfiles/qutebrowser/autoconfig.yml ~/.config/qutebrowser/autoconfig.yml

# ranger
mkdir -p ~/.config/ranger
ln -sf ~/.dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf

# shell
ln -sf ~/.dotfiles/shell/.profile ~/.profile

# shell - bash
ln -sf ~/.dotfiles/shell/bash/.bashrc ~/.bashrc
ln -sf ~/.profile ~/.bash_profile

# shell - fish
ln -sf -T ~/.dotfiles/shell/fish ~/.config/fish

# shell - zsh
ln -sf ~/.dotfiles/shell/zsh/.zshrc ~/.zshrc
ln -sf ~/.profile ~/.zprofile

# sublime
mkdir -p ~/.config/sublime-text-3/Packages/User
ln -sf "~/.dotfiles/subl3/Package Control.sublime-settings" \
       ~/.config/sublime-text-3/Packages/User/"Package Control.sublime-settings"
for i in Adaptive.sublime-theme \
         Preferences.sublime-settings \
         Python.sublime-settings \
         PythonImproves.sublime-settings \
         SublimeLinter.sublime-settings
do
    ln -sf ~/.dotfiles/subl3/$i ~/.config/sublime-text-3/Packages/User/$i
done

# sway
ln -sf -T ~/.dotfiles/sway ~/.config/sway

# tmux
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# vim / nvim
mkdir -p ~/.vim/autoload
mkdir -p ~/.config
ln -sf ~/.dotfiles/vim/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
ln -sf ~/.vimrc ~/.vim/init.vim
ln -sf ~/.vim ~/.config/nvim

# xorg
ln -sf ~/.dotfiles/xorg/.xsession ~/.xsession
ln -sf ~/.dotfiles/xorg/.Xresources ~/.Xresources
