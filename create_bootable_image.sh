#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Script to create a bootable image for PS5

set -e

# Define directories and image path
DEVELOPMENT_DIR=~/ps5_otheros
BOOT_IMAGE=$DEVELOPMENT_DIR/ps5_otheros_image.img

# Create a bootable image
dd if=/dev/zero of=$BOOT_IMAGE bs=1M count=1024
mkfs.ext4 $BOOT_IMAGE

# Mount the image and copy necessary files
mkdir -p /mnt/ps5_image
sudo mount -o loop $BOOT_IMAGE /mnt/ps5_image
sudo cp $DEVELOPMENT_DIR/linux-kernel/arch/arm64/boot/Image /mnt/ps5_image/
sudo cp -r $DEVELOPMENT_DIR/linux-kernel/modules /mnt/ps5_image/
sudo cp $DEVELOPMENT_DIR/ps5-firmware/otheros-plus-plus.bin /mnt/ps5_image/

# Unmount the image
sudo umount /mnt/ps5_image

echo "Bootable image created successfully: $BOOT_IMAGE"
