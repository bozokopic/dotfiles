#!/bin/sh

set -e

PYTHON38=$(which python3.8)
PYTHON39=$(which python3.9)

PYTHON38_DIR=~/python38
PYTHON39_DIR=~/python39

[ ! -d $PYTHON38_DIR ] && $PYTHON38 -m venv --system-site-packages $PYTHON38_DIR
[ ! -d $PYTHON39_DIR ] && $PYTHON39 -m venv --system-site-packages $PYTHON39_DIR

$PYTHON38_DIR/bin/pip -q install -U -r ~/.dotfiles/python/requirements.pip38.txt
$PYTHON39_DIR/bin/pip -q install -U -r ~/.dotfiles/python/requirements.pip39.txt
