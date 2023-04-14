#!/bin/bash

clear
cat cat.ansi.txt
echo
echo "$(tput bold)Linux for your Blade 14$(tput sgr0)"

echo "
This script is provided as-is. Use at your own risk!

While I've tested this on a Razer Blade 14 (2022) laptop running Pop!_OS
and Ubuntu, I can't guarantee that this will work on all devices and
distributions. Please back up any important data before proceeding.
"

# Prompt for the desired kernel version
read -rp "Enter the kernel version you want to download (for example, 6.2): " kernel_version

# Update package list and upgrade existing packages
echo "Updating package list and upgrading existing packages..."
sudo apt-get -qq update
sudo apt-get -qq upgrade

# Install required packages
echo "Installing required packages..."
sudo apt-get -qq install update-manager-core git

# Store files in /tmp
current_date=$(date +"%Y-%m-%d-%H:%M:%S %z")
directory="/tmp/$current_date-blade-14-update"

echo "Creating $directory to store downloaded files..."
kernel_directory="$directory/$kernel_version"
mkdir -p "$kernel_directory"
cd "$kernel_directory" || exit

# Download kernel files
echo "Downloading kernel files for $kernel_version..."

# Create the URL for the specified kernel version
base_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/"
url="${base_url}v${kernel_version}/amd64/"

# Download kernel package files
wget -qc -r -np -nH --no-directories --reject-regex '.*unsigned.*|.*lowlatency.*' -e robots=off --random-wait -R html -A deb,CHECKSUMS $url

echo "Finished downloading kernel files!"

# Install kernel files
echo "Installing kernel files..."
sudo dpkg -i *.deb

cd ..

# Get latest linux-firmware repository
echo "Cloning linux-firmware repository..."
git clone --quiet git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git firmware

# Copy the ath11k driver (see https://wireless.wiki.kernel.org/en/users/drivers/ath11k/installation)
echo "Copying ath11k Wi-Fi driver to /lib/firmware/..."
sudo cp -r linux-firmware/ath11k/ /lib/firmware/

echo "Kernel update complete."

# Prompt the user to reboot their system
read -rp "Reboot your system now? ( y / n ): " reboot_choice
if [ "$reboot_choice" = "y" ]; then
  echo "Rebooting system..."
  sudo reboot
else
  echo "You will need to manually reboot your Blade 14 changes to take effect."
fi
