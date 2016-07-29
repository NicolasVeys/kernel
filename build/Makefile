export PATH := $(shell pwd)/../compiler/bin:$(PATH)
OS_NAME=OS
KERNEL_PATH=../src/kernel
GRUB_PATH=../src/grub
ASSEMBLER_PATH=../src/assembler
GCC=i686-elf-gcc
ASSEMBLER=i686-elf-as
GCC_FLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra
LINKER_FLAGS=-ffreestanding -O2 -nostdlib -lgcc

C_SOURCES=$(shell find $(KERNEL_PATH)/ -type f -name '*.c')
C_OBJECTS=$(shell basename $(C_SOURCES:.c=.c.o))

ASSEMBLER_SOURCES=$(shell find $(ASSEMBLER_PATH)/ -type f -name '*.s')
ASSEMBLER_OBJECTS=$(shell basename $(ASSEMBLER_SOURCES:.s=.s.o))

.PHONY: all clean

all: $(OS_NAME).iso

clean:
	rm -f *.o
	rm -f *.bin
	rm -rf iso/
	rm -f *.iso

%.c.o: $(KERNEL_PATH)/%.c
	$(GCC) $(GCC_FLAGS) -c -o $(shell basename $@) $^

%.s.o: $(ASSEMBLER_PATH)/%.s
	$(ASSEMBLER) -o $(shell basename $@) $^

kernel.bin: $(ASSEMBLER_OBJECTS) $(C_OBJECTS)
	i686-elf-gcc -T ../linker/linker.ld $(LINKER_FLAGS) -o $@ $^

$(OS_NAME).iso: kernel.bin
	grub-file --is-x86-multiboot kernel.bin
	rm -rf iso/
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/kernel.bin
	cp $(GRUB_PATH)/* iso/boot/grub/
	grub-mkrescue -o $@ iso/
