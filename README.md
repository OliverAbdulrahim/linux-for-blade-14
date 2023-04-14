# Welcome!

This repository has a collection of fixes for your Razer Blade 14 (2022) that runs an Ubuntu-derived Linux operating
system.

By default, you may run into Wi-Fi, Bluetooth, or microphone issues after installing your Ubuntu-based distro. The
main script in this repository fixes issues these by updating your kernel and installing the required drivers.

### How does this fix my Blade 14?

By default, your Linux installation may be missing firmware that allows Linux to talk to your hardware. Luckily,
contributors to Linux have implemented support for the hardware inside your Blade 14.

For example:

- **Wi-Fi and Bluetooth fix:** The Blade 14 comes with a Qualcomm Atheros QCNFA765 wireless adapter. This is the
  hardware that makes your Wi-Fi and Bluetooth work. The main script in this repo copies this firmware from the
  [Linux firmare git tree](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/) and installs it
  to your device.
- **Microphone fix:** 6.2+ Linux kernel contains support for the Blade 14's built-in microphone array. The main script
  in this repo downloads and installs a kernel version you specify.

### Recommended distributions for your Blade 14

- [Pop!_OS](https://pop.system76.com/)
    - Highly recommended! In my testing, this Linux distribution is very stable on the Blade 14
    - Power management is good, with no issues with shutting down or suspending
    - Hybrid graphics support out of the box
    - Battery life: 8-9 hours of general use
- [Ubuntu](https://ubuntu.com/)
    - Classic, but will require more configuration than Pop!_OS to get your Blade 14's integrated / discrete graphics
      working properly
    - Power management out of the box is not great. I think this is due to the OS defaulting to using the dedicated GPU
      for all tasks
    - You may run into problems with the device not suspending or powering off
    - Installing [System76 Power Management](https://github.com/pop-os/system76-power) may address these issues, but I
      haven't attempted to do that!

# How to use

### Disclaimer

This script is provided as-is. Use at your own risk. While I've tested this on a Razer Blade 14 (2022) laptop running
Pop!_OS and Ubuntu, I can't guarantee that this will work on all devices and distributions. Please back up any important
data before proceeding.

### Getting started

First, you'll want to clone this repository. The following command will download the contents of this repository to your
computer:

```shell
git clone https://github.com/OliverAbdulrahim/linux-fixes-blade-14.git
```

If you get a message like `bash: git: command not found`, run the following:

```shell
sudo apt-get install git
```

Next, you'll want run this next command, which makes the main script executable:

```shell
chmod +x /linux-fixes-blade-14/update-blade-14.sh
```

Then, run the script with the following command:

```shell
sh /linux-fixes-blade-14/update-blade-14.sh
```

Follow the on-screen commands, which will guide you through the installation. At the end, you'll be asked to reboot your
machine. This completes the installation of the kernel update and firmware install.

Should you need the files this repository downloads again, you can always run them