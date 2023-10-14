#!/bin/sh

set -e

cd $(dirname -- "$0")

if [ ! -f alpine.iso ]; then
    curl -L -o alpine.iso https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-virt-3.14.1-x86_64.iso
fi

if [ ! -f alpine.qcow2 ]; then
    qemu-img create -f qcow2 alpine.qcow2 20G
fi

exec qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -hda alpine.qcow2 \
    -cdrom alpine.iso \
    -m 2G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0 \
    -usb \
    -device usb-tablet \
    "$@"
