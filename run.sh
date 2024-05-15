#!/bin/bash

set -e
. ./config.sh


run() {
  qemu-system-i386 -drive file=$BUILD_DIR/sos.img,format=raw \
    -boot c -net none -vga vmware \
    -monitor stdio \
    -d guest_errors,int
}


run
