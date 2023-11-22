CFLAGS	= -std=gnu99 -ffreestanding -O2 -Wall -Wextra
AS	= i686-elf-as
CC	= i686-elf-gcc

all: kernel boot
	$(CC) -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib \
		boot.o kernel.o -lgcc
	cp myos.bin isodir/boot/myos.bin
	grub-mkrescue -o myos.iso isodir

kernel: kernel.c
	$(CC) -c kernel.c -o kernel.o $(CFLAGS) 

boot: boot.s
	$(AS) boot.s -o boot.o
