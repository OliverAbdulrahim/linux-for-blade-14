#!/usr/bin/env bash

# Start of the script
repository_root_directory="$(realpath "$(dirname "$0")/..")"
cd "$repository_root_directory" || exit

. scripts/tools.sh
display_welcome_message
echo "
This script downloads and installs all the files you need to patch your
Blade 14's Linux installation.
"

update_packages

read -rp "Enter the kernel version you want to download (for example, 6.2): " kernel_version

. scripts/get-kernel.sh
download_kernel_files "$kernel_version"
install_kernel_files "$save_directory/kernel"

. scripts/get-firmware.sh
get_ath11k_firmware
install_ath11k_firmware "$save_directory/firmware"

prompt_reboot
