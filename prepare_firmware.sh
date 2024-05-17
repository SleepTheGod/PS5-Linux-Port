#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Script to prepare the firmware with OtherOS++ for PS5

set -e

# Define directories
DEVELOPMENT_DIR=~/ps5_otheros

# Prepare the firmware with OtherOS++
cd $DEVELOPMENT_DIR/ps5-firmware
echo "Integrating OtherOS++ into PS5 firmware..."
echo "otheros-plus-plus.bin" >> Makefile
cp ../otheros-plus-plus/bin/otheros-plus-plus.bin .
make -j$(nproc)

echo "Firmware prepared successfully."
