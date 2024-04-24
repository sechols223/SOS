#!/bin/bash

nasm boot.asm -f bin -o boot.bin

sudo dd if=/dev/zero of=boot.img bs=512 count=2880
sudo dd if=boot.bin of=boot.img
