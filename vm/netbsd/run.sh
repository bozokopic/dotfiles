#!/bin/sh

set -e

cd $(dirname -- "$0")

if [ ! -f netbsd.iso ]; then
    curl -L -o netbsd.iso https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/images/NetBSD-9.3-amd64.iso
fi

if [ ! -f netbsd.qcow2 ]; then
    qemu-img create -f qcow2 netbsd.qcow2 20G
fi

exec qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -hda netbsd.qcow2 \
    -cdrom netbsd.iso \
    -m 2G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0 \
    -usb \
    -device usb-tablet \
    -display curses \
    "$@"


