# project-recovery


it is a anti bootloop porject,by using btrfs on rooted device's mod file
## How it works

1. **Input**: User provides the `init_boot.img` file extracted from their current system.
2. **Patching**: 
   * Uses `magiskboot` to unpack the `init_boot.img` and obtain `ramdisk.cpio`.
   * Uses `cpio` to unpack `ramdisk.cpio`.
   * Injects the custom `init` script to hijack the boot process.
   * Adds `busybox` into the `system/bin` directory inside the ramdisk.
3. **Repack**: Repacks everything back into a bootable `repack.img`.

## how my init work



## Third-Party Components & Licensing

This project is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

This repository includes pre-built binary dependencies:

* **magiskboot**
  * **License**: GNU General Public License v3.0 (GPL-3.0)
  * **Copyright**: Copyright (C) Uevo001 (Thylis Voraan)
  * **Source Code**: [Uevo001/magiskboot-linux@b8323c4](https://github.com/Uevo001/magiskboot-linux/commit/b8323c4f2f24c2a552c84b4b437dc40b50fe8485)
  * **Commit Hash**: `b8323c4`