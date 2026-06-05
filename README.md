# OrangeFox Recovery — Nubia RedMagic 10 Pro (NX789J)

> First working OrangeFox build for the RedMagic 10 Pro, including functional decryption.

![OrangeFox](https://img.shields.io/badge/OrangeFox-14.1-orange?style=flat-square)
![Device](https://img.shields.io/badge/Device-RedMagic%2010%20Pro-red?style=flat-square)
![Status](https://img.shields.io/badge/Status-Working-brightgreen?style=flat-square)
![Decryption](https://img.shields.io/badge/Decryption-Working-brightgreen?style=flat-square)

---

## Device Specifications

| Feature | Details |
|---------|---------|
| Device | Nubia RedMagic 10 Pro |
| Codename | NX789J |
| SoC | Snapdragon 8 Elite (sun) |
| Architecture | arm64 |
| A/B Partitions | Yes |
| Dynamic Partitions | Yes |
| Encryption | FBE (fscrypt policy 2) |
| Recovery Partition | Yes (`recovery_a` / `recovery_b`) |

---

## Status

| Feature | Status |
|---------|--------|
| OrangeFox UI | ✅ Working |
| Touch | ✅ Working |
| ADB | ✅ Working |
| Decryption (FBE) | ✅ Working |
| Flashing ZIPs | ✅ Working |
| Backup / Restore | ✅ Working |
| Fastbootd | ✅ Working |
| USB OTG | ✅ Working |
| Vibration | ⚠️ Disabled in recovery (not needed) |

---

## Notes

This device tree was converted from the TWRP tree and required several non-trivial fixes to get working on OFR 14.1 against Android 15 prebuilt binaries:

- VINTF manifest version downgraded from 9.0 → 1.0 for compatibility with `libvintf@8.0`
- System `keystore2` binary and libraries replaced with Android 15 versions pulled from the live system to fix decryption
- `init.recovery.qcom.rc` haptic service disabled to prevent ueventd firmware retry loop
- `vendor/orangefox` config path remapped to `vendor/twrp` (OFR 14.1 sync layout)
- ODM directory conflict in recovery root resolved
- `OF_TARGET_DEVICES` renamed to `FOX_TARGET_DEVICES`

---

## Building

### Requirements

- Ubuntu 20.04 / 22.04 / 24.04
- At least 16GB RAM
- At least 150GB free disk space
- OpenJDK 11

### Install dependencies

```bash
sudo apt update && sudo apt install -y \
  git curl wget python3 python-is-python3 \
  bc bison build-essential ccache flex \
  g++-multilib gcc-multilib gnupg gperf \
  imagemagick lib32ncurses-dev lib32readline-dev \
  lib32z1-dev lz4 libncurses-dev libsdl1.2-dev \
  libssl-dev libwxgtk3.2-dev libxml2-dev \
  libxml2-utils lzop pngcrush rsync schedtool \
  squashfs-tools xsltproc zip zlib1g-dev openjdk-11-jdk
```

### Sync OrangeFox source

```bash
git clone https://gitlab.com/OrangeFox/sync.git ~/OrangeFox_sync
cd ~/OrangeFox_sync
./orangefox_sync.sh --branch 14.1 --path ~/fox_14.1
```

### Place device tree

```bash
mkdir -p ~/fox_14.1/device/nubia
git clone https://github.com/YOUR_USERNAME/android_device_nubia_NX789J ~/fox_14.1/device/nubia/NX789J
```

### Build

```bash
cd ~/fox_14.1
source build/envsetup.sh
lunch orangefox_NX789J-ap2a-eng
mka adbd recoveryimage
```

Output will be at:
```
out/target/product/NX789J/recovery.img
```

---

## Flashing

> ⚠️ This device does **not** support `fastboot boot` or `fastboot flash recovery`. Use the method below.

### From a running recovery (TWRP or OrangeFox)

```bash
adb push recovery.img /sdcard/recovery.img
adb shell dd if=/sdcard/recovery.img of=/dev/block/bootdevice/by-name/recovery_a
adb shell dd if=/sdcard/recovery.img of=/dev/block/bootdevice/by-name/recovery_b
adb reboot recovery
```

### From Android (requires root)

```bash
adb push recovery.img /sdcard/recovery.img
adb shell su -c "dd if=/sdcard/recovery.img of=/dev/block/bootdevice/by-name/recovery_a"
adb shell su -c "dd if=/sdcard/recovery.img of=/dev/block/bootdevice/by-name/recovery_b"
adb reboot recovery
```

---

## Credits

- [OrangeFox Recovery Project](https://orangefox.download)
- [TeamWin (TWRP)](https://twrp.me) — original device tree base
- Converted and fixed by **YOUR_NAME**

---

## License

```
Copyright (C) 2025 The Android Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
```
