# Welcome!

This repository has a collection of portable fixes for your Razer Blade 14 (2022) that runs an Ubuntu-derived Linux
operating system.

By default, you may run into Wi-Fi, Bluetooth, or microphone issues after installing a Linux distro on your Blade 14.
Use the tools I've included in this repository to fix these!

### What problems does this solve?

By default, your Linux installation may not be able to talk to your Blade 14's devices. Luckily, contributors to Linux
have implemented support for these. Making it all work is a matter of getting the right files included into your Linux
installation.

For example:

- **Wi-Fi and Bluetooth fix:** The Blade 14 comes with a Qualcomm Atheros QCNFA765 wireless adapter. This is the
  hardware that makes your Wi-Fi and Bluetooth work. A script in this repo can copy this firmware from the latest
  [Linux firmware git tree](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/) and install
  it to your device.
- **Microphone fix:** 6.2+ Linux kernel contains [support](https://bugzilla.kernel.org/show_bug.cgi?id=216801) for the
  Blade 14's built-in microphone array. A script in this repo can download and install a kernel version you specify.

### Recommended distributions for your Blade 14

To apply the fixes I've provided, you'll first need to install Linux on your Blade 14. Check out these distros:

#### [**Pop!_OS**](https://pop.system76.com/)
- Highly recommended! In my testing, this Linux distribution is very stable on the Blade 14
- Power management is good, with no issues with shutting down or suspending
- Hybrid graphics support out of the box
- Battery life: 8-9 hours of general use

#### [**Ubuntu**](https://ubuntu.com/)
- Classic, but will require more configuration than Pop!_OS to get your Blade 14's integrated / discrete graphics 
  working properly
- Power management out of the box is not great. I think this is due to the OS defaulting to using the dedicated GPU
  for all tasks
- You may run into problems with the device not suspending or powering off
- Installing [System76 Power Management](https://github.com/pop-os/system76-power) may address these issues, but I
  haven't attempted to do that!

# How to use

## ⚠️ Disclaimer

Before you start, please understand that everything in this repository are provided as-is. Use at your own risk. While
I've tested everything I've provided on a **Razer Blade 14 (RZ09-0427)** laptop running Pop!_OS and Ubuntu, I cannot
guarantee functionality across all combinations of hardware and distributions.

**Running this script may lead to unintended consequences, such as an inoperable operating system and/or permanent data
loss!** Continue on only if you understand and accept this risk. Please back up any important data before proceeding.

## Installation guide

Once you have Linux installed on your machine, you can get started.

Before you install anything, check to see if your Wi-Fi, Bluetooth, and microphone are functioning. If so, you don't
need to run these anything I've provided here unless you want the latest firmware and kernel!

If you decide to continue, follow one of the two options provided below.

### Option A: Online installation (recommended)

You will download and apply the updates while inside your Blade 14's Linux installation.

#### Requirements

<details>
<summary>Show requirements</summary>

* A Linux installation on your Blade 14
* Internet access via a wired connection (Ethernet)
    * Use a USB A- or USB C-to-Ethernet adapter, or
    * Use a USB hub with an RJ45 port

</details>

#### Installation steps

<details>
<summary>Show installation steps</summary>

Boot into Linux on your Blade 14 and establish a wired connection to the Internet.

First, you'll want to get a local copy of this repository. You can use the `git` command:

```shell
git clone https://github.com/OliverAbdulrahim/linux-fixes-blade-14.git
```

If you get a message like `git: command not found`, run the following:

```shell
sudo apt-get install git
```

You may need to use `chmod` to make the script you'll run next executable:

```shell
chmod +x linux-fixes-blade-14/scripts/online-update-complete.sh
```

Start the script with the following command:

```shell
sh linux-fixes-blade-14/scripts/online-update-complete.sh
````

Follow the on-screen instructions, which will guide you through the process. At the end, you'll reboot your Blade 14,
which completes the installation.
</details>

### Option B: Offline installation

You will generate an archive with everything you need while outside your Blade 14's Linux environment. Then, you will
transfer this archive to Linux, unpack it, and apply the updates.

#### Requirements

<details>
<summary>Show requirements</summary>

* A Linux installation on your Blade 14
* Another device or operating system with access to the Internet and the ability to run shell scripts
    * If you're using Windows, you can run the scripts
      with [Windows Subsystem For Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/faq)
    * You could use your Blade 14's default Windows installation with WSL
* Removable media (external drive, flash drive, or memory card) with at least 200MB of free space

</details>

#### Installation steps

<details>
<summary>Show installation steps</summary>

On a device that has an Internet connection, download this repository.

```shell
git clone https://github.com/OliverAbdulrahim/linux-fixes-blade-14.git
```

Alternatively, you can
[download a snapshot of this repository's main branch](https://github.com/OliverAbdulrahim/linux-for-blade-14/archive/refs/heads/main.zip)
and extract it.

You may need to use `chmod` to make the script you'll run next executable:

```shell
chmod +x linux-fixes-blade-14/scripts/offline-update-generate.sh
```

Next, build the archive by running the following command:

```shell
sh linux-fixes-blade-14/scripts/offline-update-generate.sh
```

Follow the on-screen instructions, which will guide you through the process.

Once complete, you'll have an archive at the directory `linux-for-blade-14/out/*.tar.gz`. transfer this archive to an
external drive, flash drive, or memory card.

```shell
cp out/*.tar.gz directory
```

Then, boot your Blade 14's Linux installation. Run this `tar` command to extract the files. Replace 'directory' with
where you stored the archive in your removable media. You can also use a GUI like Archive Manager to extract this, if
your distribution has one installed by default.

```shell
tar xvf directory/*.tar.gz
```

You may need to use `chmod` to make the script you'll run next executable:

```shell
chmod +x directory/scripts/offline-update-apply.sh
```

Finally, complete the installation with the following:

```shell
sh directory/scripts/offline-update-apply.sh
```

</details>

# FAQ

**Q: Why haven't you provided an archive containing the offline installation files?**

A: While I'll happily offer you the tools to get the Linux kernel and firmware from a secure source, I won't distribute
these files! Here's why:

* Licensing issues which may prohibit distributing Linux firmware and kernel files
* That aside, any files I package up will soon become outdated = potential security risks and compatibility issues

In short, please use the tools I've provided in this repository to get the latest kernel and firmware files yourself!
