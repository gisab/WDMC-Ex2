# UBoot: The funny part

If you reach this part of the procedure, this is the funny part :smile:

Uboot is the SW code executed by the chip in order to load the kernel.
It is quite good utility, altough the documentation is not the best asset.
You can find useful commands here: [Uboot User Manual](https://hub.digi.com/dp/path=/support/asset/u-boot-reference-manual/)

## Press `1`

If you want to have access to the Uboot procedure, you shall keep the button `1` pressed during the boot sequence.
If is important you check the reliability of the serial connection as describer in the [Section 1](../1.SerialCable/README.md)
```
Enable HD1
Enable HD2
Net:   egiga1
Warning: egiga1 MAC addresses don't match:
Address in SROM is         00:50:43:02:00:00
Address in environment is  00:50:43:02:02:00

Hit any key to stop autoboot:  0
Marvell>> 
```

## `bootcmd` and `bootargs`

The boot instruction is hardcoded in the `bootargs` and `bootcmd` variables; to see all variable use `printenv` command; to get help use `help`.
```
Marvell>> printenv bootargs
bootargs=root=/dev/ram console=ttyS0,115200 max_loop=32
Marvell>>
```
All changes you do on enviroment variable and loading new kernel here are not persistent, until you use `saveenv`; feel free to test your configuration.

## Loading your kernel from local hard disk

This is the siplest solution I found.

Plug your HD and create a small partition to store the uimage files; format it as FAT32 or Ext2.
To enable the SATA connection issue the command:
```
Marvell>> ide reset

Reset IDE:
Marvell Serial ATA Adapter
Integrated Sata device found
  Device 0 @ 0 0:      <=== means second socket
Model: XXXXXXXXXXX                              Firm: 000XXXXX Ser#:             XXXXXXXX
            Type: Hard Disk
            Supports 48-bit addressing
            Capacity: 238475.1 MB = 232.8 GB (488397168 x 512)

Marvell>>
```
Assuming the partition is the first one, you can see it with `ext2ls` (for ext2) or `fatls` (for fat32):
```
Marvell>> ext2ls ide 0:1
<DIR>       1024 .
<DIR>       1024 ..
<DIR>      12288 lost+found
         4062561 uimage
         4830114 uinitrd
             169 readme.txt
         4062565 uimage-5.10.109
Marvell>>

```

Load the kernel with the command `extload` or `fatload`:
```
ext2load ide 0:1 0x500000 /uimage 
```
Here the `0x500000` is the memory address to which you want uBoot to load your kernel. You can use also `0x2000000`
Be aware that this loading is not persisently wrote into the NAND.

Boot the kernel:
```
Marvell>> bootm 0x500000
## Booting image at 00500000 ...
## Booting kernel from Legacy Image at 00500000 ...
   Image Name:   Kernel-v5.10.109gs
   Created:      2022-03-30   5:50:20 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4062497 Bytes = 3.9 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00a00000 ...
   Image Name:   BusyBox v1.31
   Created:      2020-04-21  13:35:00 UTC
   Image Type:   ARM Linux RAMDisk Image (lzma compressed)
   Data Size:    4830050 Bytes = 4.6 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...
[...]
```
