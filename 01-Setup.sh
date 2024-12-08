#!/bin/bash
echo -e "\e[8;30;100t"
clear
echo "                                      _____      _               ";
echo "                                     /  ___|    | |              ";
echo "                                     \ \`--.  ___| |_ _   _ _ __  ";
echo "                                      \`--. \/ _ \ __| | | | '_ \ ";
echo "                                     /\__/ /  __/ |_| |_| | |_) |";
echo "                                     \____/ \___|\__|\__,_| .__/ ";
echo "                                                          | |    ";
echo "                                                          |_|    ";
echo
echo "This script installs all dependencies required for the 'PSBBN Installer' and 'Game Installer'."
echo "It must be run first."
echo
echo "Press any key to continue..."
read -n 1 -s

# Update package list and install necessary packages
sudo apt update && sudo apt install -y axel imagemagick python3-venv python3-pip nodejs npm
if [ $? -ne 0 ]; then
    echo
    echo "Error: Package installation failed."
    read -p "Press any key to exit..."
    exit 1
fi

# Check if mkfs.exfat exists, and install exfat-fuse if not
if ! command -v mkfs.exfat &> /dev/null; then
    echo
    echo "mkfs.exfat not found. Installing exfat-fuse..."
    sudo apt install -y exfat-fuse
    if [ $? -ne 0 ]; then
        echo
        echo "Error: Failed to install exfat-fuse."
        read -p "Press any key to exit..."
        exit 1
    fi
fi

# Setup Python virtual environment and install Python dependencies
python3 -m venv venv
if [ $? -ne 0 ]; then
    echo
    echo "Error: Failed to create Python virtual environment."
    read -p "Press any key to exit..."
    exit 1
fi

source venv/bin/activate
pip install lz4 natsort
if [ $? -ne 0 ]; then
    echo
    echo "Error: Failed to install Python dependencies."
    read -p "Press any key to exit..."
    deactivate
    exit 1
fi
deactivate

echo
echo "Setup completed successfully!"
read -p "Press any key to exit..."