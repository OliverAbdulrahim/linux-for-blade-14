# Welcome!

This repository has a collection of fixes for your Razer Blade 14 (2022) that runs an Ubuntu-derived Linux operating
system.

By default, you may run into Wi-Fi, Bluetooth, or microphone issues after installing your Ubuntu-based distro. Run the
main script in this repository just after installing Linux to fix these problems.

Note: you'll need access to the internet while running this fix main script.

## How does this fix my Blade 14?

By default, your Linux installation may be missing firmware that allows Linux to talk to your hardware. Luckily,
contributors to Linux have implemented support for the hardware inside your Blade 14.

For example:

- **Wi-Fi and Bluetooth fix:** The Blade 14 comes with a Qualcomm Atheros QCNFA765 wireless adapter. This is the
  hardware that makes your Wi-Fi and Bluetooth work. A script in this repo can copy this firmware from the
  [Linux firmware git tree](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/) and installs
  it to your device.
- **Microphone fix:** 6.2+ Linux kernel contains [support](https://bugzilla.kernel.org/show_bug.cgi?id=216801) for the
  Blade 14's built-in microphone array. A script in this repo can download and install a kernel version you specify.

## Getting started

### Recommended distributions for your Blade 14

To apply these fixes, you'll need to install Linux on your Blade 14. Check out these distros:
<details><summary>Show recommendations</summary>

- [**Pop!_OS**](https://pop.system76.com/)
    - Highly recommended! In my testing, this Linux distribution is very stable on the Blade 14
    - Power management is good, with no issues with shutting down or suspending
    - Hybrid graphics support out of the box
    - Battery life: 8-9 hours of general use

- [**Ubuntu**](https://ubuntu.com/)
    - Classic, but will require more configuration than Pop!_OS to get your Blade 14's integrated / discrete graphics
      working properly
    - Power management out of the box is not great. I think this is due to the OS defaulting to using the dedicated GPU
      for all tasks
    - You may run into problems with the device not suspending or powering off
    - Installing [System76 Power Management](https://github.com/pop-os/system76-power) may address these issues, but I
      haven't attempted to do that!

</details>

## Installation guide

Once you have Linux installed on your machine, you can get started.

Before you install anything, check to see if your Wi-Fi, Bluetooth, and microphone are functioning. If so, you don't
need to run these anything I've provided here unless you want the latest firmware and kernel!

If you decide to continue, follow one of two paths:

* **Online installation (recommended)** requires internet access via Ethernet while booted into Linux on your Blade 14
* **Offline installation** requires an internet connection on another device, or on another operating system on your
  Blade 14, like your default Windows installation

### ⚠️ Disclaimer

Before you start, please understand that the scripts in this repository are provided as-is. Use at your own risk. While
I've tested them on a Razer Blade 14 (RZ09-0427) laptop running Pop!_OS and Ubuntu, I can't guarantee that this will
work on all devices and distributions.

**Running this script may lead to permanent data loss!** Please back up any important data before proceeding.

### Online installation

<details>
<summary>Show steps</summary>

To complete these steps, you'll need an Ethernet connection with your Blade 14. Grab a USB A- or USB C-to-Ethernet
adapter or use a USB hub with an RJ45 port.

Boot into Linux on your Blade 14 and establish a wired connect to the internet.

First, you'll want to get a local copy of this repository. You can use the `git` command:

```shell
git clone https://github.com/OliverAbdulrahim/linux-fixes-blade-14.git
```

If you get a message like `bash: git: command not found`, run the following:

```shell
sudo apt-get install git
```

Next, you may need to run this next command, which makes the script you'll run next executable:

```shell
chmod +x linux-fixes-blade-14/scripts/update-blade-14.sh
```

Start the script with the following command:

```shell
sh linux-fixes-blade-14/scripts/update-blade-14.sh
````

Follow the on-screen commands, which will guide you through the installation. At the end, you'll be asked to reboot your
Blade 14. This completes the installation of the kernel update and firmware install.
</details>

### Offline installation

<details>
<summary>Show steps</summary>

On a device that has an internet connection, download this repository.

```shell
git clone https://github.com/OliverAbdulrahim/linux-fixes-blade-14.git
```

Alternatively, you can
[download a snapshot of this repository's main branch](https://github.com/OliverAbdulrahim/linux-for-blade-14/archive/refs/heads/main.zip)
and extract it.

Next, build the `tar.gz` archive by running the following command.

```shell
sh linux-fixes-blade-14/scripts/offline-update-generate.sh
```

If you're using Windows, you can run this shell script
with [Windows Subsystem For Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/faq).

Once complete, transfer this archive to an external drive, flash drive, or memory card.

```shell
# Replace directory with a path within your removable media
cp out/*.tar.gz directory
```

Then, boot your Blade 14's Linux installation. Run this `tar` command to extract the files:

```shell
# Replace directory with where you stored the archive in your removable media
tar xvf directory/*.tar.gz
```

Finally, complete the installation with the following:

```shell
sh directory/scripts/offline-update-apply.sh
```

</details>

# FAQ

Why haven't you provided an archive containing the offline installation files?
I don't want to distribute kernel files. Your kernel and firmware is critical to the operation of your device. I'll
happily offer you the tools to get the kernel files, but I won't package them up and distribute them.

