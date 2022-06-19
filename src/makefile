
coreloader:
	nasm -I ./boot/include -o ./loader.bin ./boot/loader.s
	nasm -I ./boot/include -o ./mbr.bin ./boot/mbr.s

asmlib:
	nasm -f elf -o print.o ./lib/kernel/print.s
# nasm -f elf -o stringio.o ./lib/kernel/stringio.s

CFLAGS =    -fno-builtin -W -Wstrict-prototypes \
                  -Wmissing-prototypes
				
OBJS= main.o \
		print.o \
		init.o
# init.o: kernel/init.c kernel/init.h 
# 		# lib/kernel/stdint.h  lib/kernel/print.h
# 	gcc $(CFLAGS) -I lib  $< -o $@


# clib: 
# 	gcc ${CFLAGS} -I lib   -m32    kernel/init.h  kernel/init.c     -o init.o
ccfile= kernel/main.c \
		kernel/init.c

default: coreloader asmlib   
	gcc ${CFLAGS} -I lib -m32 -c   ${ccfile}
	ld -m elf_i386 -Ttext 0xc0001500 -e main -o kernel.bin  ${OBJS}


install: default
	dd if=./mbr.bin of=../master.img bs=512 count=1 conv=notrunc
	dd if=./loader.bin of=../master.img bs=512 count=4 seek=2 conv=notrunc
	dd if=./kernel.bin of=../master.img bs=512 count=200 seek=9 conv=notrunc

clean:
	rm mbr.bin loader.bin kernel.bin
	rm main.o print.o

run: install
	cd .. && bochs -q


