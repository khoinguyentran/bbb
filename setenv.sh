#!/bin/sh

# External sources.
export SRCROOT=/home/nguyen/repo/freebsd_src
export __SRC_CONF=$WORKSPACE/src.conf
export __MAKE_CONF=$WORKSPACE/make.conf
export __BUILDWORLD_CONF=$WORKSPACE/buildworld.conf
export __INSTALLWORLD_CONF=$WORKSPACE/installworld.conf
export UBOOT_DIR=/home/nguyen/repo/u-boot-2013.04
export DTC=/home/nguyen/repo/dtc/dtc

# For kernel build.
export __KERNCONF=MYBBB
export __CROSS_TOOLCHAIN_PREFIX=/usr/armv6-freebsd/usr/bin/

# For u-boot build.
export __CROSS_COMPILER_GCC=arm-eabi-

# Post-build configuration.
export HOSTNAME=bbb
export BBB_ROOT_PASSWORD=root
export BBB_USER_NAME=nguyen
export BBB_USER_FULLNAME="Tran Khoi Nguyen"
export BBB_USER_PASSWORD=freemind

# Default configuration. Edit only when necessary.
export WORKSPACE=`realpath .`
export MAKEOBJDIRPREFIX=$WORKSPACE/build
export MAKESYSPATH=$SRCROOT/share/mk

export TARGET=arm
export TARGET_ARCH=armv6
export XDEV_ARCH=$TARGET_ARCH
export __BUILDKERNEL_EXTRA_ARGS=""
export __BUILDWORLD_EXTRA_ARGS="-DNO_CLEAN"
export __INSTALLKERNEL_EXTRA_ARGS=""
export __INSTALLWORLD_EXTRA_ARGS="-DNO_CLEAN SRCCONF=${__INSTALLWORLD_CONF}"

export UBLDR_DIR=$WORKSPACE/build/ubldr

export UBOOT=${UBOOT_DIR}/u-boot.bin
export UBOOT_IMG=${UBOOT_DIR}/u-boot.img

export DTS_DIR=$SRCROOT/sys/boot/fdt/dts/arm
export DTS_NAME=beaglebone-black.dts
export DTB_DIR=$WORKSPACE/build
export DTB_NAME=bboneblk.dtb

export IMG_NAME=bboneblk.img
export IMG_SIZE=512 # MB
export IMG=$WORKSPACE/$IMG_NAME
export MNT_DIR=/mnt
export UFS_JOURNAL_SIZE=4 # MB
export BOOTPART_SIZE=2 # MB
export FAT_START_BLOCK=63


