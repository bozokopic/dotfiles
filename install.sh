#!/bin/bash

set -e

DOTFILES=~/.dotfiles

# alacritty
ln -sf -T $DOTFILES/alacritty ~/.config/alacritty

# atom
mkdir -p ~/.atom
ln -sf $DOTFILES/atom/config.cson ~/.atom/config.cson
ln -sf $DOTFILES/atom/init.coffee ~/.atom/init.coffee
ln -sf $DOTFILES/atom/keymap.cson ~/.atom/keymap.cson
ln -sf $DOTFILES/atom/styles.less ~/.atom/styles.less

# bash
ln -sf $DOTFILES/bash/.profile ~/.profile
ln -sf $DOTFILES/bash/.bashrc ~/.bashrc
ln -sf ~/.profile ~/.bash_profile

# git
ln -sf $DOTFILES/git/.gitconfig ~/.gitconfig

# offlineimap
mkdir -p ~/mail/ket
ln -sf $DOTFILES/offlineimap/.offlineimaprc ~/.offlineimaprc
ln -sf $DOTFILES/offlineimap/.offlineimap.py ~/.offlineimap.py

# qtile
ln -sf -T $DOTFILES/qtile ~/.config/qtile

# i3
ln -sf -T $DOTFILES/i3 ~/.config/i3

# sway
ln -sf -T $DOTFILES/sway ~/.config/sway

# waybar
ln -sf -T $DOTFILES/waybar ~/.config/waybar

# py3status
ln -sf -T $DOTFILES/py3status ~/.config/py3status

# qutebrowser
mkdir -p ~/.config/qutebrowser
ln -sf $DOTFILES/qutebrowser/autoconfig.yml ~/.config/qutebrowser/autoconfig.yml

# ranger
mkdir -p ~/.config/ranger
ln -sf $DOTFILES/ranger/rc.conf ~/.config/ranger/rc.conf

# tmux
ln -sf $DOTFILES/tmux/.tmux.conf ~/.tmux.conf

# vim / nvim
mkdir -p ~/.vim/autoload
mkdir -p ~/.config
ln -sf $DOTFILES/vim/.vimrc ~/.vimrc
ln -sf $DOTFILES/vim/plug.vim ~/.vim/autoload/plug.vim
ln -sf ~/.vimrc ~/.vim/init.vim
ln -sf ~/.vim ~/.config/nvim

# xonsh
ln -sf $DOTFILES/xonsh/.xonshrc ~/.xonshrc

# fish
ln -sf -T $DOTFILES/fish ~/.config/fish

# xorg
ln -sf $DOTFILES/xorg/.xsession ~/.xsession
ln -sf $DOTFILES/xorg/.Xresources ~/.Xresources
