#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

PYTHON38=$(which python3.8)
PYTHON39=$(which python3.9)

PYTHON38_DIR=~/python38
PYTHON39_DIR=~/python39

PIP38=$PYTHON38_DIR/bin/pip3.8
PIP39=$PYTHON39_DIR/bin/pip3.9

[ ! -d $PYTHON38_DIR ] && $PYTHON38 -m venv --system-site-packages $PYTHON38_DIR
[ ! -d $PYTHON39_DIR ] && $PYTHON39 -m venv --system-site-packages $PYTHON39_DIR

$PIP38 -q install -U -r ~/.dotfiles/python/requirements.pip38.txt
$PIP39 -q install -U -r ~/.dotfiles/python/requirements.pip39.txt

cat > ~/bin/python3.8 << EOF
#!/bin/sh
exec $(cd $PYTHON38_DIR; pwd)/bin/python3.8 "\$@"
EOF
cat > ~/bin/python3.9 << EOF
#!/bin/sh
exec $(cd $PYTHON39_DIR; pwd)/bin/python3.9 "\$@"
EOF
chmod +x ~/bin/python3.8
chmod +x ~/bin/python3.9

symlink $PIP38 ~/bin/pip3.8
symlink $PIP39 ~/bin/pip3.9

symlink $PYTHON38_DIR/bin/doit ~/bin/doit3.8
symlink $PYTHON39_DIR/bin/doit ~/bin/doit3.9
