#!/bin/bash

export base_directory=$(dirname "$(readlink -f "$0")")

current_date=$(date +"%Y-%m-%d-%H:%M:%S")
export save_directory="/tmp/$current_date-blade-14-update"

echo "Creating $save_directory to store downloads..."
mkdir -p "$save_directory"

display_welcome_message() {
  clear
  # It's a cute kitty color ANSI text art
  cat cat.ansi.txt
  echo "
$(tput bold)Linux for your Blade 14!$(tput sgr0)

This script is provided as-is. Use at your own risk!

While I've tested this on a Razer Blade 14 (RZ09-0427) laptop running
Pop!_OS and Ubuntu, I can't guarantee that this will work on all devices
and distributions.

Running this script may lead to permanent data loss! Please back up any
important data before proceeding.
"
  read -rp "By pressing enter, you confirm that you understand this... " unused
}

update_packages() {
  echo -n "Updating package list and upgrading existing packages... "
  sudo apt-get -qq update
  sudo apt-get -qq upgrade
  echo "Done!"
  echo -n "Installing required packages... "
  sudo apt-get -qq install update-manager-core git
  echo "Done!"
}

prompt_reboot() {
  confirm "Reboot your system now? (y/n): " && sudo reboot
  echo "You will need to manually reboot your Blade 14 changes to take effect."
}

# from https://stackoverflow.com/a/3232082
confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
  [yY][eE][sS] | [yY])
    true
    ;;
  *)
    false
    ;;
  esac
}
