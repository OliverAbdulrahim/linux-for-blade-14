#!/usr/bin/env bash

download_kernel_files() {
  if [ -z "$1" ]; then
    echo "Error: you must specify a kernel version!"
    exit 1
  fi

  kernel_directory="$save_directory/kernel"
  mkdir -pv "$kernel_directory"

  echo -n "Downloading $1 kernel files... "
  base_url="https://kernel.ubuntu.com/~kernel-ppa/mainline/"
  url="${base_url}v${1}/amd64/"

  # Download kernel package files
  # -q: no output
  # -c: continue incomplete downloads
  # -r: recursively download files
  # -np: don't ascend to the parent directory
  # -nH: don't create a hostname-based directory structure
  # --no-directories: don't create directories for remote files
  # --reject-regex: reject incompatible kernel packages
  # -e robots=off: ignore the robots.txt file
  # --random-wait: randomize the wait between requests
  # -R: reject html files
  # -A: accept .deb files and checksum file
  wget -q -c -r -np -nH \
    --no-directories \
    --reject-regex '.*unsigned.*|.*lowlatency.*' \
    -e robots=off \
    --random-wait \
    -R html \
    -A deb,CHECKSUMS \
    -P "$kernel_directory" \
    "$url"
  echo "Done!"
}

install_kernel_files() {
  if [ -d "$1" ]; then
    echo "Installing kernel now... "
    cd "$1" || exit
    sudo dpkg -i *.deb
    cd - || exit
    echo "Complete!"
    echo "Please note that a reboot is required for the changes to take effect."
  else
    echo "Error: the given directory does not exist: '$1'"
  fi
}
