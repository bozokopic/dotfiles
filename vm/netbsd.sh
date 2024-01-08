: ${VM_CACHE:?} ${VM_DATA:?}

netbsd_url=https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/images/NetBSD-9.3-amd64.iso

iso_path=$VM_CACHE/$(basename -- "$netbsd_url")

image_path=$VM_DATA/netbsd.qcow2


if [ ! -f $iso_path ]; then
    curl -L -o $iso_path $netbsd_url
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
    -vga std \
    "$@"


