: ${VM_CACHE:?} ${VM_DATA:?} ${VM_TMP:?}

arch_url=http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz

arch_path=$VM_CACHE/$(basename -- "$arch_url")
kernel_path=$VM_CACHE/zImage
initrd_path=$VM_CACHE/initramfs-linux.img

image_path=$VM_DATA/image


if [ ! -f $arch_path ]; then
    curl -L -o $arch_path $arch_url
fi

if [ ! -f $kernel_path ]; then
    bsdtar -x -f $arch_path -C $(dirname $kernel_path) \
        --strip-components=2 ./boot/$(basename $kernel_path)
fi

if [ ! -f $initrd_path ]; then
    bsdtar -x -f $arch_path -C $(dirname $initrd_path) \
        --strip-components=2 ./boot/$(basename $initrd_path)
fi

if [ ! -f $image_path ]; then
    truncate -s 2G $image_path
    mkfs.ext4 -q $image_path
    mkdir -p $VM_TMP/mnt
    doas mount -o loop $image_path $VM_TMP/mnt
    doas bsdtar -xpf $arch_path -C $VM_TMP/mnt
    doas umount $VM_TMP/mnt
    rmdir $VM_TMP/mnt
fi

exec qemu-system-arm \
    -machine virt \
    -cpu cortex-a15 \
    -m 2G \
    -kernel $kernel_path \
    -initrd $initrd_path \
    -append "root=/dev/sda rw" \
    -drive if=none,file=$image_path,format=raw,id=drive0 \
    -netdev user,id=netdev0 \
    -device virtio-scsi-pci,id=scsi \
    -device virtio-blk-pci,drive=drive0 \
    -device virtio-net-pci,netdev=netdev0 \
    -nographic \
    "$@"



