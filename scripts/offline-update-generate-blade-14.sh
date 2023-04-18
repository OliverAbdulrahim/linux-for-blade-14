#!/bin/bash

# Start of the script
. ./tools.sh

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

. "./get-kernel.sh" "$kernel_version"
download_kernel_files "$kernel_version"

. "./get-firmware.sh"
get_linux_firmware

repo_directory="$base_directory/.."
archive_directory="$repo_directory/out"
archive_name="$(basename "$save_directory").tar.gz"

mkdir -p "$archive_directory"

echo "Copying files and creating .tar archive..."
rsync -av --exclude="$archive_directory" "$repo_directory" "$save_directory"
tar --exclude-vcs -czvf "$archive_directory/$archive_name" -C "$save_directory" ./

echo "Done!

You can find the archive in the /out folder of this repository! Copy
this over to your Linux installation using an external drive.

Extract it there, and run 'offline-update-apply-blade-14.sh' to
complete the installation.
"
