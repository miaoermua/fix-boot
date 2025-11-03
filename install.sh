#!/bin/bash

set -x

pacman -S linux-zen linux-zen-headers linux-firmware

mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

set +x