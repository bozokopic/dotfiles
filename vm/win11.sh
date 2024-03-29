: ${VM_CACHE:?} ${VM_DATA:?} ${VM_TMP:?}

WIN11_ZIP_URL="https://aka.ms/windev_VM_virtualbox"

WIN11_ZIP_PATH=$VM_CACHE/win11.zip
OVMF_PATH=$VM_CACHE/OVMF.fd
INIT_ISO_PATH=$VM_CACHE/init.iso

WIN11_IMG_PATH=$VM_DATA/win11.qcow2
TPM_PATH=$VM_DATA/tpm
SHARE_PATH=$VM_DATA/share                  # \\10.0.2.4\qemu


SAVE=
while getopts s flag; do
    case $flag in
        s)  SAVE=1;;
        ?)  ;;
    esac
done


mkdir -p $SHARE_PATH

if [ ! -f $WIN11_ZIP_PATH ]; then
    wget --show-progress -q -c -O $WIN11_ZIP_PATH $WIN11_ZIP_URL
fi

if [ ! -f $WIN11_IMG_PATH ]; then
    mkdir -p $VM_TMP/img
    unzip -p $WIN11_ZIP_PATH *.ova | tar -x -C $VM_TMP/img
    qemu-img convert -p -c -f vmdk -O qcow2 $VM_TMP/img/*.vmdk $WIN11_IMG_PATH
    rm -rf $VM_TMP/img
fi

if [ ! -f $OVMF_PATH ]; then
    cp /usr/share/edk2-ovmf/x64/OVMF.fd $OVMF_PATH
fi

if [ ! -f $INIT_ISO_PATH ]; then
    mkdir -p $VM_TMP/iso
    cat > $VM_TMP/iso/init.bat << EOF
powershell -executionpolicy bypass d:\\_init.ps1
EOF
    cat > $VM_TMP/iso/_init.ps1 << EOF
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Set-MpPreference -DisableRealtimeMonitoring \$true
Set-Service -Name wuauserv -StartupType Disabled

\$wc = New-Object System.Net.WebClient
\$wc.DownloadFile("https://www.python.org/ftp/python/3.8.9/python-3.8.9-amd64.exe",
                  "c:\\\\Users\\\\User\\\\Downloads\\\\python-3.8.9-amd64.exe")
\$wc.DownloadFile("https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe",
                  "c:\\\\Users\\\\User\\\\Downloads\\\\python-3.9.8-amd64.exe")
\$wc.DownloadFile("https://repo.msys2.org/distrib/x86_64/msys2-x86_64-20210228.exe",
                  "c:\\\\Users\\\\User\\\\Downloads\\\\msys2-x86_64-20210228.exe")
\$wc.DownloadFile("https://nodejs.org/dist/v14.16.1/node-v14.16.1-x64.msi",
                  "c:\\\\Users\\\\User\\\\Downloads\\\\node-v14.16.1-x64.msi")
\$wc.DownloadFile("https://yarnpkg.com/latest.msi",
                  "c:\\\\Users\\\\User\\\\Downloads\\\\yarn.msi")

\$env:Path = "C:\\Python39;C:\\Python39\\Scripts;C:\\msys64\\mingw64\\bin;C:\\msys64\\usr\\bin;" + \$env:Path
\$env:Path += ";C:\\nodejs;C:\\Yarn\\bin"
[Environment]::SetEnvironmentVariable(
    "Path", \$env:Path, [System.EnvironmentVariableTarget]::Machine)

cmd /C "c:\\Users\\User\\Downloads\\python-3.8.9-amd64.exe InstallAllUsers=1 TargetDir=c:\\Python38 /passive"
cmd /C "c:\\Users\\User\\Downloads\\python-3.9.8-amd64.exe InstallAllUsers=1 TargetDir=c:\\Python39 /passive"
cmd /C "c:\\Users\\User\\Downloads\\node-v14.16.1-x64.msi INSTALLDIR=C:\\nodejs /passive"
cmd /C "c:\\Users\\User\\Downloads\\yarn.msi INSTALLDIR=c:\\Yarn /passive"

cmd /C "c:\\Users\\User\\Downloads\\msys2-x86_64-20210228.exe install -c --root c:\\msys64"
cmd.exe /C "pacman -Syu --noconfirm"
cmd.exe /C "pacman -Syu --noconfirm"
cmd.exe /C "pacman -Syu --noconfirm base-devel git mingw-w64-x86_64-toolchain socat"
EOF
    mkisofs -J -l -R -V "init" -iso-level 4 -o $INIT_ISO_PATH $VM_TMP/iso
    rm -rf $VM_TMP/iso
fi

if [ ! -z $SAVE ]; then
    TMP_IMG_PATH=$WIN11_IMG_PATH
else
    TMP_IMG_PATH=$WIN11_IMG_PATH.tmp
    rm -f $TMP_IMG_PATH
    qemu-img create -q -F qcow2 -f qcow2 -b $WIN11_IMG_PATH $TMP_IMG_PATH
fi

mkdir -p $TPM_PATH
swtpm socket \
    --tpm2 \
    --tpmstate dir=$TPM_PATH \
    --ctrl type=unixio,path=$TPM_PATH/socket &
exec qemu-system-x86_64 \
    -enable-kvm \
    -machine q35 \
    -device intel-iommu \
    -drive file=$OVMF_PATH,if=pflash,format=raw \
    -drive file=$TMP_IMG_PATH,media=disk \
    -drive file=$INIT_ISO_PATH,media=cdrom \
    -chardev socket,id=chrtpm,path=$TPM_PATH/socket \
    -tpmdev emulator,id=tpm0,chardev=chrtpm \
    -device tpm-tis,tpmdev=tpm0 \
    -m 4G \
    -device e1000,netdev=net0 \
    -netdev user,id=net0,smb=$SHARE_PATH \
    -usb \
    -device usb-tablet \
    -rtc base=localtime
