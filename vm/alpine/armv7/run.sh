#!/bin/sh

set -e

cd $(dirname -- "$0")

[ -f alpine.tar.gz ] || \
    curl -L -o alpine.tar.gz https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/armv7/alpine-uboot-3.18.4-armv7.tar.gz

[ -f vmlinuz-lts ] || \
    tar -x -f alpine.tar.gz --strip-components=2 ./boot/vmlinuz-lts

[ -f initramfs-lts ] || \
    tar -x -f alpine.tar.gz --strip-components=2 ./boot/initramfs-lts

[ -f alpine.qcow2 ] || \
    qemu-img create -f qcow2 alpine.qcow2 20G

exec qemu-system-arm \
    -M virt \
    -m 1G \
    -cpu cortex-a15 \
    -kernel vmlinuz-lts \
    -initrd initramfs-lts \
    -append "console=ttyAMA0" \
    -hda alpine.qcow2 \
    -nographic \
    "$@"
