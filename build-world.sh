#!/bin/sh

build_world ( ) {
	print_header "Build world at `date`"
	make -C $SRCROOT SRCCONF=${__BUILDWORLD_CONF} ${__BUILDWORLD_EXTRA_ARGS} buildworld
}
