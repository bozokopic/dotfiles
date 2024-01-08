: ${VM_CACHE:?} ${VM_DATA:?}

alpine_url=https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-virt-3.14.1-x86_64.iso

iso_path=$VM_CACHE/alpine.iso

image_path=$VM_DATA/alpine.qcow2


if [ ! -f $iso_path ]; then
    curl -L -o $iso_path $alpine_url
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
    -nographic \
    "$@"
