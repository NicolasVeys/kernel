.PHONY: all clean compiler run

all:
	cd build && make all

clean:
	cd build && make clean

compiler:
	cd compiler && make

run: all
	qemu-system-i386 -cdrom build/*.iso
