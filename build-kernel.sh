#!/bin/sh

. ./setenv.sh
. ./build-util.sh

build_kernel ( ) {
	print_header "Build kernel at `date`"
	make -C $SRCROOT __MAKE_CONF=$__MAKE_CONF KERNCONF=$__KERNCONF ${__BUILDKERNEL_EXTRA_ARGS} buildkernel
}
