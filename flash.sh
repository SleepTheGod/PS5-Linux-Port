#!/bin/bash

# Define variables
EEPROM_PROGRAMMER_PATH="/dev/ttyUSB0"   # Default path to the USB EEPROM programmer device
DVD_DRIVE_DEVICE="/dev/sr0"             # Default path to the DVD drive device
FLASHROM_BINARY="flashrom"              # Name of the flashrom binary

# Function to install required packages
install_dependencies() {
    echo "Installing required packages..."
    # Check package manager and install required packages
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y flashrom hdparm
    elif command -v yum &> /dev/null; then
        sudo yum update
        sudo yum install -y flashrom hdparm
    else
        echo "Error: Unable to find a supported package manager (apt-get or yum). Please install 'flashrom' and 'hdparm' manually."
        exit 1
    fi
}

# Function to check if a command is available
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if flashrom and hdparm are installed
if ! command_exists flashrom || ! command_exists hdparm; then
    read -p "flashrom or hdparm is not installed. Do you want to install required packages? (y/n): " choice
    case "$choice" in
        y|Y )
            install_dependencies
            ;;
        * )
            echo "Please install 'flashrom' and 'hdparm' manually."
            exit 1
            ;;
    esac
fi

# Prompt user for firmware file path
read -ep "Enter the path to the firmware file (default: firmware.bin): " FIRMWARE_FILE
FIRMWARE_FILE=${FIRMWARE_FILE:-firmware.bin}
if [ ! -f "$FIRMWARE_FILE" ]; then
    echo "Firmware file $FIRMWARE_FILE not found."
    exit 1
fi

# Check if the DVD drive device exists
if [ ! -e "$DVD_DRIVE_DEVICE" ]; then
    echo "DVD drive device $DVD_DRIVE_DEVICE not found."
    exit 1
fi

# Stop any processes accessing the DVD drive (e.g., udev, automount)
sudo umount "$DVD_DRIVE_DEVICE" &> /dev/null

# Read current firmware version (optional)
# Example command: hdparm -I "$DVD_DRIVE_DEVICE" | grep "Firmware Version"

# Flash the firmware using the EEPROM programmer
echo "Flashing firmware..."
# Example command for flashing: $FLASHROM_BINARY -p "$EEPROM_PROGRAMMER_PATH" -w "$FIRMWARE_FILE"

# Verify firmware flash (optional)
# Example command: $FLASHROM_BINARY -p "$EEPROM_PROGRAMMER_PATH" -v "$FIRMWARE_FILE"

# Restart any processes accessing the DVD drive (e.g., udev, automount)
# Example command: sudo mount "$DVD_DRIVE_DEVICE" /media/dvd

echo "Firmware flashing completed successfully."
