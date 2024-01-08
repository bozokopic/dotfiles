#!/bin/sh

set -e

VM_ROOT=$(dirname "$(realpath "$0")")
VM_NAME=$1

if [ ! -f "$VM_ROOT/$VM_NAME.sh" ]; then
    echo "invalid vm name" >&2
    exit 1
fi

shift

VM_CACHE=$HOME/.local/vm/cache/$VM_NAME
VM_DATA=$HOME/.local/vm/data/$VM_NAME
VM_TMP=$HOME/.local/vm/tmp/$VM_NAME

rm -rf $VM_TMP
mkdir -p $VM_CACHE $VM_DATA $VM_TMP

trap "exit 1" HUP INT PIPE QUIT TERM
trap "rm -rf $VM_TMP" EXIT

. $VM_ROOT/$VM_NAME.sh
