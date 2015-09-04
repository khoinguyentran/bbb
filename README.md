bbb
===

FreeBSD Distribution - BeagleBone Black

Project goals
=============

To create a bootable FreeBSD SD-Card image with the base system and custom applications fulfill the following requirements:

- Maximum base system size of 50MB.
- Without the following facilities: accounting, printing, rescue, localization, unnecessary shared libraries, unnecessary USB peripheral drivers, unnecessary bus drivers.
- Partition scheme:
	- 2-MB FAT16 with u-boot
	- 50-MB UFS without SoftUpdate for /
	- 50-MB UFS with SoftUpdate for /usr
	- 10-MB tmpfs for /tmp
	- 50-MB UFS with SoftUpdate for /var
- Skippable build stages
- Unmount mddisk when done or when errors occur or when user interrupts
- Custom file system overlay
- Default root user with password root
- Enable root access via SSH
- Enable network interfae with DHCP
- All custom applications are dynamically linked when possible
