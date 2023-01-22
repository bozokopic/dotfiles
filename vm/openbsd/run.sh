#!/bin/sh

set -e

cd $(dirname -- "$0")

if [ ! -f openbsd.iso ]; then
    curl -L -o openbsd.iso https://cdn.openbsd.org/pub/OpenBSD/6.9/i386/cd69.iso
fi

if [ ! -f openbsd.qcow2 ]; then
    qemu-img create -f qcow2 openbsd.qcow2 20G
fi

exec qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -hda openbsd.qcow2 \
    -cdrom openbsd.iso \
    -m 2G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0 \
    -usb \
    -device usb-tablet \
    "$@"
