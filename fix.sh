#!/bin/bash

# 查看分区信息
set -x
lsblk -f | grep nvme1n1p1

umount /mnt/boot 2>/dev/null || true

dd if=/dev/zero of=/dev/nvme1n1p1 bs=1M count=1

mkfs.vfat -F 32 -n "BOOT" /dev/nvme1n1p1

mkdir -p /mnt/boot

mount /dev/nvme1n1p1 /mnt/boot

mkdir -p /mnt

mount /dev/nvme1n1p3 /mnt

mount -o subvol=@ /dev/nvme1n1p3 /mnt

mkdir -p /mnt/boot
mount /dev/nvme1n1p1 /mnt/boot

# 准备进入 chroot
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run

# arch-chroot /mnt
echo "arch-chroot /mnt"

set +x