#!/usr/bin/env bash

get_ath11k_firmware() {
  echo "
Getting ath11k wireless firmware now..."
  firmware_directory="$save_directory/firmware"
  firmware_repo_url="git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"

  # Only clone the latest commit and only include the root directory and ath11k/ of the firmware repo
  # --no-checkout: don't create a local copy of the repository
  # --depth 1: fetch only the most recent commit (no history beyond that)
  # --sparse: enable sparse checkout mode
  # --single-branch --branch main: only fetch the "main" branch
  git clone \
    --no-checkout \
    --depth 1 \
    --sparse \
    --single-branch --branch main \
    "$firmware_repo_url" "$firmware_directory"
  git -C "$firmware_directory" sparse-checkout add "/ath11k"
  git -C "$firmware_directory" checkout

  echo -n "Cleaning up... "
  find "$firmware_directory" -type f | grep -v "ath11k" | xargs rm
  rm -r "$firmware_directory/.git"
  echo "Done!"
}

install_ath11k_firmware() {
  if [ -d "$1" ]; then
    echo -n "Copying ath11k wireless firmware to your '/lib/firmware' ... "
    sudo cp -r "$1/ath11k" /lib/firmware
    echo "Complete!"
    echo "Please note that a reboot is required for the changes to take effect."
  else
    echo "Error: could not find firmware files in $1"
  fi
}
