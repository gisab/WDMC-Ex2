# How to compile the kernel by yourself

## Get all needed packages:
```
apt update
apt upgrade
apt install build-essential u-boot-tools libncurses5-dev git bison flex bc libssl-dev
apt install crossbuild-essential-armhf
```

## Download the kernel sources and patch the led gpio file

```
cd WDMC-Ex2/3.Kernel
git clone --depth 1 --branch v5.10.109 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-stable
```

Use patch to fix LED beheavor
```
cd linux-stable
patch -p1 < ../gpio_trigger.patch
```

## Copy prepared config file to linux directory
```
cp ../kernel.config .config
```

## Copy prepared Device Tree for WD MyCloud Ex2 (armada-370) or Ex2 Ultra (armada-385)
```
cp ../armada-370-wdmc-mirror-gen1-gs.dts linux-stable/arch/arm/boot/dts/
cp ../armada-385-wdmc-Ex2-Ultra.dts linux-stable/arch/arm/boot/dts/
```

## Start to compile the kernel 

### For WD MyCloud Ex2 (armada-370)
```
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 zImage
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 armada-370-wdmc-mirror-gen1-gs.dtb
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 modules
mkdir -p ../output
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../output modules_install
cp arch/arm/boot/zImage zImage_and_dtb
cat arch/arm/boot/dts/armada-370-wdmc-mirror-gen1-gs.dtb >> zImage_and_dtb
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n Kernel-v5.10.109 -d zImage_and_dtb uImage
```

### For WD MyCloud Ex2 Ultra (armada-385)
```
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 zImage
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 armada-385-wdmc-Ex2-Ultra.dtb
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 modules
mkdir -p ../output
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../output modules_install
cp arch/arm/boot/zImage zImage_and_dtb
cat arch/arm/boot/dts/armada-385-wdmc-Ex2-Ultra.dtb >> zImage_and_dtb
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n Kernel-v5.5.3 -d zImage_and_dtb uImage
```

## Finalise the setup

+ copy the uImage file in the `sda1` partition
+ copy the ../output/lib in the root of the `sda2` (or where your linux distribution is installed); this folder contains the kernel ko to be loaded at runtime by your new kernel
