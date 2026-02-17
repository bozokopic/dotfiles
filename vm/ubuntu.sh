: ${VM_CACHE:?} ${VM_DATA:?}

ubuntu_url=http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/mini.iso

iso_path=$VM_CACHE/ubuntu.iso

image_path=$VM_DATA/ubuntu.qcow2


if [ ! -f $iso_path ]; then
    curl -L -o $iso_path $ubuntu_url
fi

if [ ! -f $image_path ]; then
    qemu-img create -f qcow2 $image_path 20G
fi

exec qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -hda $image_path \
    -cdrom $iso_path \
    -m 4G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0 \
    -usb \
    -device usb-tablet \
    -vga std \
    -virtfs local,path=$VM_TMP,mount_tag=shared,security_model=none \
    "$@"
