: ${VM_CACHE:?} ${VM_DATA:?}

ISO_URL=https://cdimage.debian.org/debian-cd/current/armhf/iso-cd/debian-11.6.0-armhf-netinst.iso
KERNEL_URL=http://ftp.us.debian.org/debian/dists/stable/main/installer-armhf/current/images/cdrom/vmlinuz
INITRD_URL=http://ftp.us.debian.org/debian/dists/stable/main/installer-armhf/current/images/cdrom/initrd.gz

ISO_PATH=$VM_CACHE/$(basename $ISO_URL)
KERNEL_PATH=$VM_CACHE/$(basename $KERNEL_URL)
INITRD_PATH=$VM_CACHE/$(basename $INITRD_URL)

IMG_PATH=$VM_DATA/debian.qcow2

if [ ! -f $ISO_PATH ]; then
    curl -L -o $ISO_PATH $ISO_URL
fi

if [ ! -f $KERNEL_PATH ]; then
    curl -L -o $KERNEL_PATH $KERNEL_URL
fi

if [ ! -f $INITRD_PATH ]; then
    curl -L -o $INITRD_PATH $INITRD_URL
fi

if [ ! -f $IMG_PATH ]; then
    qemu-img create -f qcow2 $IMG_PATH 20G
fi

exec qemu-system-arm \
    -machine virt \
    -cpu cortex-a15 \
    -smp 4 \
    -m 2G \
    -kernel $KERNEL_PATH \
    -initrd $INITRD_PATH \
    -append "console=ttyAMA0" \
    -drive if=none,file=$ISO_PATH,media=cdrom,id=drive0 \
    -drive if=none,file=$IMG_PATH,media=disk,id=drive1 \
    -netdev user,id=netdev0 \
    -device virtio-scsi-device \
    -device scsi-cd,drive=drive0 \
    -device scsi-hd,drive=drive1 \
    -device virtio-net-device,netdev=netdev0 \
    -nographic \
    "$@"
