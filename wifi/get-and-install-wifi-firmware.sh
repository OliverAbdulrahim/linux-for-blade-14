# Get latest linux-firmware repository
git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

# Copy the ath11k driver (see https://wireless.wiki.kernel.org/en/users/drivers/ath11k/installation)
sudo cp -r linux-firmware/ath11k/ /lib/firmware/
rm -rf linux-firmware
