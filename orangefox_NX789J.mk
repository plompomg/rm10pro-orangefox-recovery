#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nubia/NX789J

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Device identifier
PRODUCT_DEVICE := NX789J
PRODUCT_NAME := orangefox_NX789J
PRODUCT_BRAND := nubia
PRODUCT_MANUFACTURER := nubia
PRODUCT_MODEL := RedMagic 10 Pro

# Assert
TARGET_OTA_ASSERT_DEVICE := NX789J

# Fingerprint
BUILD_FINGERPRINT := nubia/NX789J-UN/NX789J:15/AQ3A.240812.002/RedMagicOS10.0.15_NX789J_GB:user/release-keys

# Theme
TW_STATUS_ICONS_ALIGN := center
