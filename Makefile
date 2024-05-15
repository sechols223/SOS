

BOOT_DIR ?= boot
BUILD_DIR ?= build
KERNEL_DIR ?= kernel


.PHONY: all clean build

build:
	$(MAKE) -C $(BOOT_DIR)
	$(MAKE) -C $(KERNEL_DIR)
		
	dd if=$(BUILD_DIR)/boot.bin of=$(BUILD_DIR)/boot.img conv=notrunc

clean:
	$(MAKE) -C $(BOOT_DIR) clean 
	$(MAKE) -C $(KERNEL_DIR) clean
	rm -f $(BUILD_DIR)/*.img

all: clean build
