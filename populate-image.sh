#!/bin/sh

create_image ( ) {
	print_header "Create $IMG with size ${IMG_SIZE}MB at `date`"
	
	echo "Remove old $IMG"
	rm -rf $IMG
	echo "Create new $IMG"
	dd if=/dev/zero of=$IMG bs=1M count=$IMG_SIZE
}

populate_image ( ) {
	print_header "Populate $IMG at `date`"

	KERNEL=`realpath $MAKEOBJDIRPREFIX`/arm.armv6/`realpath $SRCROOT`/sys/$KERNCONF/kernel
	UBLDR=${UBLDR_DIR}/boot/ubldr

	echo "Create memory disk from $IMG"
	MDFILE=`mdconfig -a -f $IMG`

	echo "Create MBR table"
	gpart create -s MBR ${MDFILE}
	echo "Create bootable FAT partition"
	gpart add -a 63 -b ${FAT_START_BLOCK} -s ${BOOTPART_SIZE}m -t '!12' ${MDFILE}
	gpart set -a active -i 1 ${MDFILE}
	newfs_msdos -L boot -F 12 /dev/${MDFILE}s1

	echo "Populate boot partition"
	mount_msdosfs /dev/${MDFILE}s1 $MNT_DIR
	echo "Copy uboot"
	cp ${UBOOT_DIR}/MLO $MNT_DIR
	cp ${UBOOT_DIR}/u-boot.img $MNT_DIR/bb-uboot.img
	echo "Copy ubldr"
	cp $UBLDR $MNT_DIR/bbubldr
	echo "Copy dtb and dts"
	(cd $DTS_DIR; $DTC -I dts -O dtb -p 8192 -o $DTB_DIR/$DTB_NAME $DTS_DIR/$DTS_NAME)
	cp $DTB_DIR/$DTB_NAME $MNT_DIR
	echo "Unmount boot partition"
	umount $MNT_DIR

	echo "Create root partition"
	gpart add -t freebsd ${MDFILE}
	gpart create -s BSD ${MDFILE}s2
	gpart add -t freebsd-ufs ${MDFILE}s2
	newfs /dev/${MDFILE}s2a
	tunefs -n enable /dev/${MDFILE}s2a
	tunefs -j enable -S $(($UFS_JOURNAL_SIZE*1024*1024)) /dev/${MDFILE}s2a
	tunefs -N enable /dev/${MDFILE}s2a

	mount /dev/${MDFILE}s2a $MNT_DIR
	echo "Install kernel"
	make -C $SRCROOT DESTDIR=$MNT_DIR -DDB_FROM_SOURCE KERNCONF=$__KERNCONF __MAKE_CONF=$__MAKE_CONF ${__INSTALLKERNEL_EXTRA_ARGS} installkernel
	echo "Install world"
	make -C $SRCROOT SRCCONF=$__SRC_CONF DESTDIR=$MNT_DIR -DDB_FROM_SOURCE ${__INSTALLWORLD_EXTRA_ARGS} installworld
	echo "Install distribution"
	make -C $SRCROOT SRCCONF=$__SRC_CONF DESTDIR=$MNT_DIR -DDB_FROM_SOURCE ${__INSTALLWORLD_EXTRA_ARGS} distribution

	echo "Configure boot"
	cat > $MNT_DIR/boot/loader.rc << __EOF__
include /boot/loader.4th
start
check-password
__EOF__

	echo "Configure fstab"
	cat > $MNT_DIR/etc/fstab << __EOF__
/dev/mmcsd0s2a	/	ufs	rw,noatime	1	1
md	/tmp	mfs	rw,noatime,-s30m	0	0
md	/var/log	mfs	rw,noatime,-s15m	0	0
md	/var/tmp	mfs	rw,noatime,-s5m	0	0
__EOF__

	echo "Configure rc.conf"
	cat > $MNT_DIR/etc/rc.conf << __EOF__
hostname="mybbb"
ifconfig_cpsw0="DHCP"
sshd_enable="YES"
ntpd_enable="YES"
ntpd_sync_on_start="YES"
ntpdate_flags="-bug 0,us.pool.ntp.org"
fsck_y_enable="YES"
background_fsck="NO"
devd_enable="YES"

__EOF__

	umount $MNT_DIR

	echo "Clean up"
	mdconfig -d -u ${MDFILE}
}