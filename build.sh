#!/bin/bash
# based on the instructions from edk2-platform
#if throw error then exit
set -e

figlet Edk2-Dipper 

echo [BuildTools] Now Building UEFI_FV
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p XiaomiMI8Pkg/XiaomiMI8Pkg.dsc
echo [BuildTools] Done.

echo [BuildTools] Now Making boot.img
gzip -c < workspace/Build/XiaomiMI8Pkg/DEBUG_GCC5/FV/XIAOMIMI8PKG_UEFI.fd >uefi_img
cat troika.dtb >>uefi_img
# build Abooting Img
abootimg --create boot.img -k uefi_img -r ramdisk -f bootimg.cfg
rm -rf ./uefi_img
echo [BuildTools] Done.

echo [BuildTools] Now Making uefi.img
# build common
gzip -c < workspace/Build/XiaomiMI8Pkg/DEBUG_GCC5/FV/XIAOMIMI8PKG_UEFI.fd >uefi.img
cat troika.dtb >>uefi.img
echo [BuildTools] Done.

echo [BuildTools] Compile Finished, Enjoy It Now.
