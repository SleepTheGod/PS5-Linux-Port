#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# Script to install OtherOS++ on PlayStation 5

set -e

# Define directories and files
DEVELOPMENT_DIR=~/ps5_otheros
MAKEFILE=$DEVELOPMENT_DIR/Makefile
INSTALL_SCRIPT=$DEVELOPMENT_DIR/install.sh

# Check if Makefile exists
if [ ! -f "$MAKEFILE" ]; then
    echo "Error: Makefile not found in $DEVELOPMENT_DIR"
    exit 1
fi

# Run make install
cd $DEVELOPMENT_DIR
make install

echo "OtherOS++ installation on PlayStation 5 completed successfully."
