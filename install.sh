kver="$(make kernelversion)"

# Clean and import default config
make mrproper
zcat /proc/config.gz > .config
make olddefconfig
make nconfig

# Set versioning
./scripts/config --file .config --set-str LOCALVERSION "-point-arbor"
./scripts/config --file .config --disable CONFIG_LOCALVERSION_AUTO

# Build the kernel
make CC='ccache gcc' -j$(nproc) LOCALVERSION=

# Install modules
sudo make modules_install -j$(nproc)

# Install the kernel
sudo install -Dm644 "$(make -s image_name)" "/boot/vmlinuz-$kver-point-arbor"
sudo cp -vf System.map "/boot/System.map-$kver-point-arbor"
sudo cp -vf .config "/boot/config-$kver-point-arbor"

# Update initramfs and grub
sudo dracut "/boot/initramfs-$kver-point-arbor.img" "$kver-point-arbor" --force
sudo grub-mkconfig -o /boot/grub/grub.cfg
