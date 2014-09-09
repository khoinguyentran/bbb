#!/bin/sh

# Exit on error.
set -e

. ./setenv.sh
. ./build-util.sh
. ./build-uboot.sh
. ./build-xdev.sh
. ./build-world.sh
. ./build-kernel.sh
. ./build-ubldr.sh
. ./populate-image.sh

# Print build environment.
print_env

echo ${__BUILDKERNEL_EXTRA_ARGS}
echo ${__BUILDWORLD_EXTRA_ARGS}

# Actual build.
build_xdev
#build_world
#build_kernel
#build_uboot
#build_ubldr
create_image
populate_image


