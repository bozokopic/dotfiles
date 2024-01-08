: ${VM_CACHE:?} ${VM_DATA:?}

openbsd_url=https://cdn.openbsd.org/pub/OpenBSD/7.3/i386/cd73.iso

iso_path=$VM_CACHE/openbsd.iso

image_path=$VM_DATA/openbsd.qcow2


if [ ! -f $iso_path ]; then
    curl -L -o $iso_path $openbsd_url
fi

if [ ! -f $image_path ]; then
    qemu-img create -f qcow2 $image_path 20G
fi

exec qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -hda $image_path \
    -cdrom $iso_path \
    -m 2G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0 \
    -usb \
    -device usb-tablet \
    -display curses \
    "$@"
