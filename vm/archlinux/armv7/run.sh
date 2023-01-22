#!/bin/sh

set -e

cd $(dirname -- "$0")

ROOT_URL=http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz
IMG_PATH=archlinuxarm.img
KERNEL_PATH=boot/zImage
INITRAMFS_PATH=boot/initramfs-linux.img

ROOT_PATH=$(basename $ROOT_URL)

if [ ! -f $ROOT_PATH ]; then
    curl -L -o $ROOT_PATH $ROOT_URL
fi

if [ ! \( \( -f $KERNEL_PATH \) -a \
          \( -f $INITRAMFS_PATH \) \) ]; then
    bsdtar -xf $ROOT_PATH $KERNEL_PATH $INITRAMFS_PATH
fi

if [ ! -f $IMG_PATH ]; then
    truncate -s 2G $IMG_PATH
    mkfs.ext4 -q $IMG_PATH
    mkdir -p mnt
    doas mount -o loop $IMG_PATH mnt
    doas bsdtar -xpf $ROOT_PATH -C mnt
    doas umount mnt
    rmdir mnt
fi

exec qemu-system-arm \
    -machine virt \
    -cpu cortex-a15 \
    -m 2G \
    -kernel $KERNEL_PATH \
    -initrd $INITRAMFS_PATH \
    -append "root=/dev/sda rw" \
    -drive if=none,file=$IMG_PATH,format=raw,id=drive0 \
    -netdev user,id=netdev0 \
    -device virtio-scsi-pci,id=scsi \
    -device virtio-blk-pci,drive=drive0 \
    -device virtio-net-pci,netdev=netdev0 \
    -nographic \
    "$@"



