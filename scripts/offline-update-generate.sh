#!/usr/bin/env bash

# Start of the script
repository_root_directory="$(realpath "$(dirname "$0")/..")"
cd "$repository_root_directory" || exit

. scripts/tools.sh
display_welcome_message
echo "
This script downloads and packages all the files you need to patch your
Blade 14's Linux installation.

When finished, you'll have a .tar archive that you can transfer and
extract in your Linux operating system to complete the process. You'll
need internet access now, but you can install the updates offline when
in Linux.
"
read -rp "Enter the kernel version you want to download (for example, 6.2): " kernel_version

. scripts/get-kernel.sh
download_kernel_files "$kernel_version"

. scripts/get-firmware.sh
get_ath11k_firmware

echo -n "
Copying files and creating .tar archive... "

archive_directory="$repository_root_directory/out"
mkdir -p "$archive_directory"

archive_name="$(basename "$save_directory").tar.gz"
archive_path="$archive_directory/$archive_name"

cp -r "$repository_root_directory/scripts" "$save_directory"
cp -r "$repository_root_directory/resources" "$save_directory"
cp "$repository_root_directory/README.md" "$save_directory"
tar --exclude-vcs -czf "$archive_path" -C "$save_directory" ./

echo "Done!

You can find the archive at the following path:
'$archive_path'

Copy this over to your Linux installation using an external drive.

Extract it there and run 'offline-update-apply.sh' to finish.
"
