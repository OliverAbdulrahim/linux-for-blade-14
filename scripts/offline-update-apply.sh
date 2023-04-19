#!/usr/bin/env bash

# Start of the script
repository_root_directory="$(realpath "$(dirname "$0")/..")"
cd "$repository_root_directory" || exit

. scripts/tools.sh
display_welcome_message
echo "
This script applies updates to your Blade 14.
"

. scripts/get-kernel.sh
install_kernel_files "$repository_root_directory/kernel"

. scripts/get-firmware.sh
install_ath11k_firmware "$repository_root_directory/firmware"

prompt_reboot
