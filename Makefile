CROSS_PATH="$(shell pwd)/compiler/bin"
ASSEMBLER=$(CROSS_PATH)/i686-elf-as
COMPILER=$(CROSS_PATH)/i686-elf-gcc
COMPILER_FLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -c
LINK_FLAGS=-T linker/linker.ld -ffreestanding -O2 -nostdlib -lgcc

.PHONY: all clean env

all: build/kernel.bin

clean:
	rm -rf build/*

env:
	mkdir -p build/
	mkdir -p dist/
	export PATH=$(PATH)

build/boot.o: env
	$(ASSEMBLER) src/loader/boot.s -o build/boot.o

build/kernel.o: env
	$(COMPILER) $(COMPILER_FLAGS) src/kernel/kernel.c -o build/kernel.o

build/kernel.bin: build/boot.o build/kernel.o
	$(COMPILER) $(LINK_FLAGS) -o build/kernel.bin build/boot.o build/kernel.o

dist/OS.iso: env build/kernel.bin
	mkdir -p iso/boot/grub
	cp build/kernel.bin iso/boot/kernel.bin
	cp src/grub/* iso/boot/grub
	grub-mkrescue -o dist/OS.iso iso
	rm -rf iso/
