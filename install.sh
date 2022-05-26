#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

install_python_venv() {
    PYTHON_CMD=$(command -v "$1" || true)
    [ -z "$PYTHON_CMD" ] && return 0;

    PYTHON=$PYTHON_CMD
    PYTHON=${PYTHON%%[0-9]*}
    PYTHON=${PYTHON##*/}
    MAJOR=$($PYTHON_CMD -c "import sys; print(sys.version_info.major)")
    MINOR=$($PYTHON_CMD -c "import sys; print(sys.version_info.minor)")
    REQUIREMENTS=~/.dotfiles/python/requirements.pip$MAJOR$MINOR.txt

    VENV_DIR=$(cd ~/opt; pwd)/$PYTHON$MAJOR$MINOR
    VENV_PYTHON=$VENV_DIR/bin/$PYTHON
    VENV_PIP=$VENV_DIR/bin/pip
    VENV_DOIT=$VENV_DIR/bin/doit

    BIN_DIR=$(cd ~/bin; pwd)
    BIN_PYTHON=$BIN_DIR/$PYTHON$MAJOR.$MINOR
    BIN_PIP=$BIN_DIR/pip-$PYTHON$MAJOR.$MINOR
    BIN_DOIT=$BIN_DIR/doit-$PYTHON$MAJOR.$MINOR

    $PYTHON_CMD -m venv --system-site-packages $VENV_DIR
    $VENV_PIP -q install -U -r $REQUIREMENTS

    echo -e "#!/bin/sh\\nexec $VENV_PYTHON \"\$@\"" > $BIN_PYTHON
    chmod +x $BIN_PYTHON
    symlink $BIN_PYTHON $BIN_DIR/$PYTHON$MAJOR
    symlink $BIN_DIR/$PYTHON$MAJOR $BIN_DIR/$PYTHON

    symlink $VENV_PIP $BIN_PIP
    symlink $BIN_PIP $BIN_DIR/pip$MAJOR
    symlink $BIN_DIR/pip$MAJOR $BIN_DIR/pip

    symlink $VENV_DOIT $BIN_DOIT
    symlink $BIN_DOIT $BIN_DIR/doit
}

mkdir -p ~/bin
mkdir -p ~/opt
mkdir -p ~/repos
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/128x128/apps
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

# dunst
symlink ~/.dotfiles/dunst ~/.config/dunst

# git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig

# i3
symlink ~/.dotfiles/i3 ~/.config/i3

# janet
# if [ ! -d ~/repos/janet ]; then
#     (cd ~/repos; git clone https://github.com/janet-lang/janet.git)
# fi
# if [ ! -d ~/opt/janet ]; then
#     (cd ~/repos/janet; make install PREFIX=$(cd ~/opt; pwd -P)/janet)
# fi

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
install_python_venv pypy3
install_python_venv python3.8
install_python_venv python3.9
install_python_venv python3.10

# qt-designer
symlink ~/.dotfiles/qt-designer/qt-designer.desktop \
        ~/.local/share/applications/qt-designer.desktop

# qutebrowser
mkdir -p ~/.config/qutebrowser
symlink ~/.dotfiles/qutebrowser/autoconfig.yml ~/.config/qutebrowser/autoconfig.yml

# radio
symlink ~/.dotfiles/radio/student ~/bin/radio-student

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

# yay
yay --save --sudo doas
