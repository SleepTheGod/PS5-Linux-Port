#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Script to patch the Linux kernel for PS5 compatibility

set -e

# Define directories and repositories
DEVELOPMENT_DIR=~/ps5_otheros
KERNEL_REPO="https://github.com/ps5dev/linux.git"
OTHEROS_REPO="https://github.com/OtherOS-Plus-Plus/otheros-plus-plus.git"

# Clone the Linux kernel source customized for PS5
cd $DEVELOPMENT_DIR
git clone $KERNEL_REPO linux-kernel
cd linux-kernel

# Apply OtherOS++ patch
git checkout -b ps5_main origin/ps5_main
git am ../otheros-plus-plus/patches/ps5_kernel_patch.diff

echo "Kernel patched successfully for PS5 compatibility."
