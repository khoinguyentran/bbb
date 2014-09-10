#!/bin/sh

build_uboot ( ) {
	print_header "Build uboot at `date`"
	cd $UBOOT_DIR
	for p in `ls ${WORKSPACE}/uboot-patch/*.patch`; do
		echo "   Applying patch $p"
		if patch -N -p1 < $p; then
			true # success
		else
			echo "Patch didn't apply: $p"
			exit 1
		fi
	done

	gmake SED=gsed HOSTCC=clang35 CROSS_COMPILE=${__CROSS_COMPILER_GCC} am335x_evm_config
	gmake SED=gsed HOSTCC=clang35 CROSS_COMPILE=${__CROSS_COMPILER_GCC}
}
