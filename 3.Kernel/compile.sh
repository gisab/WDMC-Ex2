#!/bin/bash -x
dts=armada-370-wdmc-mirror-gen1-gs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=6 zImage
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=6 $dts.dtb
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=6 modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=6 INSTALL_MOD_PATH=../output modules_install
cp arch/arm/boot/zImage zImage_and_dtb
cat arch/arm/boot/dts/$dts.dtb >> zImage_and_dtb
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n Kernel-v5.10.109 -d zImage_and_dtb uImage
