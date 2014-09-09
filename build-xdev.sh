#!/bin/sh

build_xdev ( ) {
	print_header "Look for xdev at `date`"

	FREEBSD_XDEV_PREFIX=${XDEV_ARCH}-freebsd-
	XDEV_CC=${FREEBSD_XDEV_PREFIX}cc
	if [ -z `which ${XDEV_CC}` ]; then
		echo "Build xdev at `date`"
		cd $SRCROOT
		sudo make XDEV=arm XDEV_ARCH=armv6 xdev
	else
		echo "Found xdev with prefix ${FREEBSD_XDEV_PREFIX}"
	fi

}
