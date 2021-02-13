#!/bin/sh

set -e

symlink () {
    ln -sfT "$@"
}

install_python() {
    LONG=$1
    SHORT=${LONG//\./}

    PYTHON_BIN=$(command -v "python$LONG")
    if [ ! -z $PYTHON_BIN ]; then

        PYTHON_DIR=~/python$SHORT
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

install_python 3.8
install_python 3.9
