#!/bin/bash

set -e
set -x

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi
export device

curl "https://www.archlinux.org/mirrorlist/?country=RO&country=UA&country=GB&protocol=http&protocol=https&ip_version=4" --output mirrorlist
sed -i 's/^#Server/Server/' mirrorlist
cp mirrorlist /etc/pacman.d/mirrorlist

memory_size_in_kilobytes=$(free | awk '/^Mem:/ { print $2 }')
swap_size_in_kilobytes=$((memory_size_in_kilobytes * 2))
sfdisk "$device" <<EOF
label: dos
size=${swap_size_in_kilobytes}KiB, type=82
                                   type=83, bootable
EOF

mkswap "${device}1"
mkfs.ext4 -L "rootfs" "${device}2"
mount "${device}2" /mnt

pacstrap /mnt base base-devel linux grub openssh sudo polkit haveged bash-completion nano tar wget icu jq ncdu xorg noto-fonts
swapon "${device}1"
genfstab -p /mnt >>/mnt/etc/fstab
swapoff "${device}1"

arch-chroot /mnt /bin/bash
