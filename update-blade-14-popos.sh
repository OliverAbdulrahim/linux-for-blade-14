#!/bin/bash

# Prompt the user for the desired kernel version
read -p "Enter the kernel version you want to install (e.g. 6.2.10-060210): " kernel_version

# Update package list and upgrade existing packages
echo "Updating package list and upgrading existing packages..."
sudo apt-get update
sudo apt-get upgrade

# Install required packages
echo "Installing required packages..."
sudo apt-get install update-manager-core git

# Create temporary directory to store downloaded files
current_date=$(date +"%Y-%m-%d")
directory="/tmp/$current_date-kernel-update"

echo "Creating directory $directory to store downloaded files..."
mkdir -p $directory
cd $directory

# Download kernel files
echo "Downloading kernel version $kernel_version..."
mkdir -p kernel
cd kernel

wget -qc https://kernel.ubuntu.com/~kernel-ppa/mainline/v$kernel_version/amd64/linux-headers-$kernel_version-generic_$kernel_version-generic-$kernel_version.202304061139_amd64.deb \
https://kernel.ubuntu.com/~kernel-ppa/mainline/v$kernel_version/amd64/linux-headers-$kernel_version_$kernel_version-$kernel_version.202304061139_all.deb \
https://kernel.ubuntu.com/~kernel-ppa/mainline/v$kernel_version/amd64/linux-image-unsigned-$kernel_version-generic_$kernel_version-generic-$kernel_version.202304061139_amd64.deb \
https://kernel.ubuntu.com/~kernel-ppa/mainline/v$kernel_version/amd64/linux-modules-$kernel_version-generic_$kernel_version-generic-$kernel_version.202304061139_amd64.deb

# Install kernel files
echo "Installing kernel files..."
sudo dpkg -i *.deb

cd ..

# Get latest linux-firmware repository
echo "Cloning linux-firmware repository..."
git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git firmware

# Copy the ath11k driver (see https://wireless.wiki.kernel.org/en/users/drivers/ath11k/installation)
echo "Copying ath11k driver to /lib/firmware/..."
sudo cp -r linux-firmware/ath11k/ /lib/firmware/

echo "Kernel update complete."

# Prompt the user to reboot their system
read -p "Do you want to reboot your system now? (y/n): " reboot_choice
if [ "$reboot_choice" = "y" ]; then
  echo "Rebooting system..."
  sudo reboot
else
  echo "You will need to manually reboot your system for the changes to take effect."
fi
