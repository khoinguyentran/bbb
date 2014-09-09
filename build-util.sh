#!/bin/sh

print_hline() {
	echo ------------------------------------------------------------
}

print_header() {
	print_hline
	echo ">>> $1 "
	print_hline
}

print_env() {
	print_hline
	echo "Environment for BBB build at `date`"
	print_hline
	echo WORKSPACE=$WORKSPACE
	echo SRCROOT=$SRCROOT
	echo KERNCONF=$__KERNCONF
	echo MAKEOBJDIRPREFIX=$MAKEOBJDIRPREFIX
	echo SRCCONF=$__SRC_CONF
	echo MAKECONF=$__MAKE_CONF
	echo UBLDR_DIR=$UBLDR_DIR
	echo DTSFILE=$DTS_DIR/$DTS_NAME
	echo DTBFILE=$DTB_DIR/$DTB_NAME
	echo IMG_NAME=$IMG_NAME
	echo IMG_SIZE=${IMG_SIZE}MB
	echo UBOOT_DIR=$UBOOT_DIR
}
