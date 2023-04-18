#!/bin/bash

get_linux_firmware() {
  firmware_directory="$save_directory/linux-firmware"
  if [ -d "$firmware_directory" ]; then
    echo "$firmware_directory already exists!"
    echo -n "Pulling from git tree... "
    git -C "$firmware_directory" pull
  else
    echo -n "Cloning linux-firmware repository... "
    git clone --quiet git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git "$firmware_directory"
    echo "Done!"
  fi
}

install_ath11k_firmware() {
  if [ -d "$1" ]; then
    echo -n "Copying ath11k wireless firmware to your /lib/firmware/ ... "
    sudo cp -r "$1/ath11k" /lib/firmware/
    echo "Complete!"
    echo "Please note that a reboot is required for the changes to take effect."
  else
    echo "Error: could not find linux-firmware in $1"
  fi
}
