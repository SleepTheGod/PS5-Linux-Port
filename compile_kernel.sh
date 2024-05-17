#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Script to compile the Linux kernel for PS5

set -e

# Define directories
DEVELOPMENT_DIR=~/ps5_otheros
KERNEL_SRC_DIR=$DEVELOPMENT_DIR/linux-kernel

# Compile the kernel
cd $KERNEL_SRC_DIR
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig # Enable necessary options for OtherOS++
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

echo "Kernel compiled successfully."
