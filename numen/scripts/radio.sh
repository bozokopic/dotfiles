#!/bin/sh

set -e

if [ ! -d "$NUMEN_STATE_DIR" ]; then
    exit 1
fi

PID_PATH=$NUMEN_STATE_DIR/radio.pid
PID=$(cat $PID_PATH 2> /dev/null || true)

if [ ! -z "$PID" ]; then
    kill -- $PID $(ps --ppid $PID -o pid=) || true
    waitpid $PID || true
    rm -f $PID_PATH
fi

if [ -z "$1" ]; then
    exit 0
fi

if ! command -v "radio-$1" > /dev/null; then
    exit 1
fi

(echo $$ > $PID_PATH)

trap "exit 1" HUP INT PIPE QUIT TERM
trap "rm -rf $PID_PATH" EXIT

radio-$1 > /dev/null 2>&1
