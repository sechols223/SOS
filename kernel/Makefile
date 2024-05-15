
BUILD_DIR ?= ../build
# Automatically generate lists of sources using wildcard.
C_SOURCES = $(wildcard kernel/*.c) $(wildcard include/*.c)
VPATH := kernel:include
HEADERS = $(wildcard *.h ) $(wildcard lib/*.h)

OBJ = $(patsubst %.c, $(BUILD_DIR)/%.o, $(notdir $(C_SOURCES)))	

os-image: $(BUILD_DIR)/sos.img

$(BUILD_DIR)/sos.img: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	cat $^ > $@

# Link kernel objects and convert to binary format.
$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/kernel.elf
	objcopy -O binary $< $@

$(BUILD_DIR)/kernel.elf: $(OBJ) $(BUILD_DIR)/enter-kernel.o
	@echo "Linking files: $(OBJ)"
	i686-elf-ld -melf_i386 -o $@ -Ttext 0x1000 $(OBJ) 

# Assemble kernel entry and other asm sources.
$(BUILD_DIR)/%.o: %.asm
	nasm $< -f elf -o $@

# Compile C sources.
$(BUILD_DIR)/%.o: %.c $(HEADERS)
	i686-elf-gcc -m32 -ffreestanding -c $< -o $@

clean:
	rm -f $(BUILD_DIR)/*.img
	rm -f $(BUILD_DIR)/*.bin
	rm -f $(BUILD_DIR)/*.o
	rm -f $(BUILD_DIR)/*.elf

.PHONY: all clean os-image
