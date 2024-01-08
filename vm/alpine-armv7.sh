: ${VM_CACHE:?} ${VM_DATA:?}

alpine_url=https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/armv7/alpine-uboot-3.18.4-armv7.tar.gz

alpine_path=$VM_CACHE/$(basename -- "$alpine_url")
kernel_path=$VM_CACHE/vmlinuz-lts
initrd_path=$VM_CACHE/initramfs-lts

image_path=$VM_DATA/alpine.qcow2


if [ ! -f $alpine_path ]; then
    curl -L -o $alpine_path $alpine_url
fi

if [ ! -f $kernel_path ]; then
    tar -x -f $alpine_path -C $(dirname $kernel_path) \
        --strip-components=2 ./boot/$(basename $kernel_path)
fi

if [ ! -f $initrd_path ]; then
    tar -x -f $alpine_path -C $(dirname $initrd_path) \
        --strip-components=2 ./boot/$(basename $initrd_path)
fi

if [ ! -f $image_path ]; then
    qemu-img create -f qcow2 $image_path 20G
fi

exec qemu-system-arm \
    -M virt \
    -m 1G \
    -cpu cortex-a15 \
    -kernel $kernel_path \
    -initrd $initrd_path \
    -append "console=ttyAMA0" \
    -hda $image_path \
    -nographic \
    "$@"
