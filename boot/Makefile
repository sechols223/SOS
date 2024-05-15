BOOT_DIR ?= boot
BOOT ?= boot
BUILD_DIR ?= ../build
ASM ?= nasm
ASM_OUT ?= bin
IMG ?= boot.img


.PHONY: all clean build

build: $(BUILD_DIR)
	$(ASM) boot.asm -f $(ASM_OUT) -g -o $(BUILD_DIR)/boot.bin
	dd if=/dev/zero of=$(BUILD_DIR)/boot.img bs=512 count=2880

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

OUT_FILES := $(BUILD_DIR)/$(wildcard *.bin) $(BUILD_DIR)/$(wildcard, *.img) 

clean: $(OUT_FILES) 
	$(foreach var,$(OUT_FILES), echo $(var);)

all: clean build

