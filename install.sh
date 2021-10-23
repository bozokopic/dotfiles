#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

install_packages() {
    yay -S --needed --noconfirm \
        $(cat $1 | \
          xargs -I{} sh -c \
            "(pacman -Q {} &> /dev/null) || echo {}")
}

install_python() {
    LONG=$1
    SHORT=${LONG//\./}

    PYTHON_BIN=$(command -v "python$LONG")
    if [ ! -z $PYTHON_BIN ]; then

        PYTHON_DIR=~/opt/python$SHORT
        PIP_BIN=$PYTHON_DIR/bin/pip$LONG
        REQUIREMENTS=~/.dotfiles/python/requirements.pip$SHORT.txt
        LOCAL_PYTHON_BIN=~/bin/python$LONG
        LOCAL_PIP_BIN=~/bin/pip$LONG
        LOCAL_DOIT_BIN=~/bin/doit$LONG

        [ ! -d $PYTHON_DIR ] && \
            $PYTHON_BIN -m venv --system-site-packages $PYTHON_DIR

        $PIP_BIN -q install -U -r $REQUIREMENTS

        echo "#!/bin/sh" > $LOCAL_PYTHON_BIN
        echo "exec $(cd $PYTHON_DIR; pwd)/bin/python$LONG \"\$@\"" >> $LOCAL_PYTHON_BIN
        chmod +x $LOCAL_PYTHON_BIN

        symlink $PIP_BIN $LOCAL_PIP_BIN
        symlink $PYTHON_DIR/bin/doit $LOCAL_DOIT_BIN

    fi
}

mkdir -p ~/bin
mkdir -p ~/opt
mkdir -p ~/repos
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/128x128/apps
symlink $(cd $(dirname "$0"); pwd -P) ~/.dotfiles
yay --save --sudo doas
install_packages ~/.dotfiles/packages.txt

# alacritty
symlink ~/.dotfiles/alacritty ~/.config/alacritty

# bspwm
symlink ~/.dotfiles/bspwm ~/.config/bspwm

# chromium
symlink ~/.dotfiles/chromium/chromium ~/bin/chromium
cp /usr/share/applications/chromium.desktop ~/.local/share/applications
sed -i "s/^Exec=\\/usr/Exec=$(cd; pwd | sed 's/\//\\\//g')/g" \
    ~/.local/share/applications/chromium.desktop

# cudatext
mkdir -p ~/.config/cudatext/settings
symlink ~/.dotfiles/cudatext/user.json ~/.config/cudatext/settings/user.json

# dunst
symlink ~/.dotfiles/dunst ~/.config/dunst

# git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig

# i3
symlink ~/.dotfiles/i3 ~/.config/i3

# janet
if [ ! -d ~/repos/janet ]; then
    (cd ~/repos; git clone https://github.com/janet-lang/janet.git)
fi
if [ ! -d ~/opt/janet ]; then
    (cd ~/repos/janet; make install PREFIX=$(cd ~/opt; pwd -P)/janet)
fi

# lein
symlink ~/.dotfiles/lein/lein ~/bin/lein

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

# python
install_python 3.8
install_python 3.9
symlink ~/bin/python3.9 ~/bin/python3
symlink ~/bin/python3 ~/bin/python

# qutebrowser
mkdir -p ~/.config/qutebrowser
symlink ~/.dotfiles/qutebrowser/autoconfig.yml ~/.config/qutebrowser/autoconfig.yml

# ranger
mkdir -p ~/.config/ranger
symlink ~/.dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf

# river
symlink ~/.dotfiles/river ~/.config/river

# rofi
mkdir -p ~/.config/rofi
symlink ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi

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

# sublime-music
symlink ~/.dotfiles/sublime-music/sublime-music.desktop \
        ~/.local/share/applications/sublime-music.desktop
symlink ~/.dotfiles/pictures/icons/sublime-music.png \
        ~/.local/share/icons/hicolor/128x128/apps/sublime-music.png

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

# tmux
symlink ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# vim / nvim
mkdir -p ~/.vim/autoload
mkdir -p ~/.config
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
symlink ~/.vimrc ~/.vim/init.vim
symlink ~/.vim ~/.config/nvim

# win10
symlink ~/.dotfiles/vm/vm-win10 ~/bin/vm-win10

# waybar
symlink ~/.dotfiles/waybar ~/.config/waybar

# xorg
symlink ~/.dotfiles/xorg/.xinitrc ~/.xinitrc
symlink ~/.dotfiles/xorg/.Xresources ~/.Xresources
symlink ~/.dotfiles/xorg/loadxresources ~/bin/loadxresources
symlink ~/.dotfiles/xorg/setwallpaper ~/bin/setwallpaper
