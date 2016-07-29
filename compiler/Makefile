PREFIX=$(shell pwd)
TARGET=i686-elf
PATH="$(PREFIX)/bin:$(shell printenv PATH)"
CWD=$(shell pwd)
GCC_VERSION=6.1.0
BINUTILS_VERSION=2.26

.PHONY: all build environment

all: build

build: binutils gcc

environment:
	export PREFIX=$(PREFIX)
	export TARGET=$(TARGET)
	export PATH=$(PATH)
	mkdir -p $(PREFIX)

binutils-$(BINUTILS_VERSION).tar.gz: environment
	mkdir -p build/binutils
	wget ftp://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.gz
	tar -zxf binutils-$(BINUTILS_VERSION).tar.gz

gcc-$(GCC_VERSION).tar.gz: environment
	mkdir -p build/gcc
	wget ftp://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.gz
	tar -zxf gcc-$(GCC_VERSION).tar.gz

binutils: binutils-$(BINUTILS_VERSION).tar.gz
	cd $(CWD)/build/binutils && linux32 ../../binutils-$(BINUTILS_VERSION)/configure --target=$(TARGET) --prefix="$(PREFIX)" --with-sysroot --disable-nls --disable-werror
	cd $(CWD)/build/binutils && linux32 make
	cd $(CWD)/build/binutils && linux32 make install
	touch binutils

gcc: gcc-$(GCC_VERSION).tar.gz
	cd gcc-$(GCC_VERSION) && contrib/download_prerequisites
	cd $(CWD)/build/gcc && linux32 ../../gcc-$(GCC_VERSION)/configure --target=$(TARGET) --prefix="$(PREFIX)" --disable-nls --enable-languages=c,c++ --without-headers
	cd $(CWD)/build/gcc && linux32 make all-gcc
	cd $(CWD)/build/gcc && linux32 make all-target-libgcc
	cd $(CWD)/build/gcc && linux32 make install-gcc
	cd $(CWD)/build/gcc && linux32 make install-target-libgcc
	touch gcc

clean:
	rm -rf build
	rm -rf $(PREFIX)
	rm -rf gcc-$(GCC_VERSION)
	rm -rf binutils-$(BINUTILS_VERSION)
	rm binutils-$(BINUTILS_VERSION).tar.gz
	rm gcc-$(GCC_VERSION).tar.gz
