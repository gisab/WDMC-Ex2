# WD My Cloud Ex2 and EX2 Ultra with Debian Bullseye and OMV

Codename: WDMC-Ex2 WDMC-Ex2 Ultra

Repository: [github/gisab WDMC-Ex2](https://github.com/gisab/WDMC-Ex2)

### Steps to update your Linux Kernel for WD My Cloud Ex2

This Guide will explain you how to update your WD MyCloud Ex2 Device to be able to install any modern OS.
I tested this procedure with WD MyCloud Ex2, but can be adapted also for MyCloud Ex2 Ultra and (whith some abstraction guideline) to any WD Nas device.

The repository contain the image file for kernel v5.10.109.

There is no need to flash the native UBoot; you can load the new kernel on demand or by default keeping the original fw as it is, for safety and rollback procedure.

The procedure is not disruptive; you don't need to backup your data.

The procedure is articulated in these steps:
1.  Get access to the serial log on your device (note: this will break the warranty, noting that the the Ex2 is officially no more supported by WD)
2.  Prepare an HD/USB to store the bootable uImage file

The repository contains the file ready-to-go with Linux 5.10.109; however there is a section (see 3.kernel) explaining how to compile the kernel with another version and for another WD device.

## Support
+ USB or SATA drive 
+ ext2,3,4, btrfs
+ raid 0,1 and LVM
+ ssh-rescue shell

## References to other public projects
+ This site contains a lot of VUIs (very useful information): 
  https://wd.hides.su/wd/Ex2/WDMC-Ex2/
  https://wd.hides.su/wdnas.el8.website/WDMyCloud-Mirror/Developing/

## Credits:
+ @vzhilov https://github.com/vzhilov/WDMC-Ex2-Ultra.git
