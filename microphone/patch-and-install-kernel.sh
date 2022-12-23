# Get stable 6.1.1 kernel version
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.1.1.tar.xz

# Extract it here
tar xvf linux-6.1.1.tar.xz

# Since we'll build the kernel, we'll need a few packages:
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

# Patch the quirk set file to include the Blade 14
cp acp6x-mach.c linux-6.1.1/sound/soc/amd/yc/
cd linux-6.1.1

# Copy the current kernel config
cp -v /boot/config-$(uname -r) .config

make menuconfig
make

# scripts/config --disable SYSTEM_TRUSTED_KEYS
# scripts/config --disable SYSTEM_REVOCATION_KEYS

sudo make modules_install
sudo make install
