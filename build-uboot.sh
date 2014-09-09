#!/bin/sh

build_uboot ( ) {
	print_header "Build uboot at `date`"
	cd $UBOOT_DIR
	gmake SED=gsed HOSTCC=clang35 CROSS_COMPILE=${__CROSS_COMPILER_GCC} am335x_evm_config
	gmake SED=gsed HOSTCC=clang35 CROSS_COMPILE=${__CROSS_COMPILER_GCC}
}
