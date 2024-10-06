## Instructions

The kernel does not depend on any new third-party libraries or tools, however, the install script does expect that you have `ccache` installed. It is highly recommended to install this, but the script will probably run anyway.

You may also want to do something like `ccache -M 2G`.

#### If you're on Arch with Grub and Dracut, simply run:

```
chmod +x install.sh
./install.sh
```

This will automatically clean mrproper, import your current config, build the kernel, install modules, build an initramfs, and install the kernel with minimal prompting for the user.

#### Otherwise

You may need to modify the install script according to your distro, tutorials are easy to come by so this shouldn't be too much of a hassle.