#!/bin/bash

clean() {
  rm -rf *.bin
  rm -rf *.img
}

build() {
  nasm boot.asm -f bin -o boot.bin
  
  sudo dd if=/dev/zero of=boot.img bs=512 count=2880
  sudo dd if=boot.bin of=boot.img
  
}

run() {
  qemu-system-i386                                  \
    -no-reboot                                      \
    -drive format=raw,file=boot.img                 \
    -serial stdio                                   \
    -vga std
}


clean
build
run
