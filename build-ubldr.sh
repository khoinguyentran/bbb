#!/bin/sh

build_ubldr ( ) {
	print_header "Build ubldr at `date`"
	
	buildenv=`make -C $SRCROOT TARGET_ARCH=${TARGET_ARCH} buildenvvars`
	
	rm -rf $UBLDR_DIR
	mkdir -p $UBLDR_DIR
	mkdir -p $UBLDR_DIR/boot/defaults

	eval $buildenv make -C $SRCROOT/sys/boot clean
	eval $buildenv make -C $SRCROOT/sys/boot CC=/usr/armv6-freebsd/usr/bin/cc UBLDR_LOADADDR=0x88000000 all
	(cd $SRCROOT/sys/boot/arm/uboot; eval $buildenv make UBLDR_LOADADDR=0x88000000 DESTDIR=$UBLDR_DIR/ BINDIR=boot NO_MAN=true install)
}


