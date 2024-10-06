kver="$(make kernelversion)"

make mrproper
zcat /proc/config.gz > .config
make olddefconfig
./scripts/config --file .config --set-str LOCALVERSION "-point-arbor"
make CC='ccache gcc' -j$(nproc)
sudo make modules_install -j$(nproc)
sudo install -Dm644 "$(make -s image_name)" "/boot/vmlinuz-$kver-point-arbor"
sudo cp -vf System.map "/boot/System.map-$kver-point-arbor"
sudo cp -vf .config "/boot/config-$kver-point-arbor"
sudo dracut "/boot/initramfs-$kver-point-arbor.img" "$kver-point-arbor" --force
sudo grub-mkconfig -o /boot/grub/grub.cfg
